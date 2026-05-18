use core::arch::naked_asm;
use core::sync::atomic::AtomicBool;

use limine::response::ModuleResponse;

use spinning_top::Spinlock;
use x86_64::{
    VirtAddr,
    instructions::{hlt, interrupts::enable as sti},
    structures::paging::PageTableFlags,
};

use crate::{
    debug_print::{HEADING, SUBHEADING},
    debug_println,
    kalloc::Box,
    make_handle,
    pmm::{self, SMALL_PAGE_SIZE},
    state::{CpuLocal, GDT_USER_CODE_SEGMENT, GDT_USER_DATA_SEGMENT, PROCESSES, SCHED_QUEUES},
    util::{Arc, Handle, HandleTable, LinkedList},
    vmm::{self, AddressSpace},
};

pub const SCHED_QUANTUM_MS: u64 = 20;

const USER_INIT_RFLAGS: u64 = 0x202; // IF (bit 9) + reserved (bit 1)

make_handle!(Tid);
make_handle!(Pid);

/// A userspace process
///
/// This is a container for process state shared by all threads belonging to it.
/// Each thread has a pointer to its owning `Process`, therefore all `Process`
/// fields should be read-only or internally synchronized
pub struct Process {
    pid: Pid,
    address_space: AddressSpace,
    resources: Spinlock<ProcessResources>,
}

/// Resources belonging to a process, keyed by handles
pub struct ProcessResources {
    threads: HandleTable<Tid, Arc<ThreadMailbox>>,
}

/// A userspace thread belonging to a process
///
/// Threads are the primary objects managed by the scheduler. Each thread holds
/// a referance to its mailbox, and to its owning process (to access process
/// shared state)
///
/// In addition `Thread` also contains space for its previously saved context.
/// When the scheduler does a context switch, it saves the current thread's
/// state into `ctx` for later resumption
pub struct Thread {
    pub tid: Tid,
    pub proc: Arc<Process>,
    pub mailbox: Arc<ThreadMailbox>,
    pub ctx: SavedContext,
}

/// Thread signalling mechanism
///
/// When one thread wants to issue a signal to another thread in the same
/// process, it goes through `Process` and stores a value in the other
/// thread's mailbox
///
/// Currently only one signal (kill) is supported
pub struct ThreadMailbox {
    kill: AtomicBool,
}

impl Process {
    fn new(pid: Pid, address_space: AddressSpace) -> Self {
        Self {
            pid,
            address_space,
            resources: Spinlock::new(ProcessResources::new()),
        }
    }
}

impl ProcessResources {
    pub fn new() -> Self {
        Self {
            threads: HandleTable::new(),
        }
    }
}

impl Thread {
    fn new(tid: Tid, proc: Arc<Process>, mailbox: Arc<ThreadMailbox>) -> Self {
        Self {
            tid,
            proc,
            mailbox,
            ctx: SavedContext::new(),
        }
    }
}

impl ThreadMailbox {
    pub fn new() -> Self {
        Self {
            kill: AtomicBool::new(false),
        }
    }
}

#[repr(C, packed)]
#[derive(Default, Debug, Clone)]
pub struct SavedContext {
    // General purpose registers (pushed by interrupt entry asm)
    pub r15: u64,
    pub r14: u64,
    pub r13: u64,
    pub r12: u64,
    pub r11: u64,
    pub r10: u64,
    pub r9: u64,
    pub r8: u64,
    pub rbp: u64,
    pub rdi: u64,
    pub rsi: u64,
    pub rdx: u64,
    pub rcx: u64,
    pub rbx: u64,
    pub rax: u64,

    // Interrupt frame (pushed by CPU, popped by iretq)
    pub rip: u64,
    pub cs: u64,
    pub rflags: u64,
    pub rsp: u64,
    pub ss: u64,
}

impl SavedContext {
    fn new() -> Self {
        Self {
            rip: vmm::EXECUTABLE_BASE.as_u64(),
            rsp: vmm::thread_stack_rsp(0),
            rflags: USER_INIT_RFLAGS,
            cs: GDT_USER_CODE_SEGMENT.0 as u64,
            ss: GDT_USER_DATA_SEGMENT.0 as u64,
            ..Default::default()
        }
    }
}

/*pub struct ExtendedContext {
    fs_base: u64,
    gs_base: u64,
    xsave: (),
}*/

pub struct SchedQueue {
    runnable: LinkedList<Box<Thread>>,
}

impl SchedQueue {
    pub fn new() -> Self {
        Self {
            runnable: LinkedList::new(),
        }
    }
}

/// Simple round-robin per-cpu scheduler loop
///
/// Called by the LAPIC timer's interrupt handler
pub fn sched_tick(ctx: &mut SavedContext) {
    let cpu_local = CpuLocal::this();

    // Get this CPU's current thread and scheduler queue
    let curr_thread = cpu_local.sched_curr_thread.take();
    let mut sched_queue = SCHED_QUEUES.get()[cpu_local.cpu_index].lock();

    // Try popping the next runnable thread
    let next_thread = sched_queue.runnable.pop_front();

    match (curr_thread, next_thread) {
        // Nothing to do
        (None, None) => {}

        // Transition out of idle
        (None, Some(next)) => {
            next.proc.address_space.load();
            *ctx = next.ctx.clone();
            cpu_local.sched_curr_thread.set(Some(next));
        }

        // Current thread is our only thread, keep it
        (Some(curr), None) => cpu_local.sched_curr_thread.set(Some(curr)),

        // Full context switch
        (Some(mut curr), Some(next)) => {
            let new_addr_space = next.proc.address_space != curr.proc.address_space;

            // Save current thread
            curr.ctx = ctx.clone();
            sched_queue.runnable.push_back(curr);

            // Load next thread
            if new_addr_space {
                next.proc.address_space.load();
            }
            *ctx = next.ctx.clone();
            cpu_local.sched_curr_thread.set(Some(next))
        }
    };
}

pub fn start_pid0(module: &ModuleResponse) -> ! {
    debug_println!(HEADING; "Starting PID0:");

    // Create address space
    let addr_space = AddressSpace::new();

    // Map PID0 to USER_CODE_BASE
    let pid0 = module
        .modules()
        .first()
        .expect("Limine's module list is empty");

    let pid0_phys = pmm::hhdm_to_phys(VirtAddr::new(pid0.addr().addr() as u64));
    let num_pages = (pid0.size() as usize).div_ceil(SMALL_PAGE_SIZE);

    debug_println!(SUBHEADING; "PID0 module at 0x{:X} physical spanning {} page(s)", pid0_phys, num_pages);

    /*vmm::address_space_map_contig(
        pml4,
        USER_CODE_BASE,
        pid0_phys,
        num_pages,
        PageTableFlags::USER_ACCESSIBLE,
    );*/

    // Create init process and thread
    let address_space = AddressSpace::new();

    // Create the process in the global process table
    let process = PROCESSES
        .lock()
        .insert(|pid| Arc::new(Process::new(pid, address_space)))
        .map(|(_, proc)| Arc::clone(proc))
        .unwrap();

    // Allocate a mailbox in the process' resources
    let (tid, mailbox) = process
        .resources
        .lock()
        .threads
        .insert(|_| Arc::new(ThreadMailbox::new()))
        .map(|(tid, mailbox)| (tid, Arc::clone(mailbox)))
        .unwrap();

    // Create the thread
    let thread = Box::new(Thread::new(tid, Arc::clone(&process), mailbox));

    // Enqueue the thread on the current CPU
    CpuLocal::this().sched_curr_thread.set(Some(thread));

    // Run the thread
    process.address_space.load();
    start_idle();
    //jump_to_userspace();
}

pub fn start_idle() -> ! {
    sti();

    loop {
        hlt();
    }
}

#[unsafe(naked)]
extern "C" fn jump_to_userspace() -> ! {
    naked_asm! {
        "mov rbx, 0",
        "mov rcx, 0",
        "mov rdx, 0",
        "mov rsi, 0",
        "mov rdi, 0",
        "mov rbp, 0",
        "mov r8,  0",
        "mov r9,  0",
        "mov r10, 0",
        "mov r11, 0",
        "mov r12, 0",
        "mov r13, 0",
        "mov r14, 0",
        "mov r15, 0",
        "mov rax, {user_ss}",       // Build an interrupt stack frame
        "push rax",
        "mov rax, {user_rsp}",
        "push rax",
        "mov rax, {user_rflags}",
        "push rax",
        "mov rax, {user_cs}",
        "push rax",
        "mov rax, {user_rip}",
        "push rax",
        "mov rax, 0",
        "iretq",                    // Jump to userspace
        user_ss = const GDT_USER_DATA_SEGMENT.0,
        user_rsp = const vmm::thread_stack_rsp(0),
        user_rflags = const USER_INIT_RFLAGS,
        user_cs = const GDT_USER_CODE_SEGMENT.0,
        user_rip = const vmm::EXECUTABLE_BASE.as_u64()
    }
}
