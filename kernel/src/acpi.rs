use core::ptr::NonNull;

use acpi::{madt::Madt, hpet::HpetInfo, AcpiHandler, AcpiTables, PhysicalMapping};

use crate::{debug_println, ACPI_RSDP_REQUEST, debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}};

#[derive(Clone)]
struct Handler {
    hhdm_offset: usize
}

impl AcpiHandler for Handler {
    unsafe fn map_physical_region<T>(&self, physical_address: usize, size: usize) -> PhysicalMapping<Self, T> {
        // Add HHDM offset to physical address to get the mapped address
        PhysicalMapping::new(
            physical_address,
            NonNull::new((physical_address + self.hhdm_offset) as *mut T).unwrap(),
            size,
            size,
            self.clone()
        )
    }

    fn unmap_physical_region<T>(_region: &PhysicalMapping<Self, T>) {
        
    }
}

pub struct AcpiInfo {
    pub madt: Madt,
    pub hpet_info: HpetInfo
}

pub fn init(hhdm_offset: usize) -> AcpiInfo {
    debug_println!(HEADING_PREFIX; "Loading ACPI tables:");

    // Load RSDP
    debug_println!(SUBHEADING_PREFIX; "Loading RSDP");

    // `AcpiTables` expects a physical RSDP address, but bootloader gives us an HHDM address
    // Subtract the HHDM offset from the given RSDP address to get the physical address
    let rsdp_response = ACPI_RSDP_REQUEST
        .get_response()
        .expect("Bootloader did not give us an ACPI RSDP response");

    let rsdp_addr = rsdp_response.address() as usize - hhdm_offset;

    let handler = Handler { hhdm_offset };
    let acpi_tables = unsafe { AcpiTables::from_rsdp(handler, rsdp_addr).expect("Couldn't load RSDP") };

    // Find MADT
    debug_println!(SUBHEADING_PREFIX; "Loading MADT");

    let madt = acpi_tables
        .find_table::<Madt>()
        .expect("Couldn't find MADT");

    let legacy_pic = madt.supports_8259();
    let local_apic_addr = madt.local_apic_address;

    debug_println!(SUBHEADING_PREFIX; "Legacy PIC supported: {legacy_pic}");
    debug_println!(SUBHEADING_PREFIX; "Local APIC base address (from MADT): {:#X}", local_apic_addr);

    // Find HPET table
    debug_println!(SUBHEADING_PREFIX; "Loading HPET table");
    let hpet_info = HpetInfo::new(&acpi_tables).expect("Couldn't find HPET table");

    debug_println!(SUBHEADING_PREFIX; "HPET base address: {:#X}", hpet_info.base_address);
    debug_println!(SUBHEADING_PREFIX; "HPET comparator count: {}", hpet_info.num_comparators());

    AcpiInfo {
        madt: *madt,
        hpet_info
    }
}