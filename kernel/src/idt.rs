use core::arch::naked_asm;

use x86_64::{
    VirtAddr,
    structures::idt::{Entry, EntryOptions, InterruptDescriptorTable},
};

use crate::{
    apic, debug_println,
    sched::{self, SavedContext},
    state::{GDT_KERNEL_CODE_SEGMENT, IDT},
};

pub const LAPIC_TIMER_INT_VECTOR: u8 = 0x20;
pub const SPURIOUS_INT_VECTOR: u8 = 0xFF;

pub fn init() {
    let mut idt = InterruptDescriptorTable::new();

    unsafe {
        // Register exception handlers
        register_handler(&mut idt.divide_error, divide_error_handler as _);
        register_handler(&mut idt.debug, debug_exception_handler as _);
        register_handler(&mut idt.breakpoint, breakpoint_handler as _);
        register_handler(&mut idt.overflow, overflow_handler as _);
        register_handler(&mut idt.bound_range_exceeded, bound_range_handler as _);
        register_handler(&mut idt.invalid_opcode, invalid_opcode_handler as _);
        register_handler(&mut idt.device_not_available, no_math_handler as _);
        register_handler(&mut idt.invalid_tss, invalid_tss_handler as _);
        register_handler(&mut idt.segment_not_present, segment_handler as _);
        register_handler(&mut idt.stack_segment_fault, stack_segment_handler as _);
        register_handler(&mut idt.general_protection_fault, general_prot_handler as _);
        register_handler(&mut idt.page_fault, page_fault_handler as _);
        register_handler(&mut idt.x87_floating_point, x87_fault_handler as _);
        register_handler(&mut idt.alignment_check, alignment_handler as _);
        register_handler(&mut idt.machine_check, machine_check_handler as _);
        register_handler(&mut idt.simd_floating_point, simd_fp_handler as _);
        register_handler(&mut idt.virtualization, virtualization_handler as _);
        register_handler(&mut idt.cp_protection_exception, control_prot_handler as _);
        // TODO hv, vmm, security

        register_handler(&mut idt.double_fault, double_fault_handler as _).set_stack_index(0); // NMI and DF use IST0 stack
        register_handler(&mut idt.non_maskable_interrupt, nmi_handler as _).set_stack_index(0);

        // Register IO handlers
        register_handler(&mut idt[LAPIC_TIMER_INT_VECTOR], lapic_timer_handler as _);
        register_handler(&mut idt[SPURIOUS_INT_VECTOR], spurious_handler as _);
    }

    // SAEFTY: Called from BSP in kmain()
    unsafe {
        *IDT.get_mut() = idt;
    }
}

pub fn load() {
    IDT.get().load();
}

/// Register handler helper fn
///
/// Every interrupt handler by default has:
/// - Ring0 provilege level
/// - CS set to our GDT's kernel code segment
/// - Interrupts disabled on the way in (kernel is never interrupted/preempted)
/// - Uses RSP0 stack from TSS (ie the CpuLocal kernel stack)
fn register_handler<F>(entry: &mut Entry<F>, handler: *const u8) -> &mut EntryOptions {
    unsafe {
        entry
            .set_handler_addr(VirtAddr::new(handler.addr() as u64))
            .set_code_selector(GDT_KERNEL_CODE_SEGMENT)
    }
}

/// Defines an interrupt handler without a CPU pushed error code
macro_rules! interrupt_handler {
    (fn $stub:ident / $inner:ident($ctx:ident: &mut SavedContext) $body:block) => {
        #[unsafe(naked)]
        extern "C" fn $stub() {
            naked_asm! {
                // CPU pushed:
                // push ss
                // push rsp
                // push rflags
                // push cs
                // push rip
                "push rax",
                "push rbx",
                "push rcx",
                "push rdx",
                "push rsi",
                "push rdi",
                "push rbp",
                "push r8",
                "push r9",
                "push r10",
                "push r11",
                "push r12",
                "push r13",
                "push r14",
                "push r15",
                "mov rdi, rsp",                   // Stack now contains a full `SavedContext` struct
                "test qword ptr [rsp + 16*8], 3", // Check CS RPL bits, don't swapgs if interrupt comes from kernelspace
                "jz 2f",
                "swapgs",
                "call {inner}",
                "swapgs",
                "jmp 3f",
                "2:",
                "call {inner}",
                "3:",
                "pop r15",
                "pop r14",
                "pop r13",
                "pop r12",
                "pop r11",
                "pop r10",
                "pop r9",
                "pop r8",
                "pop rbp",
                "pop rdi",
                "pop rsi",
                "pop rdx",
                "pop rcx",
                "pop rbx",
                "pop rax",
                "iretq",
                inner = sym $inner,
            };
        }

        extern "C" fn $inner($ctx: &mut SavedContext) $body
    };
}

/// Defines an interrupt handler with a CPU pushed error code
macro_rules! interrupt_handler_err {
    (fn $stub:ident / $inner:ident($ctx:ident: &mut SavedContext, $error_code:ident: u64) $body:block) => {
        #[unsafe(naked)]
        extern "C" fn $stub() {
            naked_asm! {
                // CPU pushed:
                // push ss
                // push rsp
                // push rflags
                // push cs
                // push rip
                // push error_code
                "push rbx",
                "push rcx",
                "push rdx",
                "push rsi",
                "push rdi",
                "push rbp",
                "push r8",
                "push r9",
                "push r10",
                "push r11",
                "push r12",
                "push r13",
                "push r14",
                "push r15",
                "mov rsi, [rsp + 14*8]",           // Move error_code into rsi (second arg)
                "mov [rsp + 14*8], rax",           // Overwrite error_code with rax
                "mov rdi, rsp",                    // Stack now contains a full `SavedContext` struct (first arg)
                "test qword ptr [rsp + 16*8], 3",  // Check CS RPL bits, don't swapgs if exception comes from kernelspace
                "jz 2f",
                "swapgs",
                "call {inner}",
                "swapgs",
                "jmp 3f",
                "2:",
                "call {inner}",
                "3:",
                "pop r15",
                "pop r14",
                "pop r13",
                "pop r12",
                "pop r11",
                "pop r10",
                "pop r9",
                "pop r8",
                "pop rbp",
                "pop rdi",
                "pop rsi",
                "pop rdx",
                "pop rcx",
                "pop rbx",
                "pop rax",
                "iretq",
                inner = sym $inner,
            };
        }

        extern "C" fn $inner($ctx: &mut SavedContext, $error_code: u64) $body
    };
}

interrupt_handler! {
    fn divide_error_handler / de_inner(_ctx: &mut SavedContext) {
        debug_println!("Divide Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn debug_exception_handler / db_inner(_ctx: &mut SavedContext) {
        debug_println!("Debug Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn nmi_handler / nmi_inner(_ctx: &mut SavedContext) {
        debug_println!("NMI Interrupt");
    }
}

interrupt_handler! {
    fn breakpoint_handler / bp_inner(_ctx: &mut SavedContext) {
        debug_println!("Breakpoint Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn overflow_handler / of_inner(_ctx: &mut SavedContext) {
        debug_println!("Overflow Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn bound_range_handler / br_inner(_ctx: &mut SavedContext) {
        debug_println!("BOUND Range Exceeded Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn invalid_opcode_handler / ud_inner(_ctx: &mut SavedContext) {
        debug_println!("Invalid Opcode Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn no_math_handler / nm_inner(_ctx: &mut SavedContext) {
        debug_println!("No Math Coprocessor Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler_err! {
    fn double_fault_handler / df_inner(_ctx: &mut SavedContext, _error_code: u64) {
        debug_println!("Double Fault Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn invalid_tss_handler / ts_inner(_ctx: &mut SavedContext) {
        debug_println!("Invalid TSS Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler_err! {
    fn segment_handler / np_inner(_ctx: &mut SavedContext, _error_code: u64) {
        debug_println!("Segment Not Present Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler_err! {
    fn stack_segment_handler / ss_inner(_ctx: &mut SavedContext, _error_code: u64) {
        debug_println!("Stack Segment Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler_err! {
    fn general_prot_handler / gp_inner(ctx: &mut SavedContext, error_code: u64) {
        debug_println!("General Protection Exception (error_code = {error_code})\n{ctx:#X?}");
        loop {
            core::hint::spin_loop();
        }
    }
}

/*unsafe extern "C" {
    static __try_read_u64: u8;
    static __try_read_u64_fault: u8;
}*/

interrupt_handler_err! {
    fn page_fault_handler / pf_inner(ctx: &mut SavedContext, error_code: u64) {
        /*let try_read_u64_addr = (&raw const __try_read_u64).addr() as u64;
        let try_read_u64_fault_addr = (&raw const __try_read_u64_fault).addr() as u64;

        // Check if its coming from kernel try_read_*() functions
        if ctx.rip == try_read_u64_addr {
            ctx.rip = try_read_u64_fault_addr;
            return;
        }*/

        debug_println!("Page Fault Exception (error_code = {error_code})\n{ctx:#X?}");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn x87_fault_handler / mf_inner(_ctx: &mut SavedContext) {
        debug_println!("x87 Math Fault Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler_err! {
    fn alignment_handler / ac_inner(_ctx: &mut SavedContext, _error_code: u64) {
        debug_println!("Alignment Check Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn machine_check_handler / mc_inner(_ctx: &mut SavedContext) {
        debug_println!("Machine Check Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn simd_fp_handler / xm_inner(_ctx: &mut SavedContext) {
        debug_println!("SIMD FP Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn virtualization_handler / ve_inner(_ctx: &mut SavedContext) {
        debug_println!("Virtualization Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler_err! {
    fn control_prot_handler / cp_inner(_ctx: &mut SavedContext, _error_code: u64) {
        debug_println!("Control Protection Exception");
        loop {
            core::hint::spin_loop();
        }
    }
}

interrupt_handler! {
    fn lapic_timer_handler / lapic_inner(ctx: &mut SavedContext) {
        sched::sched_tick(ctx);
        apic::eoi();
    }
}

interrupt_handler! {
    fn spurious_handler / spurious_inner(_ctx: &mut SavedContext) {
        debug_println!("Spurious interrupt");
    }
}
