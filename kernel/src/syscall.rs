use core::arch::asm;

use x86_64::{registers::model_specific::{LStar, SFMask, Star}, VirtAddr};

use crate::{gdt::GdtInfo, debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}, debug_println};

pub fn init(gdt_info: &GdtInfo) {
    // Setup syscall MSRs
    debug_println!(HEADING_PREFIX; "Setting up syscalls");

    Star::write(
        gdt_info.user_code_seg,
        gdt_info.user_data_seg,
        gdt_info.kernel_code_seg,
        gdt_info.kernel_data_seg
    ).unwrap();

    debug_println!(SUBHEADING_PREFIX; "Syscall entry at {:#X}", syscall_entry as u64);

    LStar::write(VirtAddr::new(syscall_entry as u64));
}

#[naked]
unsafe extern "C" fn syscall_entry() -> ! {
    asm! {
        "call {syscall_handler}",
        "sysret",
        syscall_handler = sym syscall_handler,
        options(noreturn)
    };
}

extern "C" fn syscall_handler() {
    debug_println!("In syscall handler!!");
}