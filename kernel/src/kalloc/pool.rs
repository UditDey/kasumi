use core::ptr::NonNull;
use core::ptr::addr_of_mut;

use crate::pmm::{self, SMALL_PAGE_SIZE};

#[derive(Clone, Copy)]
struct PageHeader {
    occupancy: u32,
}

union Slot<const S: usize> {
    object: [u8; S],
    next_free: Option<NonNull<Self>>,
    header: PageHeader,
}

pub struct ObjectPool<const S: usize> {
    free_slot_list: Option<NonNull<Slot<S>>>,
}

// SAFETY: The slot list can be sent between threads no problem
unsafe impl<const S: usize> Send for ObjectPool<S> {}

impl<const S: usize> ObjectPool<S> {
    const SLOT_CHECK: () = assert!(SMALL_PAGE_SIZE.is_multiple_of(core::mem::size_of::<Slot<S>>()));

    pub const fn new() -> Self {
        // Assertion won't fire unless we mention it
        #[expect(clippy::let_unit_value)]
        let _ = Self::SLOT_CHECK;

        Self {
            free_slot_list: None,
        }
    }

    pub fn alloc(&mut self) -> NonNull<u8> {
        // Pop slot from freelist
        let slot = self.free_slot_list.unwrap_or_else(|| self.new_page());
        self.free_slot_list = unsafe { slot.as_ref().next_free };

        // Increment occupancy in page header
        let page_addr = slot.addr().get() & !(SMALL_PAGE_SIZE - 1);
        let header = unsafe { (page_addr as *mut PageHeader).as_mut().unwrap() };
        header.occupancy += 1;

        slot.cast()
    }

    pub fn free(&mut self, ptr: NonNull<u8>) {
        let slot = ptr.cast::<Slot<S>>();

        // Increment occupancy in page header
        let page_addr = slot.addr().get() & !(SMALL_PAGE_SIZE - 1);
        let header = unsafe { (page_addr as *mut PageHeader).as_mut().unwrap() };
        header.occupancy -= 1;

        // Push onto freelist
        unsafe {
            slot.as_ptr().write(Slot {
                next_free: self.free_slot_list,
            })
        };
        self.free_slot_list = Some(slot);
    }

    fn new_page(&mut self) -> NonNull<Slot<S>> {
        // Allocate a new page
        let page_phys = pmm::alloc_small().expect("Failed to allocate page for ObjectPool");
        let page = pmm::phys_to_hhdm(page_phys);

        // Interpret the page as a slot array
        let page = page.as_mut_ptr::<Slot<S>>();
        assert!(page.is_aligned());

        let slots_per_page = SMALL_PAGE_SIZE / core::mem::size_of::<Slot<S>>();
        let slots = unsafe { core::slice::from_raw_parts_mut(page, slots_per_page) };

        // Initialize the header slot
        slots[0].header = PageHeader { occupancy: 0 };

        // Initialize the remaining slots, each slot pointing to the next
        for i in 1..(slots_per_page - 1) {
            slots[i].next_free = Some(NonNull::new(addr_of_mut!(slots[i + 1])).unwrap());
        }

        // Last slot points to None
        slots.last_mut().unwrap().next_free = None;

        // Slot 1 used for new alloc
        NonNull::new(addr_of_mut!(slots[1])).unwrap()
    }
}
