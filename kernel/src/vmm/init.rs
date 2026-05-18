use limine::response::{ExecutableAddressResponse, MemoryMapResponse};

use x86_64::{
    PhysAddr, VirtAddr,
    registers::control::{Cr3, Cr3Flags},
    structures::paging::{PageTable, PageTableFlags as Flags, PhysFrame},
};

use crate::{
    debug_print::{HEADING, SUBHEADING},
    debug_println,
    pmm::{self, HUGE_PAGE_SIZE, SMALL_PAGE_ALIGN, SMALL_PAGE_SIZE},
    state::KERNEL_PML4,
};

use super::{
    KERNEL_STACK_PAGES, alloc_zeroed_table, get_kernel_pml4_mut, kernel_stack_region, map_huge,
    map_small,
};

// Kernel section markers, defined in link.ld
unsafe extern "C" {
    static __text_start: u8;
    static __text_end: u8;
    static __rodata_start: u8;
    static __rodata_end: u8;
    static __data_start: u8;
    static __data_end: u8;
}

/// Prepares the [`KERNEL_PML4`] page tables with HHDM and kernel sections mapped in
pub fn init_kernel_pml4(
    kernel_addr_resp: &ExecutableAddressResponse,
    mem_map_resp: &MemoryMapResponse,
) {
    debug_println!(HEADING; "Setting up kernel higher-half mappings:");

    // Have to use direct because CpuLocal not set up yet
    let alloc_small = pmm::alloc_small_direct;

    // Allocate PML4
    let pml4_phys_addr = alloc_zeroed_table(alloc_small);
    let pml4_addr = pmm::phys_to_hhdm(pml4_phys_addr);

    // SAFETY: We own this brand new table
    let pml4 = unsafe { pml4_addr.as_mut_ptr::<PageTable>().as_mut().unwrap() };

    // SAFETY: Called from kmain()
    unsafe {
        *KERNEL_PML4.get_mut() = pml4_phys_addr;
    }

    // Map HHDM
    let max_phys = mem_map_resp
        .entries()
        .iter()
        .map(|entry| (entry.base + entry.length) as usize)
        .max()
        .expect("Mem map is empty");

    let num_hhdm_pages = max_phys.div_ceil(HUGE_PAGE_SIZE);

    debug_println!(SUBHEADING; "Mapping HHDM: {} huge page(s) starting at 0x{:X}", num_hhdm_pages, pmm::hhdm_offset());

    for i in 0..num_hhdm_pages {
        let virt = pmm::hhdm_offset() + (i * HUGE_PAGE_SIZE) as u64;
        let phys = i * HUGE_PAGE_SIZE;

        map_huge(
            alloc_small,
            pml4,
            virt,
            PhysAddr::new(phys as u64),
            Flags::WRITABLE | Flags::GLOBAL | Flags::NO_EXECUTE,
        );
    }

    // Map kernel sections
    let text_start_addr = (&raw const __text_start).addr();
    let text_end_addr = (&raw const __text_end).addr();
    let rodata_start_addr = (&raw const __rodata_start).addr();
    let rodata_end_addr = (&raw const __rodata_end).addr();
    let data_start_addr = (&raw const __data_start).addr();
    let data_end_addr = (&raw const __data_end).addr();

    assert!(text_start_addr.is_multiple_of(SMALL_PAGE_ALIGN));
    assert!(text_end_addr.is_multiple_of(SMALL_PAGE_ALIGN));
    assert!(rodata_start_addr.is_multiple_of(SMALL_PAGE_ALIGN));
    assert!(rodata_end_addr.is_multiple_of(SMALL_PAGE_ALIGN));
    assert!(data_start_addr.is_multiple_of(SMALL_PAGE_ALIGN));
    assert!(data_end_addr.is_multiple_of(SMALL_PAGE_ALIGN));

    let mut map_section = |start_addr, end_addr, flags| {
        let num_pages = (end_addr - start_addr) / SMALL_PAGE_SIZE;

        let virt_base = kernel_addr_resp.virtual_base() as usize;
        let phys_base = kernel_addr_resp.physical_base() as usize;

        for i in 0..num_pages {
            let virt = start_addr + i * SMALL_PAGE_SIZE;
            let phys = phys_base + (virt - virt_base);

            map_small(
                alloc_small,
                pml4,
                VirtAddr::new(virt as u64),
                PhysAddr::new(phys as u64),
                flags,
            );
        }
    };

    map_section(text_start_addr, text_end_addr, Flags::GLOBAL); // R-X
    map_section(
        rodata_start_addr,
        rodata_end_addr,
        Flags::GLOBAL | Flags::NO_EXECUTE, // R--
    );
    map_section(
        data_start_addr,
        data_end_addr,
        Flags::GLOBAL | Flags::WRITABLE | Flags::NO_EXECUTE, // RW-
    );
}

/// Maps one page of a CPU's kernel stack into [`KERNEL_PML4`]
pub fn map_kernel_stack_page(cpu_index: usize, page_index: usize, page: PhysAddr) {
    let pml4 = get_kernel_pml4_mut();
    let base = kernel_stack_region(cpu_index);

    let virt = base + ((1 + page_index) * SMALL_PAGE_SIZE) as u64;

    map_small(
        pmm::alloc_small_direct,
        pml4,
        virt,
        page,
        Flags::WRITABLE | Flags::NO_EXECUTE | Flags::GLOBAL,
    );
}

/// Maps one page of a CPU's fault stack into [`KERNEL_PML4`]
pub fn map_fault_stack_page(cpu_index: usize, page_index: usize, page: PhysAddr) {
    let pml4 = get_kernel_pml4_mut();
    let base = kernel_stack_region(cpu_index);

    let virt = base + ((1 + KERNEL_STACK_PAGES + 1 + page_index) * SMALL_PAGE_SIZE) as u64;

    map_small(
        pmm::alloc_small_direct,
        pml4,
        virt,
        page,
        Flags::WRITABLE | Flags::NO_EXECUTE | Flags::GLOBAL,
    );
}

/// Loads [`KERNEL_PML4`] into `cr3`
pub fn load_kernel_pml4() {
    let pml4 = *KERNEL_PML4.get();

    unsafe {
        Cr3::write(
            PhysFrame::from_start_address(pml4).unwrap(),
            Cr3Flags::empty(),
        );
    }
}
