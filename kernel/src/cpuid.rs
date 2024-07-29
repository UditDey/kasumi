use raw_cpuid::CpuId;

use crate::{
    debug_print,
    debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX},
    debug_println,
};

/// Checks for required CPU features
pub fn check() {
    debug_println!(HEADING_PREFIX; "Checking CPU features:");

    let cpuid = CpuId::new();

    // Print vendor
    debug_print!(SUBHEADING_PREFIX; "CPU Vendor: ");

    let vendor_info = cpuid.get_vendor_info();

    match vendor_info {
        Some(info) => debug_println!("{}", info.as_str()),
        None => debug_println!("(no vendor info available)"),
    }

    // Get feature support
    let feature_info = cpuid.get_feature_info().expect("Couldn't get CPUID feature info");

    let ext_info = cpuid
        .get_extended_feature_info()
        .expect("Couldn't get CPUID extended feature info");

    let ext_ident = cpuid
        .get_extended_processor_and_feature_identifiers()
        .expect("Couldn't get CPUID extended processor and feature info");

    let power_info = cpuid
        .get_thermal_power_info()
        .expect("Couldn't get CPUID thermal and power info");

    // Check if x86_64 microarchitecture level 3 is supported
    //
    // Level 3 is the minimum level required by Kasumi and all components are
    // compiled targeting this level. We only check for level 3 features since
    // it implies all the previous levels are also supported
    assert!(feature_info.has_avx(), "CPU does not support x86_64-v3 feature: AVX");
    assert!(ext_info.has_avx2(), "CPU does not support x86_64-v3 feature: AVX 2");
    assert!(ext_info.has_bmi1(), "CPU does not support x86_64-v3 feature: BMI 1");
    assert!(ext_info.has_bmi2(), "CPU does not support x86_64-v3 feature: BMI 2");
    assert!(feature_info.has_f16c(), "CPU does not support x86_64-v3 feature: F16C");
    assert!(feature_info.has_fma(), "CPU does not support x86_64-v3 feature: FMA");
    assert!(ext_ident.has_lzcnt(), "CPU does not support x86_64-v3 feature: LZCNT");
    assert!(feature_info.has_movbe(), "CPU does not support x86_64-v3 feature: MOVBE");
    assert!(feature_info.has_xsave(), "CPU does not support x86_64-v3 feature: XSAVE");

    // Check other required features
    assert!(feature_info.has_apic(), "CPU does not support APIC");
    assert!(power_info.has_arat(), "CPU does not support Always-Running-APIC-Timer (ARAT)");
    assert!(ext_ident.has_1gib_pages(), "CPU does not support 1 GiB huge pages");

    debug_println!(SUBHEADING_PREFIX; "All required features supported");
}
