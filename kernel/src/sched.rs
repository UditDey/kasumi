use core::slice;

use spinning_top::Spinlock;
use x86_64::structures::paging::PageTable;

use crate::{mem, debug_println, debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}};

#[repr(C)]
#[derive(Default)]
struct RegisterContext {
    rsp: u64,
    rbp: u64,
    rax: u64,
    rbx: u64,
    rcx: u64,
    rdx: u64,
    rsi: u64,
    rdi: u64,
    r8: u64,
    r9: u64,
    r10: u64,
    r11: u64,
    r12: u64,
    r13: u64,
    r14: u64,
    r15: u64,
}

struct ThreadContext<'a> {
    reg: RegisterContext,
    top_level_page_table: &'a mut PageTable,
    runnable: bool
}

struct SchedulerState<'a> {
    thread_list: &'a mut [Option<ThreadContext<'a>>],
    head: usize
}

impl<'a> SchedulerState<'a> {
    pub const fn dummy() -> Self {
        Self { thread_list: &mut [], head: 0 }
    }
}

const INIT_THREAD_LIST_SIZE: usize = mem::PAGE_SIZE as usize / core::mem::size_of::<Option<ThreadContext>>();

static SCHEDULER_STATE: Spinlock<SchedulerState> = Spinlock::new(SchedulerState::dummy());

pub fn init(hhdm_offset: usize) {
    // Set up the scheduler state
    debug_println!(HEADING_PREFIX; "Setting up scheduler");

    // Allocate frame for initial thread list
    let frame = mem::alloc_frame().expect("Could not allocate frame for initial thread list");
    debug_println!(SUBHEADING_PREFIX; "Creating initial thread list at {frame:#X}");

    let frame = frame as usize + hhdm_offset;
    let thread_list = unsafe { slice::from_raw_parts_mut(frame as *mut Option<ThreadContext>, INIT_THREAD_LIST_SIZE) };

    // Initialize thread list
    thread_list.fill_with(|| None);

    let sched_state = SchedulerState { thread_list, head: 0 };

    *SCHEDULER_STATE.lock() = sched_state;
}