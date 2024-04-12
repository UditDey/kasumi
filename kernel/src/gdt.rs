use spinning_top::Spinlock;

use x86_64::{
    registers::segmentation::{Segment, CS, DS, ES, FS, GS, SS},
    structures::{
        gdt::{Descriptor, GlobalDescriptorTable, DescriptorFlags},
        tss::TaskStateSegment
    }
};

use crate::{
    debug_print::HEADING_PREFIX,
    debug_println
};

static GDT: Spinlock<GlobalDescriptorTable<16>> = Spinlock::new(GlobalDescriptorTable::empty());
static TSS: TaskStateSegment = TaskStateSegment::new();

pub fn init() {
    debug_println!(HEADING_PREFIX; "Loading GDT");

    // Fill GDT entries
    // Reference:
    // 1) https://github.com/TornaxO7/PornOS/blob/main/src/gdt/mod.rs
    // 2) https://github.com/rust-osdev/x86_64/issues/389#issuecomment-1307420662
    let mut gdt = GDT.lock();

    let code_16_bit = DescriptorFlags::USER_SEGMENT |
                      DescriptorFlags::PRESENT |
                      DescriptorFlags::LIMIT_0_15 |
                      DescriptorFlags::ACCESSED |
                      DescriptorFlags::EXECUTABLE;
    
    gdt.append(Descriptor::UserSegment(code_16_bit.bits()));

    let data_16_bit = DescriptorFlags::USER_SEGMENT |
                      DescriptorFlags::PRESENT |
                      DescriptorFlags::LIMIT_0_15 |
                      DescriptorFlags::ACCESSED |
                      DescriptorFlags::WRITABLE;
    
    gdt.append(Descriptor::UserSegment(data_16_bit.bits()));

    let code_32_bit = DescriptorFlags::KERNEL_CODE32;
    gdt.append(Descriptor::UserSegment(code_32_bit.bits()));

    let data_32_bit = DescriptorFlags::KERNEL_DATA;
    gdt.append(Descriptor::UserSegment(data_32_bit.bits()));

    let code_64_bit = DescriptorFlags::KERNEL_CODE64;
    let code_segment = gdt.append(Descriptor::UserSegment(code_64_bit.bits()));

    let data_64_bit = DescriptorFlags::KERNEL_DATA;
    let data_segment = gdt.append(Descriptor::UserSegment(data_64_bit.bits()));

    gdt.append(Descriptor::tss_segment(&TSS));

    unsafe {
        gdt.load_unsafe();

        CS::set_reg(code_segment);
        DS::set_reg(data_segment);
        ES::set_reg(data_segment);
        FS::set_reg(data_segment);
        GS::set_reg(data_segment);
        SS::set_reg(data_segment);
    }
}