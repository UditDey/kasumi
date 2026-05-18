use arrayvec::ArrayVec;
use x86_64::{PhysAddr, VirtAddr};

use limine::{
    memory_map::EntryType,
    response::{HhdmResponse, MemoryMapResponse},
};

use crate::{
    debug_print::{HEADING, SUBHEADING},
    debug_println,
    state::{CpuLocal, HHDM_OFFSET, PMM},
};

pub const SMALL_PAGE_SIZE: usize = 4096;
pub const SMALL_PAGE_ALIGN: usize = 4096;

pub const LARGE_PAGE_SIZE: usize = 2 * 1024 * 1024;
pub const LARGE_PAGE_ALIGN: usize = 2 * 1024 * 1024;

pub const HUGE_PAGE_SIZE: usize = 1024 * 1024 * 1024;
pub const HUGE_PAGE_ALIGN: usize = 1024 * 1024 * 1024;

const WORDS_PER_PAGE: usize = SMALL_PAGE_SIZE / core::mem::size_of::<u64>();
const CACHE_SIZE: usize = 32;

/// Allocates a 4 KiB small page and returns its physical address
pub fn alloc_small() -> Option<PhysAddr> {
    let cpu_local = CpuLocal::this();
    let cache = &mut cpu_local.pmm_cache.borrow_mut().small_page_cache;

    match cache.pop() {
        Some(page) => Some(page),
        None => {
            let mut guard = PMM.lock();
            let pmm = guard.as_mut().expect("pmm::init() not called");
            for _ in 0..CACHE_SIZE / 2 {
                cache.push(pmm.alloc_small()?);
            }
            pmm.alloc_small()
        }
    }
}

/// Frees a previously allocated 4 KiB small page
///
/// ### SAFETY:
/// Must be used only on addresses previously allocated by [`alloc_small()`]
pub fn free_small(page: PhysAddr) {
    assert!(page.as_u64().is_multiple_of(SMALL_PAGE_SIZE as u64));

    let cpu_local = CpuLocal::this();
    let cache = &mut cpu_local.pmm_cache.borrow_mut().small_page_cache;

    if cache.try_push(page).is_err() {
        let mut guard = PMM.lock();
        let pmm = guard.as_mut().expect("pmm::init() not called");
        for page in cache.drain(0..CACHE_SIZE / 2) {
            pmm.free_small(page);
        }
        pmm.free_small(page);
    }
}

/// Allocates a 4 KiB small page and returns its physical address
///
/// Bypasses the CpuLocal cache. Use this instead of [`alloc_small()`] before CpuLocal has been set up
pub fn alloc_small_direct() -> Option<PhysAddr> {
    let mut guard = PMM.lock();
    let pmm = guard.as_mut().expect("pmm::init() not called");
    pmm.alloc_small()
}

pub fn hhdm_offset() -> VirtAddr {
    *HHDM_OFFSET.get()
}

pub fn phys_to_hhdm(phys: PhysAddr) -> VirtAddr {
    *HHDM_OFFSET.get() + phys.as_u64()
}

pub fn hhdm_to_phys(virt: VirtAddr) -> PhysAddr {
    PhysAddr::new(virt - *HHDM_OFFSET.get())
}

pub fn init(hhdm: &HhdmResponse, mem_map: &MemoryMapResponse) {
    debug_println!(HEADING; "Setting up PMM:");

    // Get the HHDM and memory map info
    let hhdm_offset = VirtAddr::new(hhdm.offset());

    // SAFETY: Called once from BSP in kmain()
    unsafe {
        *HHDM_OFFSET.get_mut() = hhdm_offset;
    }

    debug_println!(SUBHEADING; "HHDM offset at 0x{hhdm_offset:X}");

    // Sanity check the mem map
    for entry in mem_map.entries() {
        if entry.entry_type == EntryType::USABLE {
            assert!(entry.base.is_multiple_of(SMALL_PAGE_SIZE as u64));
            assert!(entry.length.is_multiple_of(SMALL_PAGE_SIZE as u64));
        }
    }

    // Get the highest usable address
    let max_addr = mem_map
        .entries()
        .iter()
        .filter(|entry| entry.entry_type == EntryType::USABLE)
        .map(|entry| (entry.base + entry.length) as usize)
        .max()
        .expect("Mem map is empty");

    let max_pages = max_addr.div_ceil(SMALL_PAGE_SIZE);

    // Find amount of usable memory
    let mem_amt = mem_map
        .entries()
        .iter()
        .filter(|entry| entry.entry_type == EntryType::USABLE)
        .fold(0, |acc, entry| acc + entry.length);

    debug_println!(SUBHEADING; "Total usable memory: 0x{mem_amt:X} bytes");

    // Calculate number of words and pages needed for bitmap
    let bitmap_num_words = max_pages.div_ceil(64);
    let bitmap_num_pages = bitmap_num_words.div_ceil(WORDS_PER_PAGE);

    // Find usable memory region large enough to hold the bitmap
    let bitmap_phys_addr = mem_map
        .entries()
        .iter()
        .filter(|entry| entry.entry_type == EntryType::USABLE)
        .find(|entry| entry.length as usize >= bitmap_num_pages * SMALL_PAGE_SIZE)
        .expect("Memory map does not have a large enough entry for PMM bitmap")
        .base;

    // We access bitmap through HHDM
    let bitmap_addr = hhdm_offset + bitmap_phys_addr;

    // SAFETY: We own the brand new bitmap pages
    let bitmap = unsafe {
        core::slice::from_raw_parts_mut(bitmap_addr.as_mut_ptr::<u64>(), bitmap_num_words)
    };

    debug_println!(SUBHEADING; "PMM bitmap set up at 0x{bitmap_addr:X} with {bitmap_num_words} words, spanning {bitmap_num_pages} page(s)");

    // Initialize PMM
    let mut pmm = Pmm::new(bitmap);

    // Mark all usable memory as available
    for entry in mem_map.entries() {
        if entry.entry_type == EntryType::USABLE {
            let num_pages = entry.length as usize / SMALL_PAGE_SIZE;

            for i in 0..num_pages {
                let addr = entry.base as usize + i * SMALL_PAGE_SIZE;
                pmm.mark_available(addr);
            }
        }
    }

    // Mark pages taken by the bitmap itself as occupied
    for i in 0..bitmap_num_pages {
        let addr = bitmap_addr + (i * SMALL_PAGE_SIZE) as u64;
        let phys_addr = addr - hhdm_offset;
        pmm.mark_occupied(phys_addr as usize);
    }

    *PMM.lock() = Some(pmm);
}

#[derive(Debug)]
pub struct PmmLocalCache {
    small_page_cache: ArrayVec<PhysAddr, CACHE_SIZE>,
}

impl PmmLocalCache {
    pub const fn new() -> Self {
        Self {
            small_page_cache: ArrayVec::new_const(),
        }
    }
}

pub struct Pmm<'a> {
    bitmap: &'a mut [u64],
}

impl<'a> Pmm<'a> {
    pub fn new(bitmap: &'a mut [u64]) -> Self {
        // Initialize all pages as occupied
        bitmap.fill(0);

        Self { bitmap }
    }

    /// Allocates a 4 KiB small page and returns its physical address
    pub fn alloc_small(&mut self) -> Option<PhysAddr> {
        for (i, word) in self.bitmap.iter_mut().enumerate() {
            // Check for available page
            if *word == 0 {
                continue;
            }

            let lzcnt = word.leading_zeros() as usize;

            // Available page found, mark it as occupied and return the corresponding address
            *word &= !(1 << (63 - lzcnt));
            let addr = (i * 64 + lzcnt) * SMALL_PAGE_SIZE;

            return Some(PhysAddr::new(addr as u64));
        }

        None
    }

    /// Frees a previously allocated 4 KiB small page
    ///
    /// ### SAFETY:
    /// Must be used only on addresses previously allocated by [`alloc_small()`](Pmm::alloc_small)
    pub fn free_small(&mut self, phys_addr: PhysAddr) {
        let addr = phys_addr.as_u64() as usize;
        assert!(addr.is_multiple_of(SMALL_PAGE_SIZE));

        let page_num = addr / SMALL_PAGE_SIZE;
        let word_idx = page_num / 64;
        let bit_idx = 63 - (page_num % 64);
        let mask = 1u64 << bit_idx;

        assert!(
            self.bitmap[word_idx] & mask == 0,
            "Double free of small page 0x{addr:X}"
        );

        self.bitmap[word_idx] |= mask;
    }

    /// Allocates a 2 MiB large page and returns its physical address
    pub fn alloc_large(&mut self) -> Option<PhysAddr> {
        const WORDS_PER_LARGE: usize = LARGE_PAGE_SIZE / SMALL_PAGE_SIZE / 64;

        self.bitmap
            .chunks_exact_mut(WORDS_PER_LARGE)
            .enumerate()
            .find_map(|(i, chunk)| {
                if chunk.iter().all(|&word| word == u64::MAX) {
                    chunk.fill(0);

                    let addr = i * LARGE_PAGE_SIZE;
                    Some(PhysAddr::new(addr as u64))
                } else {
                    None
                }
            })
    }

    /// Frees a previously allocated 2 MiB large page
    ///
    /// ### SAFETY:
    /// Must be used only on addresses previously allocated by [`alloc_large()`](Pmm::alloc_large)
    pub fn free_large(&mut self, phys_addr: PhysAddr) {
        const WORDS_PER_LARGE: usize = LARGE_PAGE_SIZE / SMALL_PAGE_SIZE / 64;

        let addr = phys_addr.as_u64() as usize;
        assert!(addr.is_multiple_of(LARGE_PAGE_ALIGN));

        let start_word = (addr / SMALL_PAGE_SIZE) / 64;
        let chunk = &mut self.bitmap[start_word..start_word + WORDS_PER_LARGE];

        assert!(
            chunk.iter().all(|&word| word == 0),
            "free_large on partially free/already free large page at 0x{addr:X}"
        );

        chunk.fill(u64::MAX);
    }

    fn mark_available(&mut self, page_addr: usize) {
        assert!(page_addr.is_multiple_of(SMALL_PAGE_SIZE));

        let page_num = page_addr / SMALL_PAGE_SIZE;
        let word_idx = page_num / 64;
        let bit_idx = 63 - page_num % 64;

        self.bitmap[word_idx] |= 1 << bit_idx;
    }

    fn mark_occupied(&mut self, page_addr: usize) {
        assert!(page_addr.is_multiple_of(SMALL_PAGE_SIZE));

        let page_num = page_addr / SMALL_PAGE_SIZE;
        let word_idx = page_num / 64;
        let bit_idx = 63 - page_num % 64;

        self.bitmap[word_idx] &= !(1 << bit_idx);
    }
}
