#![no_std]
#![no_main]

#![feature(panic_info_message)]
#![feature(abi_x86_interrupt)]
#![feature(const_mut_refs)]
#![feature(naked_functions)]

mod debug_print;
mod cpu_info;
mod gdt;
mod acpi;
mod interrupt;
mod timer;
mod mem;
mod syscall;
mod sched;
mod init_proc;

use core::panic::PanicInfo;

use limine::{
    BaseRevision,
    request::{
        FramebufferRequest,
        MemoryMapRequest,
        HhdmRequest,
        RsdpRequest,
        StackSizeRequest,
        ModuleRequest
    }
};

use x86_64::instructions::{
    hlt,
    interrupts::disable as disable_interrupts,
    interrupts::enable as enable_interrupts
};

use debug_print::HEADING_PREFIX;

const KERNEL_STACK_SIZE: u64 = 128 * 1024; // 128 KiB

// Limine bootloader requests
#[used] pub static BASE_REVISION: BaseRevision = BaseRevision::new();
#[used] pub static HHDM_REQUEST: HhdmRequest = HhdmRequest::new();
#[used] pub static FRAMEBUFFER_REQUEST: FramebufferRequest = FramebufferRequest::new();
#[used] pub static STACK_REQUEST: StackSizeRequest = StackSizeRequest::new().with_size(KERNEL_STACK_SIZE);
#[used] pub static MEM_MAP_REQUEST: MemoryMapRequest = MemoryMapRequest::new();
#[used] pub static ACPI_RSDP_REQUEST: RsdpRequest = RsdpRequest::new();
#[used] pub static MODULE_REQUEST: ModuleRequest = ModuleRequest::new();

// Kernel entry point
#[no_mangle]
extern "C" fn _start() -> ! {
    // Disable interrupts just to be sure
    disable_interrupts();

    assert!(BASE_REVISION.is_supported());

    let hhdm_offset = HHDM_REQUEST
        .get_response()
        .expect("Bootloader did not give us an HHDM response")
        .offset() as usize;

    debug_print::init();
    debug_println!(HEADING_PREFIX; "Kernel started");

    let cpu_info = cpu_info::init();
    let acpi_info = acpi::init(hhdm_offset);
    let gdt_info = gdt::init();
    interrupt::init(hhdm_offset, &cpu_info, &acpi_info);
    timer::init(hhdm_offset, &cpu_info, &acpi_info);
    mem::init(hhdm_offset);
    syscall::init(&gdt_info);
    sched::init(hhdm_offset);
    init_proc::init();

    debug_println!(HEADING_PREFIX; "Kernel startup finished");
    enable_interrupts();

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
        None => debug_println!("(no location available)")
    }

    debug_print!("\nMessage: ");

    match info.message() {
        Some(&msg) => debug_print::debug_print_helper(msg),
        None => debug_println!("(no message)")
    }

    disable_interrupts();

    loop {
        hlt();
    }
}