use core::num::NonZeroU32;

use crate::{
    acpi::AcpiInfo,
    cpu_info::CpuInfo,
    interrupt::LocalApic,
    debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX},
    debug_println,
    debug_print
};

// HPET register offsets in bytes
const HPET_GEN_CAPAB: usize = 0x0;
const HPET_GEN_CONFIG: usize = 0x10;
const HPET_MAIN_COUNTER_VALUE: usize = 0xF0;

const APIC_TIMER_NUM_CALIBRATIONS: u32 = 5;

struct Hpet {
    base_addr: *mut u8
}

impl Hpet {
    pub fn new(acpi_info: &AcpiInfo, hhdm_offset: usize) -> Self {
        unsafe {
            let base_addr = acpi_info.hpet_info.base_address as *mut u8;

            Self { base_addr: base_addr.add(hhdm_offset) }
        }
    }

    fn read_reg(&self, offset: usize) -> u64 {
        unsafe {
            self.base_addr
                .add(offset)
                .cast::<u64>()
                .read_volatile()
        }
    }

    fn write_reg(&self, offset: usize, data: u64) {
        unsafe {
            self.base_addr
                .add(offset)
                .cast::<u64>()
                .write_volatile(data)
        }
    }

    pub fn disable(&self) {
        // Disables the counter
        // Also disables legacy replacement interrupt mapping, but thats
        // irrelevant and needs to be disabled anyways
        self.write_reg(HPET_GEN_CONFIG, 0);
    }

    pub fn enable(&self) {
        self.write_reg(HPET_GEN_CONFIG, 1);
    }

    /// Timer period in femtoseconds
    pub fn period_fs(&self) -> u64 {
        self.read_reg(HPET_GEN_CAPAB) >> 32
    }

    pub fn set_counter_value(&self, val: u64) {
        self.write_reg(HPET_MAIN_COUNTER_VALUE, val);
    }

    pub fn counter_value(&self) -> u64 {
        self.read_reg(HPET_MAIN_COUNTER_VALUE)
    }
}

pub fn init(hhdm_offset: usize, cpu_info: &CpuInfo, acpi_info: &AcpiInfo) {
    // We first find the local APIC timer frequency using the HPET as reference
    // Then we can setup the local APIC timer to feed us scheduler ticks

    // Setup HPET
    debug_println!(HEADING_PREFIX; "Setting up HPET for local APIC timer calibration");
    let hpet = Hpet::new(acpi_info, hhdm_offset);

    hpet.disable();

    let hpet_period = hpet.period_fs();
    let hpet_freq = 10u64.pow(15) / hpet_period; // 1 fs = 10^-15 s

    debug_print!(SUBHEADING_PREFIX; "HPET frequency: ");
    print_mhz(hpet_freq);

    // Calculate the number of HPET ticks that correspond to a 10 millisecond delay
    let num_hpet_ticks = 10u64.pow(13) / hpet_period; // 10^13 fs = 10 ms

    let local_apic = LocalApic::new(cpu_info, hhdm_offset);

    // Perform calibration runs and average the results
    let mut apic_timer_ticks = 0;

    // Warmup run, doing a warmup run first seems to provide more consistent
    // final results, atleast in QEMU
    // Maybe has to do with warming up I-cache with the calibration code?
    calibrate_apic_timer(&hpet, &local_apic, num_hpet_ticks);

    for _ in 0..APIC_TIMER_NUM_CALIBRATIONS {
        apic_timer_ticks += calibrate_apic_timer(&hpet, &local_apic, num_hpet_ticks);
    }

    apic_timer_ticks = apic_timer_ticks / APIC_TIMER_NUM_CALIBRATIONS;

    // We had apic_timer_ticks ticks in 10 ms (= 10^-3 s)
    // So freq (in hz) = apic_timer_ticks / 10^-3 = apic_timer_ticks * 10^3
    let apic_timer_freq = apic_timer_ticks * 1000;

    debug_print!(SUBHEADING_PREFIX; "APIC timer frequency: ");
    print_mhz(apic_timer_freq as u64);
}

fn calibrate_apic_timer(hpet: &Hpet, local_apic: &LocalApic, num_hpet_ticks: u64) -> u32 {
    // Setup HPET
    hpet.set_counter_value(0);

    // Start both timers
    local_apic.timer_enable(NonZeroU32::new(u32::MAX).unwrap());
    hpet.enable();

    // Poll HPET counter till value crosses needed number of ticks
    while hpet.counter_value() < num_hpet_ticks {}

    // Get number of APIC ticks elapsed and stop both timers
    let apic_timer_ticks = u32::MAX - local_apic.timer_current_count();
    local_apic.timer_disable();
    hpet.disable();

    apic_timer_ticks
}

fn print_mhz(freq: u64) {
    let freq_mhz = freq / 1_000_000;
    let freq_mhz_decimal = (freq - freq_mhz * 1_000_000) / 10_000; // 2 decimal places

    debug_println!("{freq_mhz}.{freq_mhz_decimal} MHz");
}