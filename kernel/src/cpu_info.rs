use raw_cpuid::CpuId;
use x86_64::registers::model_specific::{Msr, Efer, EferFlags};

use crate::{debug_print, debug_println, debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}};

const APIC_BASE_MSR: u32 = 0x1B;
const APIC_BASE_MSR_ENABLE: u64 = 1 << 11; // Bit 11 is enable flag

pub struct CpuInfo {
    pub local_apic_base: *mut u8
}

pub fn init() -> CpuInfo {
    let cpuid = CpuId::new();

    debug_println!(HEADING_PREFIX; "Checking CPU info:");

    // Print vendor
    debug_print!(SUBHEADING_PREFIX; "CPU Vendor: ");

    let vendor_info = cpuid.get_vendor_info();

    match vendor_info {
        Some(info) => debug_println!("{}", info.as_str()),
        None => debug_println!("(no vendor info available)")
    }

    // Check for required features
    let feature_info = cpuid
        .get_feature_info()
        .expect("Couldn't get CPUID feature info");

    assert!(feature_info.has_msr(), "CPU does not support RDMSR/WRMSR");
    assert!(feature_info.has_xsave(), "CPU does not support XSAVE/XRSTOR");
    assert!(feature_info.has_apic(), "CPU does not support APIC");

    let ext_info = cpuid
        .get_extended_processor_and_feature_identifiers()
        .expect("Couldn't get CPUID extended processor and feature info");

    assert!(ext_info.has_1gib_pages(), "CPU does not support 1 GiB huge pages");
    assert!(ext_info.has_lzcnt(), "CPU does not support LZCNT");
    assert!(ext_info.has_syscall_sysret(), "CPU does not support SYSCALL/SYSRET");

    let power_info = cpuid
        .get_thermal_power_info()
        .expect("Couldn't get CPUID thermal and power info");

    assert!(power_info.has_arat(), "CPU does not support always-running-APIC-timer (ARAT)");

    debug_println!(SUBHEADING_PREFIX; "All required features supported");

    // Get local APIC base address
    let mut apic_base_msr = Msr::new(APIC_BASE_MSR);
    let apic_base = unsafe { apic_base_msr.read() & 0xFFFFFFFFFF000 };

    debug_println!(SUBHEADING_PREFIX; "Local APIC base address (from MSR): {apic_base:#X}");

    unsafe {
        // Make sure local APIC is enabled
        apic_base_msr.write(apic_base_msr.read() | APIC_BASE_MSR_ENABLE);

        // Enable syscall/sysret instructions
        Efer::update(|flags| *flags |= EferFlags::SYSTEM_CALL_EXTENSIONS);
    }

    CpuInfo { local_apic_base: apic_base as *mut u8 }
}