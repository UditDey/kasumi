#![no_std]
#![no_main]

#![feature(panic_info_message)]

mod debug;

use core::panic::PanicInfo;

use limine::{
    BaseRevision,
    request::{FramebufferRequest, StackSizeRequest, MemoryMapRequest}
};

const KERNEL_STACK_SIZE: u64 = 128 * 1024; // 128 KiB

// Limine bootloader requests
#[used] pub static BASE_REVISION: BaseRevision = BaseRevision::new();
#[used] pub static FRAMEBUFFER_REQUEST: FramebufferRequest = FramebufferRequest::new();
#[used] pub static STACK_REQUEST: StackSizeRequest = StackSizeRequest::new().with_size(KERNEL_STACK_SIZE);
#[used] pub static MEM_MAP_REQUEST: MemoryMapRequest = MemoryMapRequest::new();

// Kernel entry point
#[no_mangle]
unsafe extern "C" fn _start() -> ! {
    assert!(BASE_REVISION.is_supported());

    debug::init_debug_print();
    debug_println!("[kernel] Kernel Started");

    let mem_map = MEM_MAP_REQUEST.get_response().expect("No memory map given by the bootloader");

    debug_print!("[kernel] Memory map:");

    for (i, entry) in mem_map.entries().iter().enumerate() {
        debug_println!("\nEntry {i}:");
        debug_println!("\tbase: {}", entry.base);
        debug_println!("\tlength: {}", entry.length);
        debug_println!("\tentry_type: {:?}", entry.entry_type);
    }

    halt();
}

#[panic_handler]
fn rust_panic(info: &PanicInfo) -> ! {
    debug_println!("\n**** KERNEL PANIC ****\n");
    
    debug_print!("Kernel panic occured at: ");

    match info.location() {
        Some(location) => debug_println!("{location}"),
        None => debug_println!("(no location available)")
    }

    debug_print!("\nMessage: ");

    match info.message() {
        Some(msg) => debug::debug_print_helper(*msg),
        None => debug_println!("(no message)")
    }

    halt();
}

fn halt() -> ! {
    x86_64::instructions::interrupts::disable();

    loop {
        x86_64::instructions::hlt();
    }
}