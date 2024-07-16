#![no_std]
#![no_main]
#![feature(integer_atomics)]
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
    clippy::allow_attributes_without_reason,
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
    clippy::multiple_unsafe_ops_per_block,
    clippy::pattern_type_mismatch,
    clippy::tests_outside_test_module,
    clippy::todo,
    clippy::undocumented_unsafe_blocks,
    clippy::unwrap_used
)]
#![warn(
    clippy::empty_loop,
    reason = "Empty loops can be useful while debugging so reduce that to a warning"
)]
#![allow(
    clippy::struct_field_names,
    reason = "Sometimes fields having common prefixes is useful (See PageAlloc)"
)]

mod cpuid;
mod debug_print;
mod mem;

use core::fmt::Write;
use core::panic::PanicInfo;

use limine::{
    request::{FramebufferRequest, HhdmRequest, MemoryMapRequest},
    BaseRevision,
};

use x86_64::instructions::{
    hlt, interrupts::disable as disable_interrupts, interrupts::enable as enable_interrupts,
};

use debug_print::{DebugPrintHelper, HEADING_PREFIX};

// Limine bootloader requests
//
// These static structs contain magic constants, which limine will search for
// in the kernel's memory region. Limine will then update these structs with
// 'responses' before handing over control to us
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
    // Disable interrupts (just to be sure)
    disable_interrupts();

    // Make sure limine supports our required base revision
    assert!(BASE_REVISION.is_supported());

    // Get the base address of the higher-half direct map (HHDM)
    //
    // Limine will map the first 4 GiB to somewhere within the higher-half
    // so the kernel can access memory outside itself. We use the HHDM to
    // access the framebuffer, ACPI structures, MMIO, etc. We later expand
    // the HHDM to cover all physical memory but the offset remains the same
    let _hhdm_offset = HHDM_REQUEST
        .get_response()
        .expect("Bootloader did not give us an HHDM response")
        .offset();

    // Start setting everything up
    debug_print::init();
    debug_println!(HEADING_PREFIX; "Kernel started");

    cpuid::check();
    mem::init();

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

    _ = write!(DebugPrintHelper, "\nMessage: {}", info.message());

    disable_interrupts();

    loop {
        hlt();
    }
}
