//! Kernel Syscall Handlers
//!
//! ### Syscall ABI:
//! Similar to Linux's ABI
//! - Syscall number is passed in `rax`
//! - Syscall arguments (arg_0 through arg_2) are passed in `rdi`, `rsi` and `rdx`
//! - Syscall return code is passed back in `rax`
//!
//!
//! ### Clobbers:
//! - `rax`, `rdi`, `rsi` and `rdx` clobbered by syscall args/return code
//! - `rcx` and `r11` clobbered by `syscall` instruction
//!
//! Remaining registers are preserved by the kernel
//!
//!
//! ### Return Codes
//! Every syscall returns an i64 error code in `rax`. All return codes < 0 indicate
//! an error, and >= 0 indicate success
//!
//! Return codes common to all syscalls are:
//! [`SUCCESS`] =  0: Basic success code
//! [`INVALID`] = -1: Invalid syscall number
//! [`BAD_PTR`] = -2: Pointer argument failed sanity check
//!
//! Syscalls can implement their own > 0 success codes too
//!
//!
//! ### Pointer Sanity
//! Some syscalls require userspace to pass pointer args. These can be either const
//! pointer args or mutable pointer args, and they must be sanitized:
//! - Const pointer args must come from the userspace process's

use core::arch::naked_asm;
use core::ffi::CStr;
use core::mem::offset_of;

use x86_64::{
    VirtAddr,
    registers::{
        control::{Efer, EferFlags},
        model_specific::{LStar, SFMask, Star},
        rflags::RFlags,
    },
};

use crate::{
    debug_print,
    sched::SavedContext,
    state::{
        CpuLocal, GDT_KERNEL_CODE_SEGMENT, GDT_KERNEL_DATA_SEGMENT, GDT_USER_CODE_SEGMENT,
        GDT_USER_DATA_SEGMENT,
    },
};

const SUCCESS: i64 = 0;
const INVALID: i64 = -1;
const BAD_PTR: i64 = -2;

pub fn init() {
    unsafe {
        Efer::write(Efer::read() | EferFlags::SYSTEM_CALL_EXTENSIONS);
    }

    Star::write(
        GDT_USER_CODE_SEGMENT,
        GDT_USER_DATA_SEGMENT,
        GDT_KERNEL_CODE_SEGMENT,
        GDT_KERNEL_DATA_SEGMENT,
    )
    .expect("STAR setup failed");

    LStar::write(VirtAddr::from_ptr(_syscall_stub as *const u8));
    SFMask::write(RFlags::INTERRUPT_FLAG); // Disable interrupts on the way in
}

#[unsafe(naked)]
extern "C" fn _syscall_stub() {
    naked_asm! {
        "swapgs",
        "mov gs:[{user_rsp_offset}], rsp",   // Save user thread rsp
        "mov rsp, gs:[{kernel_rsp_offset}]", // Load kernel stack rsp
        "push {user_ss}",                    // Build a `SavedContext` on the stack
        "push gs:[{user_rsp_offset}]",
        "push r11",                          // `syscall` saves rflags in r11
        "push {user_cs}",
        "push rcx",                          // `syscall` saves rip in rcx
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
        "mov rdi, rsp",                      // &mut SavedContext
        "call {syscall_handler}",
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
        "mov rsp, gs:[{user_rsp_offset}]",   // Restore user thread rsp
        "swapgs",
        "sysretq",
        user_rsp_offset = const offset_of!(CpuLocal, syscall_user_rsp),
        kernel_rsp_offset = const offset_of!(CpuLocal, kernel_stack_rsp),
        user_ss = const GDT_USER_DATA_SEGMENT.0 as u64,
        user_cs = const GDT_USER_CODE_SEGMENT.0 as u64,
        syscall_handler = sym _syscall_handler,
    }
}

extern "C" fn _syscall_handler(ctx: &mut SavedContext) {
    let syscall_num = ctx.rax;
    let arg_0 = ctx.rdi;
    let _arg_1 = ctx.rsi;

    let ret_code = match syscall_num {
        0 => debug_print_syscall(arg_0),
        _ => INVALID,
    };

    ctx.rax = ret_code as u64;
}

/*// Tries to read a u64 from an address, returning 1 if successful, 0 if not
#[allow(named_asm_labels)]
#[unsafe(naked)]
extern "C" fn try_read_u64(addr: *const u64, out: *mut u64) -> u64 {
    naked_asm! {
        ".global __try_read_u64",
        "__try_read_u64:",
        "mov rax, [rdi]",   // Page fault handler knows about this `mov`
        "mov [rsi], rax",
        "mov rax, 1",
        "ret",

        // Page fault handler will steer us here if read fails
        ".global __try_read_u64_fault",
        "__try_read_u64_fault:",
        "xor rax, rax",
        "ret"
    }
}*/

fn debug_print_syscall(arg_0: u64) -> i64 {
    unsafe {
        let cstr = CStr::from_ptr(arg_0 as *const i8);
        debug_print!("{}", cstr.display());
    }

    SUCCESS
}
