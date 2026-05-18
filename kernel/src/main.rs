#![feature(cstr_display)]
#![no_std]
#![no_main]

mod apic;
mod cpuid;
mod debug_print;
mod idt;
mod kalloc;
mod pmm;
mod sched;
mod smp;
mod state;
mod syscall;
mod util;
mod vmm;

use core::panic::PanicInfo;
use core::sync::atomic::Ordering;

use limine::{
    BaseRevision,
    modules::InternalModule,
    mp::{Cpu as LimineCpu, RequestFlags as MpFlags},
    request::{
        ExecutableAddressRequest, FramebufferRequest, HhdmRequest, MemoryMapRequest, ModuleRequest,
        MpRequest,
    },
};

use x86_64::{
    VirtAddr,
    instructions::{hlt, interrupts::disable as cli},
    registers::{
        control::{Cr4, Cr4Flags},
        model_specific::KernelGsBase,
        segmentation::{GS, Segment64},
    },
};

use debug_print::{HEADING, SUBHEADING};
use state::{CpuLocal, PANIC_FLAG};

// Limine bootloader requests
#[used]
static BASE_REVISION: BaseRevision = BaseRevision::new();
#[used]
static HHDM_REQUEST: HhdmRequest = HhdmRequest::new();
#[used]
static FRAMEBUFFER_REQUEST: FramebufferRequest = FramebufferRequest::new();
#[used]
static MEM_MAP_REQUEST: MemoryMapRequest = MemoryMapRequest::new();
#[used]
static MP_REQUEST: MpRequest = MpRequest::new().with_flags(MpFlags::X2APIC);
#[used]
static KERNEL_ADDR_REQUEST: ExecutableAddressRequest = ExecutableAddressRequest::new();
#[used]
pub static MODULE_REQUEST: ModuleRequest =
    ModuleRequest::new().with_internal_modules(&[&InternalModule::new().with_path(c"pid0.bin")]);

/// Kernel entry point
#[unsafe(no_mangle)]
pub extern "C" fn kmain() -> ! {
    // Basic setup
    cli();
    assert!(BASE_REVISION.is_supported());
    debug_print::init(FRAMEBUFFER_REQUEST.get_response());
    debug_println!(HEADING; "Kernel started");

    // Unpack limine responses
    let hhdm_resp = HHDM_REQUEST
        .get_response()
        .expect("Limine didn't give us an HHDM response");

    let mem_map_resp = MEM_MAP_REQUEST
        .get_response()
        .expect("Limine didn't give us a memory map response");

    let mp_resp = MP_REQUEST
        .get_response()
        .expect("Limine didn't give us an MP response");

    let kernel_addr_resp = KERNEL_ADDR_REQUEST
        .get_response()
        .expect("Limine didn't give us a kernel address response");

    // Set up global state
    cpuid::check();
    pmm::init(hhdm_resp, mem_map_resp);
    vmm::init_kernel_pml4(kernel_addr_resp, mem_map_resp);
    idt::init();
    apic::calibrate_lapic_timer();

    // Set up CpuLocal states
    state::init_cpu_locals(mp_resp);

    // Start up APs
    // All CPUs will proceed to final_init now
    smp::init(mp_resp);
}

/// Final per-cpu init
extern "C" fn final_init(cpu: &LimineCpu) -> ! {
    unsafe {
        // Enable FSGSBASE
        Cr4::write(Cr4::read() | Cr4Flags::FSGSBASE);

        // Load our PerCpu into GS
        let per_cpu_addr = cpu.extra.as_ptr().as_mut().copied().unwrap();
        let per_cpu = VirtAddr::new(per_cpu_addr);

        GS::write_base(per_cpu);
        KernelGsBase::write(per_cpu);
    }

    // We can access CpuLocal through GS now
    let cpu_local = CpuLocal::this();
    debug_println!(SUBHEADING; "Hello from CPU {}", cpu_local.cpu_index);

    // Load our own tables
    vmm::load_kernel_pml4();
    cpu_local.load_gdt();
    debug_println!("readed");
    loop {}
    idt::load();

    // Setup local x2APIC
    apic::init_lapic();
    apic::start_lapic_timer();

    // Setup syscalls
    syscall::init();

    // Start scheduler loop and PID0 process
    let module_resp = MODULE_REQUEST
        .get_response()
        .expect("Limine didn't give us a kernel module response");

    if cpu_local.cpu_index == 0 {
        sched::start_pid0(module_resp);
    } else {
        sched::start_idle();
    }
}

#[panic_handler]
fn rust_panic(info: &PanicInfo) -> ! {
    cli();

    if PANIC_FLAG.swap(true, Ordering::SeqCst) {
        loop {
            hlt(); // Another CPU already panicked
        }
    }

    // Have to use forced printing since another CPU might hold the lock
    unsafe {
        forced_debug_println!("\n**** KERNEL PANIC ****\n");
        forced_debug_print!("Kernel panic occured at: ");

        match info.location() {
            Some(location) => forced_debug_println!("{location}"),
            None => forced_debug_println!("(no location available)"),
        }

        forced_debug_println!("\nMessage: {}", info.message());
    }

    apic::send_nmi_broadcast();

    loop {
        hlt();
    }
}
