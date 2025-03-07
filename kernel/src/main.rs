#![no_std]
#![no_main]
// Enable all lint groups except restriction
#![deny(
    clippy::all,
    clippy::correctness,
    clippy::suspicious,
    clippy::style,
    clippy::complexity,
    clippy::perf,
    clippy::pedantic
)]
// Lints from the restrictions group
#![deny(
    clippy::as_underscore,
    clippy::deref_by_slicing,
    clippy::else_if_without_else,
    clippy::empty_enum_variants_with_brackets,
    clippy::empty_structs_with_brackets,
    clippy::float_arithmetic,
    clippy::fn_to_numeric_cast_any,
    clippy::if_then_some_else_none,
    clippy::indexing_slicing,
    clippy::map_err_ignore,
    clippy::pattern_type_mismatch,
    clippy::tests_outside_test_module,
    clippy::todo,
    clippy::unwrap_used
)]
// Relax some lints
#![warn(clippy::empty_loop, reason = "Empty loops can be useful while debugging so reduce that to a warning")]

mod cpuid;
mod debug_print;
mod heap;
mod page_alloc;
mod util;

use core::panic::PanicInfo;

use limine::{
    request::{FramebufferRequest, HhdmRequest, MemoryMapRequest},
    BaseRevision,
};

use x86_64::instructions::{hlt, interrupts::disable as disable_interrupts};

use crate::debug_print::HEADING;

// Limine bootloader requests
#[used]
pub static BASE_REVISION: BaseRevision = BaseRevision::with_revision(1);
#[used]
pub static HHDM_REQUEST: HhdmRequest = HhdmRequest::new();
#[used]
pub static FRAMEBUFFER_REQUEST: FramebufferRequest = FramebufferRequest::new();
#[used]
pub static MEM_MAP_REQUEST: MemoryMapRequest = MemoryMapRequest::new();

/// Kernel entry point
#[no_mangle]
extern "C" fn _start() -> ! {
    disable_interrupts();
    assert!(BASE_REVISION.is_supported());

    debug_print::init();
    debug_println!(HEADING; "Kernel started");
    cpuid::check();
    heap::init();

    loop {
        hlt();
    }
}

#[panic_handler]
fn rust_panic(info: &PanicInfo) -> ! {
    debug_println!("\n**** KERNEL PANIC ****\n");
    debug_print!("Kernel panic occured at: ");

    match info.location() {
        Some(location) => debug_println!("{location}"),
        None => debug_println!("(no location available)"),
    }

    debug_println!("\nMessage: {}", info.message());
    disable_interrupts();

    loop {
        hlt();
    }
}
