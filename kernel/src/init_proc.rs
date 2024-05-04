use core::slice;

use xmas_elf::{program::{SegmentData, Type}, sections::ShType, ElfFile};

use crate::{debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}, debug_println, mem, MODULE_REQUEST};

// Virtual address where the init process is loaded
const LOAD_ADDR: u64 = 4096;

pub fn init() {
    debug_println!(HEADING_PREFIX; "Loading init process");

    // Get the init elf file
    let module_response = MODULE_REQUEST
        .get_response()
        .expect("Bootloader did not give us a module response");

    let modules = module_response.modules();

    assert!(!modules.is_empty(), "No boot modules provided, an init process boot module needs to be provided");

    let init_proc_module = modules[0];

    let init_proc_slice = unsafe { slice::from_raw_parts(init_proc_module.addr(), init_proc_module.size() as usize) };
    let init_proc_elf = ElfFile::new(init_proc_slice).unwrap();

    // Find the base address of the elf file and our load offset
    let prog_headers_loadable = || {
        init_proc_elf
            .program_iter()
            .filter(|header| header.get_type().unwrap() == Type::Load)
    };

    let base_addr = prog_headers_loadable().next().unwrap().virtual_addr(); // First loadable segment's vaddr is the lowest and also the base addr
    let load_offset = LOAD_ADDR - base_addr;

    debug_println!(SUBHEADING_PREFIX; "ELF base address: {base_addr:#X}");
    debug_println!(SUBHEADING_PREFIX; "Load offset: {load_offset:#X}");

    // Map process in
    debug_println!(SUBHEADING_PREFIX; "Mapping in init process");
    
    let top_level_pt = mem::new_top_level_pt().expect("Couldn't allocate top level page table for init process");

    debug_println!(SUBHEADING_PREFIX; "Top level page table created at {:#X}", top_level_pt as *const _ as usize);

    for header in prog_headers_loadable() {
        debug_println!("Map file region [{:#X}, {:#X}] to {:#X}", header.offset(), header.offset() + header.file_size(), header.virtual_addr() + load_offset);
    }

    // Perform relocations
    debug_println!(SUBHEADING_PREFIX; "Performing relocations");

    let rel_section = init_proc_elf
        .section_iter()
        .find(|section| section.get_type().unwrap() == ShType::Rel);

    let rela_section = init_proc_elf
        .section_iter()
        .find(|section| section.get_type().unwrap() == ShType::Rela);

    if let Some(section) = rel_section {
        debug_println!(SUBHEADING_PREFIX; "Processing `REL` section");
        // TODO
    }

    if let Some(section) = rela_section {
        debug_println!(SUBHEADING_PREFIX; "Processing `RELA` section");
        // TODO
    }
}