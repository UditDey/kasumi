use spinning_top::Spinlock;

use x86_64::{
    registers::segmentation::{Segment, CS, DS, ES, FS, GS, SS},
    structures::{
        gdt::{Descriptor, DescriptorFlags, GlobalDescriptorTable, SegmentSelector},
        tss::TaskStateSegment
    }
};

use crate::{
    debug_print::HEADING_PREFIX,
    debug_println
};

static GDT: Spinlock<GlobalDescriptorTable<16>> = Spinlock::new(GlobalDescriptorTable::empty());
static TSS: TaskStateSegment = TaskStateSegment::new();

/*const fn tss() -> TaskStateSegment {
    let mut tss = TaskStateSegment::new();

    tss.

    tss
}*/

pub struct GdtInfo {
    pub kernel_code_seg: SegmentSelector,
    pub kernel_data_seg: SegmentSelector,
    pub user_code_seg: SegmentSelector,
    pub user_data_seg: SegmentSelector,
}

pub fn init() -> GdtInfo {
    debug_println!(HEADING_PREFIX; "Loading GDT");

    // Fill GDT entries
    let mut gdt = GDT.lock();

    // This specific order makes STAR MSR setup work
    let user_data_seg = gdt.append(Descriptor::user_data_segment());
    let user_code_seg = gdt.append(Descriptor::user_code_segment());

    let kernel_code_seg = gdt.append(Descriptor::kernel_code_segment());
    let kernel_data_seg = gdt.append(Descriptor::kernel_data_segment());

    gdt.append(Descriptor::tss_segment(&TSS));

    unsafe {
        gdt.load_unsafe();

        CS::set_reg(kernel_code_seg);
        DS::set_reg(kernel_data_seg);
        ES::set_reg(kernel_data_seg);
        FS::set_reg(kernel_data_seg);
        GS::set_reg(kernel_data_seg);
        SS::set_reg(kernel_data_seg);
    }

    GdtInfo {
        kernel_code_seg,
        kernel_data_seg,
        user_code_seg,
        user_data_seg
    }
}