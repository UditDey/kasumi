use core::slice;
use core::arch::x86_64::_lzcnt_u64;

use spinning_top::Spinlock;
use limine::memory_map::{Entry, EntryType};
use x86_64::structures::paging::PageTable;

use crate::{
    MEM_MAP_REQUEST,
    debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX},
    debug_println
};

pub const PAGE_SIZE: u64 = 4096;
const ENTRIES_PER_PAGE: u64 = PAGE_SIZE / 64;

struct FrameAlloc<'a> {
    bitmap: &'a mut [u64],
    last_used_entry: usize,
    max_addr: u64
}

impl<'a> FrameAlloc<'a> {
    pub const fn dummy() -> Self {
        Self {
            bitmap: &mut [],
            last_used_entry: 0,
            max_addr: 0
        }
    }

    pub fn new(bitmap_addr: u64, num_entries: u64, max_addr: u64) -> Self {
        unsafe {
            let bitmap = slice::from_raw_parts_mut(bitmap_addr as *mut u64, num_entries as usize);

            // Initialize all pages as occupied
            bitmap.fill(0);

            Self {
                bitmap,
                last_used_entry: 0,
                max_addr
            }
        }
    }

    pub fn mark_available(&mut self, frame_addr: u64) {
        assert!(frame_addr % PAGE_SIZE == 0, "FrameAlloc::mark_available() called with frame address not aligned to page boundary");
        assert!(frame_addr < self.max_addr, "FrameAlloc::mark_available() called with frame address outside of max address");

        let page_num = frame_addr / PAGE_SIZE;
        let entry_idx = page_num / 64;
        let bit_idx = 63 - page_num % 64;

        self.bitmap[entry_idx as usize] |= 1 << bit_idx;
    }

    pub fn mark_occupied(&mut self, frame_addr: u64) {
        assert!(frame_addr % PAGE_SIZE == 0, "FrameAlloc::mark_occupied() called with frame address not aligned to page boundary");
        assert!(frame_addr < self.max_addr, "FrameAlloc::mark_occupied() called with frame address outside of max address");

        let page_num = frame_addr / PAGE_SIZE;
        let entry_idx = page_num / 64;
        let bit_idx = 63 - page_num % 64;

        self.bitmap[entry_idx as usize] &= !(1 << bit_idx);
    }

    pub fn alloc_frame(&mut self) -> Option<u64> {
        // Start searching for available frame starting from the last used entry
        let entries = &mut self.bitmap[self.last_used_entry..];
        let alloc = Self::alloc_in_entries(entries, self.last_used_entry);

        if let Some((addr, entry_idx)) = alloc {
            self.last_used_entry = entry_idx;
            return Some(addr);
        }

        // Else, start looking from the start
        let entries = &mut self.bitmap[..self.last_used_entry];
        let alloc = Self::alloc_in_entries(entries, 0);

        if let Some((addr, entry_idx)) = alloc {
            self.last_used_entry = entry_idx;
            return Some(addr);
        }

        // No frames available :(
        None
    }

    fn alloc_in_entries(entries: &mut [u64], entry_offset: usize) -> Option<(u64, usize)> {
        for (i, entry) in entries.iter_mut().enumerate() {
            let bit_idx = unsafe { _lzcnt_u64(*entry) };

            if bit_idx == 64 {
                // No available frames in this entry
                continue;
            }

            // Available frame found, mark it as occupied and return the corresponding frame address
            *entry &= !(1 << (63 - bit_idx)); // 63 - bit_idx because lzcnt counts in opposite direction

            let addr = ((i as u64 + entry_offset as u64) * 64 + bit_idx) * PAGE_SIZE;
            return Some((addr, i));
        }

        None
    }
}

unsafe impl<'a> Send for FrameAlloc<'a> {}

static FRAME_ALLOCATOR: Spinlock<FrameAlloc> = Spinlock::new(FrameAlloc::dummy());

pub fn init(hhdm_offset: usize) {
    // Get the memory map
    let mem_map = MEM_MAP_REQUEST
        .get_response()
        .expect("Bootloader did not give us a memory map response");

    // Setup frame allocator bitmap
    debug_println!(HEADING_PREFIX; "Setting up frame allocator:");

    // Find the max address of usable memory
    let last_usable_entry = mem_map
        .entries()
        .iter()
        .filter(|entry| usable_entry(entry))
        .inspect(|entry| {
            // While we're at it, do a sanity check on each usable entry
            assert!(entry.base % PAGE_SIZE == 0, "Memory map entry base not aligned to page boundary");
            assert!(entry.length % PAGE_SIZE == 0, "Memory map entry length not a multiple of page size");
        })
        .last()
        .unwrap();

    let max_addr = last_usable_entry.base + last_usable_entry.length;
    let max_pages = max_addr.div_ceil(PAGE_SIZE);

    // Find amount of usable memory
    let usable_mem_amt = mem_map
        .entries()
        .iter()
        .filter(|entry| usable_entry(entry))
        .fold(0, |acc, entry| acc + entry.length);

    debug_println!(SUBHEADING_PREFIX; "Total usable memory: {usable_mem_amt}");

    // Calculate number of entries and pages needed for the bitmap
    let bitmap_num_entries = max_pages.div_ceil(64); // 64 pages in each 64 bit entry
    let bitmap_num_pages = bitmap_num_entries.div_ceil(ENTRIES_PER_PAGE);

    // Find a usable memory region with enough space for the bitmap
    let bitmap_addr = mem_map
        .entries()
        .iter()
        .filter(|entry| usable_entry(entry))
        .find(|entry| entry.length >= bitmap_num_entries * 64)
        .expect("Memory map does not have any usable entries large enough for the frame allocator bitmap")
        .base
        + hhdm_offset as u64;

    debug_println!(SUBHEADING_PREFIX; "Frame allocator bitmap created at {:#X} with {bitmap_num_entries} entries [spans {bitmap_num_pages} page(s)]", bitmap_addr - hhdm_offset as u64);

    // Initialize the allocator
    debug_println!(SUBHEADING_PREFIX; "Initializing frame allocator");
    let mut frame_alloc = FrameAlloc::new(bitmap_addr, bitmap_num_entries, max_addr);

    // Mark all usable memory as available
    for entry in mem_map.entries() {
        if usable_entry(entry) {
            let num_pages = entry.length / PAGE_SIZE;

            for i in 0..num_pages {
                let addr = entry.base + i * PAGE_SIZE;
                frame_alloc.mark_available(addr);
            }
        }
    }

    // Mark the memory taken by the bitmap as occupied
    for i in 0..bitmap_num_pages {
        let addr = bitmap_addr + i * PAGE_SIZE - hhdm_offset as u64;
        frame_alloc.mark_occupied(addr);
    }

    *FRAME_ALLOCATOR.lock() = frame_alloc;
}

fn usable_entry(entry: &Entry) -> bool {
    entry.entry_type == EntryType::USABLE || entry.entry_type == EntryType::BOOTLOADER_RECLAIMABLE
}

pub fn alloc_frame() -> Option<u64> {
    FRAME_ALLOCATOR.lock().alloc_frame()
}

pub fn new_top_level_pt() -> Option<*mut PageTable> {
    let pt = alloc_frame()? as *mut PageTable;
    unsafe { pt.as_mut().unwrap().zero(); }

    Some(pt)
}