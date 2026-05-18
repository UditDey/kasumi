//! All top-level kernel state lives here for tractability
//!
//! ### Ownership rules:
//! - Globally Synchronized:
//!     - [`PANIC_FLAG`], [`DEBUG_PRINTER`], [`PMM`] and [`KALLOC`]
//!     - Atomic or spinlocked
//!     - Can be acessed from any CPU safely
//!
//! - Written Once:
//!     - [`HHDM_OFFSET`], [`KERNEL_PML4`], [`IDT`] and [`LAPIC_TIMER_FREQ_KHZ`]
//!     - Written once by BSP in [`kmain()`](crate::kmain)
//!     - From that point they're read-only
//!
//! - Manually Synchronized:
//!     - Have their own custom ownership rules that must be manually maintained
//!
//! ### Manual Rules:
//! - [`CPU_LOCALS`]:
//!     - Each CPU owns its own [`CpuLocal`] through the GS pointer. CPUs never ever touch another CPU's `CpuLocal`

use core::cell::{Cell, RefCell, UnsafeCell};
use core::sync::atomic::{AtomicBool, Ordering};

use arrayvec::ArrayVec;
use limine::response::MpResponse;
use spinning_top::Spinlock;

use x86_64::{
    PhysAddr, PrivilegeLevel, VirtAddr,
    instructions::tables::load_tss,
    registers::segmentation::{CS, DS, GS, SS, Segment, Segment64},
    structures::{
        gdt::{Descriptor, GlobalDescriptorTable, SegmentSelector},
        idt::InterruptDescriptorTable,
        tss::TaskStateSegment,
    },
};

use crate::{
    debug_print::{DebugPrinter, HEADING},
    debug_println,
    kalloc::{Box, KAlloc, KAllocLocalCache},
    pmm::{self, PmmLocalCache},
    pmm::{Pmm, SMALL_PAGE_SIZE},
    sched::{Pid, Process, SchedQueue, Thread},
    util::{Arc, HandleTable},
    vmm::{self, FAULT_STACK_PAGES, KERNEL_STACK_PAGES},
};

pub const MAX_CPUS: usize = 128;

// GDT consts
pub const GDT_USER_DATA_SEGMENT: SegmentSelector = SegmentSelector::new(1, PrivilegeLevel::Ring3);
pub const GDT_USER_CODE_SEGMENT: SegmentSelector = SegmentSelector::new(2, PrivilegeLevel::Ring3);
pub const GDT_KERNEL_CODE_SEGMENT: SegmentSelector = SegmentSelector::new(3, PrivilegeLevel::Ring0);
pub const GDT_KERNEL_DATA_SEGMENT: SegmentSelector = SegmentSelector::new(4, PrivilegeLevel::Ring0);
pub const GDT_TSS_SEGMENT: SegmentSelector = SegmentSelector::new(5, PrivilegeLevel::Ring0);

// Globally Synchronized State
pub static PANIC_FLAG: AtomicBool = AtomicBool::new(false);
pub static DEBUG_PRINTER: Spinlock<Option<DebugPrinter>> = Spinlock::new(None);
pub static PMM: Spinlock<Option<Pmm>> = Spinlock::new(None);
pub static KALLOC: Spinlock<KAlloc> = Spinlock::new(KAlloc::new());
pub static PROCESSES: Spinlock<HandleTable<Pid, Arc<Process>>> = Spinlock::new(HandleTable::new());

// Written Once State
pub static HHDM_OFFSET: Once<VirtAddr> = Once::uninit();
pub static KERNEL_PML4: Once<PhysAddr> = Once::uninit();
pub static IDT: Once<InterruptDescriptorTable> = Once::uninit();
pub static LAPIC_TIMER_FREQ_KHZ: Once<u64> = Once::uninit();
pub static SCHED_QUEUES: Once<ArrayVec<Spinlock<SchedQueue>, MAX_CPUS>> = Once::uninit();

// Manually Synchronized State
pub static CPU_LOCALS: Once<ArrayVec<CpuLocal, MAX_CPUS>> = Once::uninit();

pub fn init_cpu_locals(mp_resp: &MpResponse) {
    let cpus = mp_resp.cpus();

    debug_println!(HEADING; "{} CPUs found", cpus.len());
    assert!(cpus.len() <= MAX_CPUS, "Number of CPUs exceeds MAX_CPUS");

    // Init CpuLocals, we have to init in two steps because CpuLocal::init() wants a &'static mut Self
    // So we first setup empty static CpuLocals then init() them
    // SAFETY: Called from BSP in `kmain()`
    let cpu_locals = unsafe { CPU_LOCALS.get_mut() };
    *cpu_locals = ArrayVec::new();

    for _ in 0..cpus.len() {
        cpu_locals.push(CpuLocal::empty());
    }

    for (i, (limine_cpu, cpu_local)) in cpus.iter().zip(cpu_locals).enumerate() {
        // Point each limine cpu struct's extra field to its CpuLocal
        // Will be used later to load into GS
        limine_cpu
            .extra
            .store(cpu_local as *const CpuLocal as u64, Ordering::Release);

        // Actually init each CpuLocal
        cpu_local.init(i, limine_cpu.lapic_id);
    }

    // Init scheduler run queues
    // SAFETY: Called from BSP in `kmain()`
    let sched_queues = unsafe { SCHED_QUEUES.get_mut() };
    *sched_queues = ArrayVec::new();

    for _ in 0..cpus.len() {
        sched_queues.push(Spinlock::new(SchedQueue::new()));
    }
}

pub struct CpuLocal {
    pub cpu_index: usize,
    pub lapic_id: u32,
    pub gdt: GlobalDescriptorTable,
    pub tss: TaskStateSegment,
    pub kernel_stack_rsp: u64,

    pub pmm_cache: RefCell<PmmLocalCache>,
    pub kalloc_cache: RefCell<KAllocLocalCache>,
    pub sched_curr_thread: Cell<Option<Box<Thread>>>,
    pub syscall_user_rsp: u64,
}

unsafe impl Sync for CpuLocal {}
unsafe impl Send for CpuLocal {}

impl CpuLocal {
    const fn empty() -> Self {
        Self {
            cpu_index: 0,
            lapic_id: 0,
            gdt: GlobalDescriptorTable::empty(),
            tss: TaskStateSegment::new(),
            kernel_stack_rsp: 0,
            pmm_cache: RefCell::new(PmmLocalCache::new()),
            kalloc_cache: RefCell::new(KAllocLocalCache::new()),
            sched_curr_thread: Cell::new(None),
            syscall_user_rsp: 0,
        }
    }

    pub fn init(&'static mut self, cpu_index: usize, lapic_id: u32) {
        self.cpu_index = cpu_index;
        self.lapic_id = lapic_id;

        // Each CPU needs a kernel stack and an NMI stack
        fn alloc_stack_pages<const N: usize>() -> [PhysAddr; N] {
            let pages = core::array::from_fn(|_| {
                pmm::alloc_small_direct().expect("Failed to alloc stack page")
            });

            // Zero through HHDM
            for page in pages {
                unsafe {
                    let page_virt = pmm::phys_to_hhdm(page);
                    core::ptr::write_bytes(page_virt.as_mut_ptr::<u8>(), 0, SMALL_PAGE_SIZE);
                }
            }

            pages
        }

        let kernel_stack_pages: [PhysAddr; KERNEL_STACK_PAGES] = alloc_stack_pages();
        let nmi_stack_pages: [PhysAddr; FAULT_STACK_PAGES] = alloc_stack_pages();

        for (i, page) in kernel_stack_pages.iter().enumerate() {
            vmm::map_kernel_stack_page(cpu_index, i, *page);
        }

        for (i, page) in nmi_stack_pages.iter().enumerate() {
            vmm::map_fault_stack_page(cpu_index, i, *page);
        }

        // Set up TSS
        self.tss.privilege_stack_table[0] = vmm::kernel_stack_rsp(cpu_index);
        self.tss.interrupt_stack_table[0] = vmm::fault_stack_rsp(cpu_index);

        self.kernel_stack_rsp = vmm::kernel_stack_rsp(cpu_index).as_u64();

        // Set up GDT (matches the KERNEL_GDT_* consts above)
        self.gdt.append(Descriptor::user_data_segment());
        self.gdt.append(Descriptor::user_code_segment());
        self.gdt.append(Descriptor::kernel_code_segment());
        self.gdt.append(Descriptor::kernel_data_segment());
        //self.gdt.append(Descriptor::tss_segment(&self.tss));
    }

    pub fn load_gdt(&self) {
        unsafe {
            let p = self as *const CpuLocal;
            debug_println!("{:p}", p);
            //debug_println!("self      = {:X?}", self as *const Self);
            //debug_println!("self.gdt  = {:p}", &self.gdt);
            //debug_println!("self.tss  = {:p}", &self.tss);
            //self.gdt.load_unsafe();
            // load_tss(GDT_TSS_SEGMENT);
            //CS::set_reg(GDT_KERNEL_CODE_SEGMENT);
            //DS::set_reg(GDT_KERNEL_DATA_SEGMENT);
            //SS::set_reg(GDT_KERNEL_DATA_SEGMENT);
        }
    }

    /// Gets the current CPU's local data (stored in GS base)
    pub fn this() -> &'static Self {
        unsafe { GS::read_base().as_ptr::<CpuLocal>().as_ref().unwrap() }
    }
}

/// Wrapper type for "written once then read-only" kernel state
pub struct Once<T>(UnsafeCell<T>);

unsafe impl<T: Send + Sync> Sync for Once<T> {}

impl<T> Once<T> {
    pub const fn uninit() -> Self {
        unsafe { Self(UnsafeCell::new(core::mem::zeroed())) }
    }

    /// ### SAFETY:
    /// Must be called exactly once from BSP in `kmain()` to initialize the value
    pub unsafe fn get_mut(&self) -> &mut T {
        unsafe { self.0.get().as_mut().unwrap() }
    }

    pub fn get(&self) -> &T {
        unsafe { &*self.0.get() }
    }
}
