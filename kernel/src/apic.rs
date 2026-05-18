use x86_64::{instructions::port::Port, registers::model_specific::Msr};

use crate::{
    debug_print::{HEADING, SUBHEADING},
    debug_println,
    idt::{LAPIC_TIMER_INT_VECTOR, SPURIOUS_INT_VECTOR},
    sched::SCHED_QUANTUM_MS,
    state::LAPIC_TIMER_FREQ_KHZ,
};

// PIT ports (for timer calibration)
const PIT_CHANNEL2_DATA: u16 = 0x42;
const PIT_COMMAND: u16 = 0x43;
const PIT_GATE: u16 = 0x61;

const PIT_FREQ: u64 = 1_193_182;
const CALIBRATION_MS: u64 = 50;

// x2APIC MSRs
const X2APIC_TPR: u32 = 0x808;
const X2APIC_EOI: u32 = 0x80B;
const X2APIC_SVR: u32 = 0x80F;
const X2APIC_ESR: u32 = 0x828;
const X2APIC_ICR: u32 = 0x830;
const X2APIC_LVT_TIMER: u32 = 0x832;
const X2APIC_LVT_LINT0: u32 = 0x835;
const X2APIC_LVT_LINT1: u32 = 0x836;
const X2APIC_TIMER_INIT_CNT: u32 = 0x838;
const X2APIC_TIMER_CURRENT_CNT: u32 = 0x839;
const X2APIC_TIMER_DIV: u32 = 0x83E;

pub fn calibrate_lapic_timer() {
    debug_println!(HEADING; "Calibrating LAPIC timer:");

    // BSP ends up init'ing LAPIC twice but thats harmless
    init_lapic();

    let pit_count = (PIT_FREQ * CALIBRATION_MS) / 1000;
    assert!(
        pit_count <= 0xFFFF,
        "PIT calibration period too long (max ~55ms)"
    );

    let mut gate_port = Port::<u8>::new(PIT_GATE);
    let mut cmd_port = Port::<u8>::new(PIT_COMMAND);
    let mut ch2_port = Port::<u8>::new(PIT_CHANNEL2_DATA);

    let khz = unsafe {
        // Disable speaker, enable channel 2 gate
        let gate = gate_port.read();
        gate_port.write((gate & !0x02) | 0x01);

        // Channel 2, lobyte/hibyte, mode 0 (one-shot), binary
        cmd_port.write(0b10110000);

        // Write count
        ch2_port.write((pit_count & 0xFF) as u8);
        ch2_port.write((pit_count >> 8) as u8);

        // Set up APIC timer: divide by 16, max initial count
        write_x2apic(X2APIC_TIMER_DIV, 0b11);
        write_x2apic(X2APIC_TIMER_INIT_CNT, 0xFFFF_FFFF);

        // Wait for PIT channel 2 output to go high (bit 5)
        while gate_port.read() & 0x20 == 0 {
            core::hint::spin_loop();
        }

        // Read elapsed APIC ticks
        let remaining = read_x2apic(X2APIC_TIMER_CURRENT_CNT);
        let elapsed = 0xFFFF_FFFF - remaining;

        // Stop APIC timer
        write_x2apic(X2APIC_TIMER_INIT_CNT, 0);

        elapsed / CALIBRATION_MS
    };

    debug_println!(SUBHEADING; "LAPIC timer running at {} KHz", khz);

    // SAFETY: Called from BSP in kmain()
    unsafe {
        *LAPIC_TIMER_FREQ_KHZ.get_mut() = khz;
    }
}

pub fn init_lapic() {
    // x2APIC already enabled by limine
    // This x2APIC init is inspired by what linux does
    // See setup_local_APIC() from linux/arch/x86/kernel/apic.c
    write_x2apic(X2APIC_SVR, 0); // Soft disable x2APIC

    write_x2apic(X2APIC_EOI, 0); // Ack any pending interrupts
    write_x2apic(X2APIC_ESR, 0); // Clear error status

    write_x2apic(X2APIC_TPR, 1 << 4); // Accept all vectors except 0-31

    // Mask local interrupt pins
    write_x2apic(X2APIC_LVT_LINT0, 1 << 16);
    write_x2apic(X2APIC_LVT_LINT1, 1 << 16);

    // Disable timer for now
    write_x2apic(X2APIC_TIMER_INIT_CNT, 0);

    // Enable APIC
    write_x2apic(X2APIC_SVR, 1 << 8 | SPURIOUS_INT_VECTOR as u64);
}

pub fn start_lapic_timer() {
    let ticks = *LAPIC_TIMER_FREQ_KHZ.get() * SCHED_QUANTUM_MS;

    write_x2apic(X2APIC_TIMER_DIV, 0b11); // divide by 16
    write_x2apic(X2APIC_LVT_TIMER, (1 << 17) | LAPIC_TIMER_INT_VECTOR as u64); // periodic mode
    write_x2apic(X2APIC_TIMER_INIT_CNT, ticks);
}

pub fn eoi() {
    write_x2apic(X2APIC_EOI, 0);
}

pub fn send_nmi_broadcast() {
    write_x2apic(X2APIC_ICR, (0b11 << 18) | (0b100 << 8));
}

fn write_x2apic(msr: u32, val: u64) {
    unsafe {
        Msr::new(msr).write(val);
    }
}

fn read_x2apic(msr: u32) -> u64 {
    unsafe { Msr::new(msr).read() }
}
