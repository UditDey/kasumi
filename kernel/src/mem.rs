use core::mem::MaybeUninit;
use core::sync::atomic::{AtomicU128, AtomicU64, Ordering};

use limine::memory_map::{Entry, EntryType};

use crate::{
    debug_print,
    debug_print::{HEADING_PREFIX, SUBHEADING_PREFIX},
    debug_println, MEM_MAP_REQUEST,
};

/// A physical address
type PAddr = u64;

/// A virtual address
type VAddr = u64;

/// The 'number' or index of a page
///
/// This is different from the starting adddress of the page.
/// Multiply by [`PAGE_SIZE`] to get the address
type PageNum = u64;

const PAGE_SIZE: usize = 4096;

#[derive(Debug)]
enum BlockType {
    SixtyFourMiB,
    FourGiB,
    EightGiB,
}

impl BlockType {
    pub fn select(size: u64) -> (Self, u64) {
        const MIB: u64 = 0x10_0000;
        const GIB: u64 = 0x4000_0000;

        if size <= 2 * GIB {
            (Self::SixtyFourMiB, size.div_ceil(64 * MIB))
        } else if size <= 4 * GIB {
            (Self::FourGiB, size.div_ceil(4 * GIB))
        } else {
            (Self::EightGiB, size.div_ceil(8 * GIB))
        }
    }

    pub fn space(&self) -> u64 {
        match self {
            Self::SixtyFourMiB => InnerAlloc::SIXTY_FOUR_MIB_SPACE as u64,
            Self::FourGiB => InnerAlloc::FOUR_GIB_SPACE as u64,
            Self::EightGiB => InnerAlloc::EIGHT_GIB_SPACE as u64,
        }
    }
}

enum InnerAlloc<'a> {
    SixtyFourMiB {
        level_one: AtomicU128,
        level_two: &'a [AtomicU128; 128],
    },

    FourGiB {
        level_one: AtomicU128,
        level_two: &'a [AtomicU128; 128],
        level_three: &'a [AtomicU64; 128 * 128],
    },

    EightGiB {
        level_one: AtomicU128,
        level_two: &'a [AtomicU128; 128],
        level_three: &'a [AtomicU128; 128 * 128],
    },
}

impl<'a> InnerAlloc<'a> {
    pub const SIXTY_FOUR_MIB_SPACE: usize = core::mem::size_of::<AtomicU128>() * (1 + 128);

    pub const FOUR_GIB_SPACE: usize = core::mem::size_of::<AtomicU128>() * (1 + 128)
        + core::mem::size_of::<AtomicU64>() * 128 * 128;

    pub const EIGHT_GIB_SPACE: usize = core::mem::size_of::<AtomicU128>() * (1 + 128 + 128 * 128);

    pub fn alloc(&self) -> Option<u32> {
        match self {
            Self::SixtyFourMiB {
                level_one,
                level_two,
            } => Self::alloc_64_mib(level_one, level_two),

            InnerAlloc::FourGiB {
                level_one,
                level_two,
                level_three,
            } => Self::alloc_4_gib(level_one, level_two, level_three),

            InnerAlloc::EightGiB {
                level_one,
                level_two,
                level_three,
            } => Self::alloc_8_gib(level_one, level_two, level_three),
        }
    }

    fn alloc_64_mib(level_one: &AtomicU128, level_two: &[AtomicU128; 128]) -> Option<u32> {
        loop {
            // Load the level one bitmap and find a free index
            let level_one_loaded = level_one.load(Ordering::Acquire);
            let level_one_idx = level_one_loaded.trailing_ones();

            // No free indices, this block is full
            if level_one_idx == 128 {
                return None;
            }

            // Load the level two bitmap and find a free page
            // We are guaranteed to find a free page if we passed the level one check
            let level_two = level_two
                .get(level_one_idx as usize)
                .expect("level_one_idx out of bounds");

            let level_two_loaded = level_two.load(Ordering::Acquire);
            let level_two_idx = level_two_loaded.trailing_ones();

            // Atomically mark this page as `used` by setting the corresponding bit
            let fetched = level_two.fetch_or(1 << level_two_idx, Ordering::Release);

            // Check the 'old' fetched value to see if the corresponding bit was already set
            // This means that another thread has swooped in and allocated this page and we have
            // to look for another one
            if fetched & (1 << level_two_idx) != 0 {
                continue;
            }

            // If the level two bitmap is full now, set the corresponding bit in level one to reflect this
            let level_two_is_full = level_two_loaded | (1 << level_two_idx) == u128::MAX;

            if level_two_is_full {
                level_one.fetch_or(1 << level_one_idx, Ordering::Release);
            }

            break Some(level_two_idx + (level_one_idx * 128));
        }
    }

    fn alloc_4_gib(
        level_one: &AtomicU128,
        level_two: &[AtomicU128; 128],
        level_three: &[AtomicU64; 128 * 128],
    ) -> Option<u32> {
        loop {
            // Load the level one bitmap and find a free index
            let level_one_loaded = level_one.load(Ordering::Acquire);
            let level_one_idx = level_one_loaded.trailing_ones();

            // No free indices, this block is full
            if level_one_idx == 128 {
                return None;
            }

            // Load the level two bitmap and find a free index
            // We are guaranteed to find a free index if we passed the level one check
            let level_two = level_two
                .get(level_one_idx as usize)
                .expect("level_one_idx out of bounds");

            let level_two_loaded = level_two.load(Ordering::Acquire);
            let level_two_idx = level_two_loaded.trailing_ones() + level_one_idx * 128;

            // Load the level three bitmap and find a free page
            // We are guaranteed to find a free page if we passed the level one check
            let level_three = level_three
                .get(level_two_idx as usize)
                .expect("level_two_idx out of bounds");

            let level_three_loaded = level_three.load(Ordering::Acquire);
            let level_three_idx = level_three_loaded.trailing_ones();

            // Atomically mark this page as `used` by setting the corresponding bit
            let fetched = level_three.fetch_or(1 << level_three_idx, Ordering::Release);

            // Check the 'old' fetched value to see if the corresponding bit was already set
            // This means that another thread has swooped in and allocated this page and we have
            // to look for another one
            if fetched & (1 << level_three_idx) != 0 {
                continue;
            }

            // If the level three bitmap is full now, set the corresponding bit in level two to reflect this
            let level_three_is_full = level_three_loaded | (1 << level_three_idx) == u64::MAX;

            if level_three_is_full {
                level_two.fetch_or(1 << level_two_idx, Ordering::Release);

                // Same goes for level two
                let level_two_is_full = level_two_loaded | (1 << level_two_idx) == u128::MAX;

                if level_two_is_full {
                    level_one.fetch_or(1 << level_one_idx, Ordering::Release);
                }
            }

            break Some(level_three_idx + (level_two_idx * 128) + (level_one_idx * 128 * 128));
        }
    }

    fn alloc_8_gib(
        level_one: &AtomicU128,
        level_two: &[AtomicU128; 128],
        level_three: &[AtomicU128; 128 * 128],
    ) -> Option<u32> {
        loop {
            // Load the level one bitmap and find a free index
            let level_one_loaded = level_one.load(Ordering::Acquire);
            let level_one_idx = level_one_loaded.trailing_ones();

            // No free indices, this block is full
            if level_one_idx == 128 {
                return None;
            }

            // Load the level two bitmap and find a free index
            // We are guaranteed to find a free index if we passed the level one check
            let level_two = level_two
                .get(level_one_idx as usize)
                .expect("level_one_idx out of bounds");

            let level_two_loaded = level_two.load(Ordering::Acquire);
            let level_two_idx = level_two_loaded.trailing_ones() + level_one_idx * 128;

            // Load the level three bitmap and find a free page
            // We are guaranteed to find a free page if we passed the level one check
            let level_three = level_three
                .get(level_two_idx as usize)
                .expect("level_two_idx out of bounds");

            let level_three_loaded = level_three.load(Ordering::Acquire);
            let level_three_idx = level_three_loaded.trailing_ones();

            // Atomically mark this page as `used` by setting the corresponding bit
            let fetched = level_three.fetch_or(1 << level_three_idx, Ordering::Release);

            // Check the 'old' fetched value to see if the corresponding bit was already set
            // This means that another thread has swooped in and allocated this page and we have
            // to look for another one
            if fetched & (1 << level_three_idx) != 0 {
                continue;
            }

            let level_three_is_full = level_three_loaded | (1 << level_three_idx) == u128::MAX;

            if level_three_is_full {
                level_two.fetch_or(1 << level_two_idx, Ordering::Release);
                let level_two_is_full = level_two_loaded | (1 << level_two_idx) == u128::MAX;

                if level_two_is_full {
                    level_one.fetch_or(1 << level_one_idx, Ordering::Release);
                }
            }

            break Some(level_three_idx + (level_two_idx * 128) + (level_one_idx * 128 * 128));
        }
    }
}

struct Block<'a> {
    base_page_num: PageNum,
    alloc: InnerAlloc<'a>,
}

struct PageAlloc<'a> {
    blocks: MaybeUninit<&'a [Block<'a>]>,
}

impl<'a> PageAlloc<'a> {
    pub const fn uninit() -> Self {
        Self {
            blocks: MaybeUninit::uninit(),
        }
    }
}

static PAGE_ALLOC: PageAlloc = PageAlloc::uninit();

pub fn init() {
    // Setup the page mapping
    // We setup the following regions, starting from the higher half
    // address (FFFF8000_00000000):
    // 1) Page alloc block list
    // 2) Page alloc bitmaps
    // 3) Higher-half direct map (HHDM)
    //
    // The kernel stays where its at (the -2GiB FFFFFFFF_80000000 mark)

    // Get the memory map from the bootloader
    let mem_map = MEM_MAP_REQUEST
        .get_response()
        .expect("Bootloader did not give us a memory map response");

    // Calculate space needed by the page alloc
    // Filter the usable memory entries
    let is_usable = |entry: &Entry| {
        entry.entry_type == EntryType::USABLE
            || entry.entry_type == EntryType::BOOTLOADER_RECLAIMABLE
            || entry.entry_type == EntryType::ACPI_RECLAIMABLE
    };

    let usable_entries = mem_map.entries().iter().filter(|entry| is_usable(entry));

    let mut num_blocks = 0; // Number of memory blocks
    let mut bitmap_space = 0; // Space taken up by the bitmaps in bytes

    for entry in usable_entries {
        let size = entry.length;
        let (block_type, num) = BlockType::select(size);

        debug_println!(
            "Entry size: {}, block type: {:?}, num blocks: {}",
            size,
            block_type,
            num
        );

        num_blocks += num;
        bitmap_space += block_type.space();
    }

    let page_alloc_space = (num_blocks * core::mem::size_of::<Block>() as u64) + bitmap_space;
    let page_alloc_num_pages = page_alloc_space.div_ceil(PAGE_SIZE as u64);

    debug_println!("Space needed by page alloc: {page_alloc_space} {page_alloc_num_pages}");
}
