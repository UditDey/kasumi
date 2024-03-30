#![no_std]
#![no_main]

use core::arch::global_asm;
use core::panic::PanicInfo;

use sel4::BootInfo;

// Kernel/root task entry point:
// seL4 loads us and calls _start, passing the `BootInfo` struct
// Standard x86_64 calling convention is used, so the BootInfo pointer is in `rdi`
// 
// The root task has no stack, so we'll set that up and immediately jump to kmain
// 
// References for the entire startup procedure:
// 1) https://github.com/seL4/rust-sel4/blob/main/crates/sel4-root-task
// 2) https://github.com/seL4/rust-sel4/blob/main/crates/sel4-runtime-common
// 3) https://gitlab.com/robigalia/sel4-start
global_asm! {
    r#"
        .global _start
        .equ stack_size, 1024 * 64 // 64 KiB stack

        .section .bss
        .lcomm kernel_stack_top, stack_size
        kernel_stack_bottom:

        .section .text
        _start:
            lea rsp, kernel_stack_bottom
            lea rbp, kernel_stack_bottom

            // *const BootInfo is still in rdi, we just pass it on
            call kmain
    "#
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle]
pub extern "C" fn kmain(boot_info: *const BootInfo) -> ! {
    sel4::debug_println!("Hello World!");
    loop {}
}