use core::ptr;
use core::num::NonZeroU32;

use spinning_top::{RwSpinlock, Spinlock};
use x86_64::{instructions::port::Port, structures::idt::{InterruptDescriptorTable, InterruptStackFrame}};

use crate::{
    cpu_info::CpuInfo,
    acpi::AcpiInfo,
    debug_println,
    debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}
};

// Legacy PIC ports
const LEGACY_PIC1_BASE: u16 = 0x20;
const LEGACY_PIC1_DATA_PORT: u16 = LEGACY_PIC1_BASE + 1;
const LEGACY_PIC2_BASE: u16 = 0xA0;
const LEGACY_PIC2_DATA_PORT: u16 = LEGACY_PIC2_BASE + 1;

// Local APIC register offsets in bytes
const LOCAL_APIC_ID: usize = 0x20;
const LOCAL_APIC_TASK_PRIORITY: usize = 0x80;
const LOCAL_APIC_SPURIOUS_VECTOR: usize = 0xF0;
const LOCAL_APIC_END_OF_INTERRUPT: usize = 0xB0;
const LOCAL_APIC_ERROR_STATUS: usize = 0x280;
const LOCAL_APIC_TIMER_LVT: usize = 0x320;
const LOCAL_APIC_TIMER_INITIAL_COUNT: usize = 0x380;
const LOCAL_APIC_TIMER_CURRENT_COUNT: usize = 0x390;
const LOCAL_APIC_TIMER_DIVIDE_CONFIG: usize = 0x3E0;

// Interrupt vectors
const INTERRUPT_BASE_VECTOR: u8 = 32;
const SCHEDULER_TICK_INTERRUPT_VECTOR: u8 = INTERRUPT_BASE_VECTOR + 0;

const SPURIOUS_INTERRUPT_VECTOR: u8 = 255;

// Interrupt descriptor table
static IDT: Spinlock<InterruptDescriptorTable> = Spinlock::new(InterruptDescriptorTable::new());

// Data used by ISRs
struct IsrData {
    local_apic: LocalApic
}

impl IsrData {
    pub const fn dummy() -> Self {
        Self {
            local_apic: LocalApic::dummy()
        }
    }
}

unsafe impl Send for IsrData {}
unsafe impl Sync for IsrData {}

static ISR_DATA: RwSpinlock<IsrData> = RwSpinlock::new(IsrData::dummy());

pub struct LocalApic {
    base_addr: *mut u8
}

impl LocalApic {
    pub const fn dummy() -> Self {
        Self { base_addr: ptr::null_mut() }
    }

    pub fn new(cpu_info: &CpuInfo, hhdm_offset: usize) -> Self {
        unsafe {
            Self { base_addr: cpu_info.local_apic_base.add(hhdm_offset) }
        }
    }

    fn read_reg(&self, offset: usize) -> u32 {
        unsafe {
            self.base_addr
                .add(offset)
                .cast::<u32>()
                .read_volatile()
        }
    }

    fn write_reg(&self, offset: usize, data: u32) {
        unsafe {
            self.base_addr
                .add(offset)
                .cast::<u32>()
                .write_volatile(data)
        }
    }

    pub fn id(&self) -> u32 {
        self.read_reg(LOCAL_APIC_ID)
    }

    pub fn init(&self) {
        // This local APIC init is inspired by what linux does
        // See setup_local_APIC() from linux/arch/x86/kernel/apic.c

        // Reset some APIC state
        self.write_reg(LOCAL_APIC_END_OF_INTERRUPT, 0); // Ack any interrupts already requested
        self.write_reg(LOCAL_APIC_ERROR_STATUS, 0);     // Clear error status register

        // Set the task priority register to accept all vectors except 0-31
        // which may be confused for exceptions
        // This sets the interrupt priority class = 1, sub class = 0
        self.write_reg(LOCAL_APIC_TASK_PRIORITY, 1 << 4);

        // Setup APIC timer
        self.write_reg(LOCAL_APIC_TIMER_INITIAL_COUNT, 0);      // Disable timer
        self.write_reg(LOCAL_APIC_TIMER_DIVIDE_CONFIG, 0b11);   // Frequency divisor = 16
        
        self.write_reg(
            LOCAL_APIC_TIMER_LVT,
            1 << 17 |                               // Timer mode = periodic
            SCHEDULER_TICK_INTERRUPT_VECTOR as u32  // We use APIC timer for scheduler ticks
        );

        // Setup spurious vector register
        // Also start the APIC with the software enable flag
        self.write_reg(
            LOCAL_APIC_SPURIOUS_VECTOR,
            SPURIOUS_INTERRUPT_VECTOR as u32 |  // Spurious interrupt vector = 0xFF
            1 << 8                              // Set software enable flag
        );
    }

    pub fn enable_interrupts(&self) {
        // Clear mask bit in timer LVT
        self.write_reg(LOCAL_APIC_TIMER_LVT, self.read_reg(LOCAL_APIC_TIMER_LVT) & !(1 << 16));
    }

    pub fn end_of_interrupt(&self) {
        self.write_reg(LOCAL_APIC_END_OF_INTERRUPT, 0);
    }

    pub fn timer_enable(&self, initial_count: NonZeroU32) {
        self.write_reg(LOCAL_APIC_TIMER_INITIAL_COUNT, initial_count.get());
    }

    pub fn timer_disable(&self) {
        self.write_reg(LOCAL_APIC_TIMER_INITIAL_COUNT, 0);
    }

    pub fn timer_current_count(&self) -> u32 {
        self.read_reg(LOCAL_APIC_TIMER_CURRENT_COUNT)
    }
}

pub fn init(hhdm_offset: usize, cpu_info: &CpuInfo, acpi_info: &AcpiInfo) {
    debug_println!(HEADING_PREFIX; "Setting up interrupts:");

    // Disable legacy PIC if supported
    if acpi_info.madt.supports_8259() {
        debug_println!(SUBHEADING_PREFIX; "Disabling legacy PICs");

        let mut pic1 = Port::<u8>::new(LEGACY_PIC1_DATA_PORT);
        let mut pic2 = Port::<u8>::new(LEGACY_PIC2_DATA_PORT);

        // Mask all interrupts in both PICs
        unsafe {
            pic1.write(0xFF);
            pic2.write(0xFF);
        }
    }

    // Setup local APIC
    let local_apic = LocalApic::new(cpu_info, hhdm_offset);
    
    debug_println!(SUBHEADING_PREFIX; "Setting up local APIC");
    debug_println!(SUBHEADING_PREFIX; "Local APIC ID: {:#X}", local_apic.id());

    local_apic.init();

    // Setup ISR data
    *ISR_DATA.write() = IsrData { local_apic };

    // Setup IDT
    debug_println!(HEADING_PREFIX; "Setting up IDT");
    let mut idt = IDT.lock();
    
    idt[SCHEDULER_TICK_INTERRUPT_VECTOR].set_handler_fn(scheduler_tick_isr);
    idt[SPURIOUS_INTERRUPT_VECTOR].set_handler_fn(spurious_isr);

    unsafe { idt.load_unsafe(); }
}

// Interrupt service routines
extern "x86-interrupt" fn scheduler_tick_isr(_: InterruptStackFrame) {
    ISR_DATA.read().local_apic.end_of_interrupt();
}

extern "x86-interrupt" fn spurious_isr(_: InterruptStackFrame) {} // Spurious interrupt ISR does not issue EOI