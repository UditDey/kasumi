use spinning_top::Spinlock;
use x86_64::{registers::segmentation::{Segment, SS, CS}, structures::{gdt::{Descriptor, GlobalDescriptorTable, SegmentSelector}, tss::TaskStateSegment}};

use crate::{debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX}, debug_println};

static GDT: Spinlock<GlobalDescriptorTable<8>> = Spinlock::new(GlobalDescriptorTable::new());
static TSS: TaskStateSegment = TaskStateSegment::new();

pub fn init() {
    debug_println!(HEADING_PREFIX; "Loading GDT");

    let mut gdt = GDT.lock();

    gdt.append(Descriptor::kernel_code_segment());
    gdt.append(Descriptor::kernel_data_segment());
    gdt.append(Descriptor::user_code_segment());
    gdt.append(Descriptor::user_data_segment());
    gdt.append(Descriptor::tss_segment(&TSS));
    
    // TODO: figure out GDT physical address
    //debug_println!(SUBHEADING_PREFIX; "GDT address: {:#X}", &*gdt as *const _ as usize);
    /*unsafe { gdt.load_unsafe(); }

    unsafe {
        SS::set_reg(SegmentSelector::new(1, x86_64::PrivilegeLevel::Ring0));
        CS::set_reg(SegmentSelector::new(0, x86_64::PrivilegeLevel::Ring0));
    }*/
}