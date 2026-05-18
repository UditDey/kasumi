//! Virtual memory functionality
//!
//! This module provides functions to set up the kernel address space (higher half mapping of
//! kernel) and per-process address spaces (that share the higher half kernel address space)
//!
//!
//! ## [`KERNEL_PML4`] setup
//! This is the kernel address space containing:
//! 1. Kernel sections (text, rodata, data)
//! 2. Higher Half Direct Mapping (HHDM)
//! 3. Per-CPU kernel and fault stacks
//!
//! ```
//! ┌────────────────────────────┐  <──── 0xFFFF_0000_0000_0000 or above (HHDM Offset)
//! │                            │  ─┐
//! │                            │   │
//! │                            │   │
//! │ Higher Half Direct Mapping │   ├─── Max 192 TiB
//! │                            │   │
//! │                            │   │
//! │                            │  ─┘
//! ├────────────────────────────┤  <──── 0xFFFF_C000_0000_0000 (STACK_REGION_BASE)
//! │                            │
//! │         Guard Page         │
//! │                            │
//! ├────────────────────────────┤
//! │                            │  ─┐
//! │  Kernel Stack (for CPU 0)  │   ├─── KERNEL_STACK_PAGES * 4 KiB
//! │                            │  ─┘
//! ├────────────────────────────┤
//! │                            │
//! │         Guard Page         │
//! │                            │
//! ├────────────────────────────┤
//! │                            │  ─┐
//! │   Fault Stack (for CPU 0)  │   ├─── FAULT_STACK_PAGES * 4 KiB
//! │                            │  ─┘
//! ├────────────────────────────┤
//!
//!                ┊                <──── Stacks for CPU 1, 2, 3, etc
//!
//! ├────────────────────────────┤  <──── 0xFFFF_FFFF_8000_0000 (Kernel Base)
//! │                            │  ─┐
//! │                            │   │
//! │                            │   │
//! │           Kernel           │   ├─── Max 2 GiB
//! │                            │   │
//! │                            │   │
//! │                            │  ─┘
//! └────────────────────────────┘  <──── 0xFFFF_FFFF_FFFF_FFFF (Top of address space)
//! ```
//!
//! ### Higher Half Direct Mapping (HHDM)
//! Direct mapping of physical memory using 1 GiB huge pages starting from address 0. The HHDM base
//! address is kept identical to the HHDM mapping done by Limine for simplicity (provided by HHDM_REQUEST).
//! Limine's HHDM address may be randomized (ASLR) but we have to ensure that it is within higher
//! half and sufficiently below [`STACK_REGION_BASE`].
//!
//! The size of the HHDM mapping depends on the boot memory map (which gives us the highest usable
//! physical address) but the max size is bounded by `STACK_REGION_BASE` at 192 TiB
//!
//! ### Per-CPU stacks
//! Each CPU needs a kernel stack (to service syscalls and interrupts) and a fault stack (to service
//! double faults). Double fault gets its own stack because kernel stack can overflow into guard page
//! and cause a double fault. If the fault is then serviced on the same broken stack, a triple fault
//! ensues.
//!
//! The per-CPU stacks section begins at `STACK_REGION_BASE`. The initial `rsp` of CPU `i`s stacks
//! can be calculated as:
//! - `kernel_stack_region(i) = STACK_REGION_BASE + i * SMALL_PAGE_SIZE * (KERNEL_STACK_PAGES + FAULT_STACK_PAGES + 2)`
//! - `kernel_stack_rsp(i) = kernel_stack_region(i) + SMALL_PAGE_SIZE * (KERNEL_STACK_PAGES + 1)`
//! - `fault_stack_rsp(i) = kernel_stack_region(i) + SMALL_PAGE_SIZE * (KERNEL_STACK_PAGES + FAULT_STACK_PAGES + 2)`
//!
//!
//! ## Per-process [`AddressSpace`]
//! Every process gets its own `AddressSpace`. The higher half of every address space is copied from
//! `KERNEL_PML4` (i.e. kernel is mapped into higher half of every process).
//!
//! The lower half of every address space contains:
//! 1. Executable area
//! 2. Heap
//! 3. Per-thread stacks
//!
//! ```
//! ┌────────────────────────────┐  <──── 0x0
//! │                            │  ─┐
//! │         Null Guard         │   ├─── 4 MiB
//! │                            │  ─┘
//! ├────────────────────────────┤  <──── 0x40_0000
//! │                            │  ─┐
//! │                            │   │
//! │                            │   │
//! │         Executable         │   ├─── Max 3 GiB
//! │                            │   │
//! │                            │   │
//! │                            │  ─┘
//! ├────────────────────────────┤  <──── 0x1_0000_0000
//! │                            │  ─┐
//! │                            │   │
//! │                            │   │
//! │            Heap            │   ├─── Max 64 TiB
//! │                            │   │
//! │                            │   │
//! │                            │  ─┘
//! ├────────────────────────────┤
//!
//!                ┊                <──── Stacks for Thread 1, 2, 3, etc
//!
//! ├────────────────────────────┤
//! │                            │
//! │         Guard Page         │
//! │                            │
//! ├────────────────────────────┤
//! │                            │  ─┐
//! │     Stack (for thread 0)   │   ├─── MAX_THREAD_STACK_PAGES * 4 KiB
//! │                            │  ─┘
//! ├────────────────────────────┤  <──── 0x7FFF_FFFF_FFFF (top of lower half)
//!
//!                ┊
//!
//! ├────────────────────────────┤  <──── 0xFFFF_0000_0000_0000 or above (HHDM Offset)
//! │                            │
//! │                            │
//! │                            │
//! │         Higher Half        │
//! │        Kernel Mapping      │
//! │                            │
//! │                            │
//! └────────────────────────────┘  <──── 0xFFFF_FFFF_FFFF_FFFF (Top of address space)
//! ```
//!
//! ### Per-thread stack
//! Starting from top of lower half of the address space, each thread part of the process gets a
//! stack region growing downwards. The initial `rsp` of thread `i`s stack can be computed as:
//! - `thread_stack_rsp(i) = 0x8000_0000_0000 - i * SMALL_PAGE_SIZE * (MAX_THREAD_STACK_PAGES + 1)`
//!

mod address_space;
mod init;

pub use address_space::AddressSpace;
pub use init::{init_kernel_pml4, load_kernel_pml4, map_fault_stack_page, map_kernel_stack_page};

use x86_64::{
    PhysAddr, VirtAddr,
    structures::paging::{PageTable, PageTableFlags as Flags, PageTableIndex},
};

use crate::{
    pmm::{self, HUGE_PAGE_ALIGN, LARGE_PAGE_ALIGN, SMALL_PAGE_ALIGN, SMALL_PAGE_SIZE},
    state::KERNEL_PML4,
};

// Higher half kernel mapping items
const STACK_REGION_BASE: VirtAddr = VirtAddr::new(0xFFFF_C000_0000_0000);
pub const KERNEL_STACK_PAGES: usize = 4;
pub const FAULT_STACK_PAGES: usize = 1;

// Per-process address space items
pub const EXECUTABLE_BASE: VirtAddr = VirtAddr::new(0x40_000);
pub const HEAP_BASE: VirtAddr = VirtAddr::new(0x1_0000_0000);
pub const MAX_THREAD_STACK_PAGES: usize = 512; // 2 MiB max stack size per thread

// Address space indexing fns
fn kernel_stack_region(cpu_index: usize) -> VirtAddr {
    STACK_REGION_BASE
        + (cpu_index * SMALL_PAGE_SIZE * (KERNEL_STACK_PAGES + FAULT_STACK_PAGES + 2)) as u64
}

pub fn kernel_stack_rsp(cpu_index: usize) -> VirtAddr {
    kernel_stack_region(cpu_index) + (SMALL_PAGE_SIZE * (KERNEL_STACK_PAGES + 1)) as u64
}

pub fn fault_stack_rsp(cpu_index: usize) -> VirtAddr {
    kernel_stack_region(cpu_index)
        + (SMALL_PAGE_SIZE * (KERNEL_STACK_PAGES + FAULT_STACK_PAGES + 2)) as u64
}

pub const fn thread_stack_rsp(thread_index: usize) -> u64 {
    (0x8000_0000_0000 - thread_index * SMALL_PAGE_SIZE * (MAX_THREAD_STACK_PAGES + 1)) as u64
}

/// Function that allocates a page
///
/// Used for choosing between pmm::alloc_small_direct (before CpuLocal setup)
/// and pmm::alloc_small (after CpuLocal setup)
type AllocSmallFn = fn() -> Option<PhysAddr>;

/// Allocates a page table (ie small page), zeros it and returns its physical addr
fn alloc_zeroed_table(alloc_small: AllocSmallFn) -> PhysAddr {
    let page = alloc_small().expect("Failed to allocate small page for VMM");
    let page_virt = pmm::phys_to_hhdm(page);

    // SAFETY: We own the brand new page
    unsafe {
        core::ptr::write_bytes(page_virt.as_mut_ptr::<u8>(), 0, SMALL_PAGE_SIZE);
    }

    page
}

/// Follows a page table to the next level, allocating a table if absent
fn walk_down(
    alloc_small: AllocSmallFn,
    table: &mut PageTable,
    index: PageTableIndex,
) -> &mut PageTable {
    let entry = &mut table[index];

    if entry.is_unused() {
        let child = alloc_zeroed_table(alloc_small);
        let flags = Flags::PRESENT | Flags::WRITABLE | Flags::USER_ACCESSIBLE; // Intermediate tables are maximally permissive

        entry.set_addr(child, flags);
    }

    // Access the child table through HHDM
    let addr = pmm::phys_to_hhdm(entry.addr());

    // SAFETY: The child table is logically owned by the current table, which we also own
    unsafe { addr.as_mut_ptr::<PageTable>().as_mut().unwrap() }
}

fn map_small(
    alloc_small: AllocSmallFn,
    pml4: &mut PageTable,
    virt_page: VirtAddr,
    phys_page: PhysAddr,
    flags: Flags,
) {
    assert!(virt_page.is_aligned(SMALL_PAGE_ALIGN as u64));
    assert!(phys_page.is_aligned(SMALL_PAGE_ALIGN as u64));

    let pml3 = walk_down(alloc_small, pml4, virt_page.p4_index());
    let pml2 = walk_down(alloc_small, pml3, virt_page.p3_index());
    let pml1 = walk_down(alloc_small, pml2, virt_page.p2_index());

    pml1[virt_page.p1_index()].set_addr(phys_page, flags | Flags::PRESENT);
}

fn map_large(
    alloc_small: AllocSmallFn,
    pml4: &mut PageTable,
    virt_page: VirtAddr,
    phys_page: PhysAddr,
    flags: Flags,
) {
    assert!(virt_page.is_aligned(LARGE_PAGE_ALIGN as u64));
    assert!(phys_page.is_aligned(LARGE_PAGE_ALIGN as u64));

    let pml3 = walk_down(alloc_small, pml4, virt_page.p4_index());
    let pml2 = walk_down(alloc_small, pml3, virt_page.p3_index());

    pml2[virt_page.p2_index()].set_addr(phys_page, flags | Flags::PRESENT | Flags::HUGE_PAGE);
}

fn map_huge(
    alloc_small: AllocSmallFn,
    pml4: &mut PageTable,
    virt_page: VirtAddr,
    phys_page: PhysAddr,
    flags: Flags,
) {
    assert!(virt_page.is_aligned(HUGE_PAGE_ALIGN as u64));
    assert!(phys_page.is_aligned(HUGE_PAGE_ALIGN as u64));

    let pml3 = walk_down(alloc_small, pml4, virt_page.p4_index());

    pml3[virt_page.p3_index()].set_addr(phys_page, flags | Flags::PRESENT | Flags::HUGE_PAGE);
}

fn get_kernel_pml4() -> &'static PageTable {
    let phys = *KERNEL_PML4.get();
    let virt = pmm::phys_to_hhdm(phys);

    // SAFETY: Only called after BSP kmain() finished, read-only now
    unsafe { virt.as_ptr::<PageTable>().as_ref().unwrap() }
}

fn get_kernel_pml4_mut() -> &'static mut PageTable {
    let phys = *KERNEL_PML4.get();
    let virt = pmm::phys_to_hhdm(phys);

    // SAFETY: Only called from BSP in kmain(), we own the PML4
    unsafe { virt.as_mut_ptr::<PageTable>().as_mut().unwrap() }
}
