#![no_std]
#![no_main]

use core::panic::PanicInfo;

use sel4::BootInfo;

/// Kernel/root task entry point:
/// seL4 loads us and calls _start, passing the `BootInfo` struct
/// Standard x86_64 calling convention is used, so the BootInfo pointer is in `rdi`
/// 
/// The root task has no stack, so we'll set that up and immediately jump to kmain
/// 
/// References for the entire startup procedure:
/// 1) https://github.com/seL4/rust-sel4/blob/main/crates/sel4-root-task
/// 2) https://gitlab.com/robigalia/sel4-start
#[no_mangle]
pub extern "C" fn _start() -> ! {
    loop {}
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

pub extern "C" fn kmain(boot_info: *const BootInfo) {

}