use core::{
    mem::MaybeUninit,
    sync::atomic::{AtomicU128, Ordering},
};

use limine::memory_map::{Entry, EntryType};

use crate::{debug_println, MEM_MAP_REQUEST};

/// A physical address
type PAddr = usize;

/// A virtual address
type VAddr = usize;

const PAGE_SIZE: usize = 4096;

/// The 'number' or index of a page
///
/// This is different from the starting adddress of the page.
/// Multiply by [`PAGE_SIZE`] to get the address
type PageNum = usize;

struct Bump(usize);

impl Bump {
    pub fn alloc_slice_uninit<T>(&mut self, len: usize) -> &'static mut [T] {
        let align = core::mem::align_of::<T>();
        let addr = Self::align_addr(self.0, align);

        // SAFETY: We have to assume that
        let slice = unsafe { core::slice::from_raw_parts_mut(addr as *mut T, len) };

        self.0 = addr + len * core::mem::size_of::<T>();

        slice
    }

    fn align_addr(addr: usize, align: usize) -> usize {
        let align_mask = align - 1;

        if addr & align_mask == 0 {
            addr
        } else {
            (addr | align_mask) + 1
        }
    }
}

#[repr(C)]
enum BlockAlloc {
    FourMiB(AtomicU128, &'static mut [AtomicU128; 8]),
    EightMiB(AtomicU128, &'static mut [AtomicU128; 16]),
    SixteenMiB(AtomicU128, &'static mut [AtomicU128; 32]),
    ThirtyTwoMiB(AtomicU128, &'static mut [AtomicU128; 64]),
    SixtyFourMiB(AtomicU128, &'static mut [AtomicU128; 128]),

    FiveOneTwoMiB(AtomicU128, &'static mut [AtomicU128; 8], &'static mut [AtomicU128; 8 * 128]),
    OneGiB(AtomicU128, &'static mut [AtomicU128; 16], &'static mut [AtomicU128; 16 * 128]),
    TwoGiB(AtomicU128, &'static mut [AtomicU128; 32], &'static mut [AtomicU128; 32 * 128]),
    FourGiB(AtomicU128, &'static mut [AtomicU128; 64], &'static mut [AtomicU128; 64 * 128]),
    EightGiB(
        AtomicU128,
        &'static mut [AtomicU128; 128],
        &'static mut [AtomicU128; 128 * 128],
    ),
}

impl BlockAlloc {
    #[allow(
        clippy::unwrap_used,
        reason = "We use lots of try_into().unwrap()s here to do slice -> array conversions we know will succeed"
    )]
    pub fn setup(bump: &mut Bump, size: u64) -> Self {
        const MIB: u64 = 0x10_0000;
        const GIB: u64 = 0x4000_0000;

        if size <= 4 * MIB {
            let bitmap = bump.alloc_slice_uninit::<u128>(8);
            bitmap.fill(0);
            let bitmap = AtomicU128::from_mut_slice(bitmap);
            Self::FourMiB(AtomicU128::new(0), bitmap.try_into().unwrap())
        } else if size <= 8 * MIB {
            let bitmap = bump.alloc_slice_uninit::<u128>(16);
            bitmap.fill(0);
            let bitmap = AtomicU128::from_mut_slice(bitmap);
            Self::EightMiB(AtomicU128::new(0), bitmap.try_into().unwrap())
        } else if size <= 16 * MIB {
            let bitmap = bump.alloc_slice_uninit::<u128>(32);
            bitmap.fill(0);
            let bitmap = AtomicU128::from_mut_slice(bitmap);
            Self::SixteenMiB(AtomicU128::new(0), bitmap.try_into().unwrap())
        } else if size <= 32 * MIB {
            let bitmap = bump.alloc_slice_uninit::<u128>(64);
            bitmap.fill(0);
            let bitmap = AtomicU128::from_mut_slice(bitmap);
            Self::ThirtyTwoMiB(AtomicU128::new(0), bitmap.try_into().unwrap())
        } else if size <= 64 * MIB {
            let bitmap = bump.alloc_slice_uninit::<u128>(128);
            bitmap.fill(0);
            let bitmap = AtomicU128::from_mut_slice(bitmap);
            Self::SixtyFourMiB(AtomicU128::new(0), bitmap.try_into().unwrap())
        } else if size <= 512 * MIB {
            let level_one = bump.alloc_slice_uninit::<u128>(8);
            let level_two = bump.alloc_slice_uninit::<u128>(8 * 128);

            level_one.fill(0);
            level_two.fill(0);

            let level_one = AtomicU128::from_mut_slice(level_one);
            let level_two = AtomicU128::from_mut_slice(level_two);

            Self::FiveOneTwoMiB(
                AtomicU128::new(0),
                level_one.try_into().unwrap(),
                level_two.try_into().unwrap(),
            )
        } else if size <= GIB {
            let level_one = bump.alloc_slice_uninit::<u128>(16);
            let level_two = bump.alloc_slice_uninit::<u128>(16 * 128);

            level_one.fill(0);
            level_two.fill(0);

            let level_one = AtomicU128::from_mut_slice(level_one);
            let level_two = AtomicU128::from_mut_slice(level_two);

            Self::OneGiB(
                AtomicU128::new(0),
                level_one.try_into().unwrap(),
                level_two.try_into().unwrap(),
            )
        } else if size <= 2 * GIB {
            let level_one = bump.alloc_slice_uninit::<u128>(32);
            let level_two = bump.alloc_slice_uninit::<u128>(32 * 128);

            level_one.fill(0);
            level_two.fill(0);

            let level_one = AtomicU128::from_mut_slice(level_one);
            let level_two = AtomicU128::from_mut_slice(level_two);

            Self::TwoGiB(
                AtomicU128::new(0),
                level_one.try_into().unwrap(),
                level_two.try_into().unwrap(),
            )
        } else if size <= 4 * GIB {
            let level_one = bump.alloc_slice_uninit::<u128>(64);
            let level_two = bump.alloc_slice_uninit::<u128>(64 * 128);

            level_one.fill(0);
            level_two.fill(0);

            let level_one = AtomicU128::from_mut_slice(level_one);
            let level_two = AtomicU128::from_mut_slice(level_two);

            Self::FourGiB(
                AtomicU128::new(0),
                level_one.try_into().unwrap(),
                level_two.try_into().unwrap(),
            )
        } else {
            let level_one = bump.alloc_slice_uninit::<u128>(128);
            let level_two = bump.alloc_slice_uninit::<u128>(128 * 128);

            level_one.fill(0);
            level_two.fill(0);

            let level_one = AtomicU128::from_mut_slice(level_one);
            let level_two = AtomicU128::from_mut_slice(level_two);

            Self::EightGiB(
                AtomicU128::new(0),
                level_one.try_into().unwrap(),
                level_two.try_into().unwrap(),
            )
        }
    }

    pub fn alloc(&self) -> Option<PageNum> {
        match self {
            BlockAlloc::FourMiB(level_one, level_two) => Self::search_two_level(level_one, 8, level_two.as_slice()),
            BlockAlloc::EightMiB(level_one, level_two) => Self::search_two_level(level_one, 16, level_two.as_slice()),
            BlockAlloc::SixteenMiB(level_one, level_two) => Self::search_two_level(level_one, 32, level_two.as_slice()),
            BlockAlloc::ThirtyTwoMiB(level_one, level_two) => Self::search_two_level(level_one, 64, level_two.as_slice()),
            BlockAlloc::SixtyFourMiB(level_one, level_two) => Self::search_two_level(level_one, 128, level_two.as_slice()),

            BlockAlloc::FiveOneTwoMiB(level_one, level_two, level_three) => {
                Self::search_three_level(level_one, 8, level_two.as_slice(), level_three.as_slice())
            }
            BlockAlloc::OneGiB(level_one, level_two, level_three) => {
                Self::search_three_level(level_one, 16, level_two.as_slice(), level_three.as_slice())
            }
            BlockAlloc::TwoGiB(level_one, level_two, level_three) => {
                Self::search_three_level(level_one, 32, level_two.as_slice(), level_three.as_slice())
            }
            BlockAlloc::FourGiB(level_one, level_two, level_three) => {
                Self::search_three_level(level_one, 64, level_two.as_slice(), level_three.as_slice())
            }
            BlockAlloc::EightGiB(level_one, level_two, level_three) => {
                Self::search_three_level(level_one, 128, level_two.as_slice(), level_three.as_slice())
            }
        }
    }

    fn search_two_level(level_one: &AtomicU128, level_one_size: u32, level_two: &[AtomicU128]) -> Option<PageNum> {
        loop {
            // Load the level one bitmap and find a free index
            let level_two_idx = level_one.load(Ordering::Acquire).trailing_ones();

            // No free indices, this block is full
            if level_two_idx == level_one_size {
                return None;
            }

            // Load the level two bitmap and find a free page
            // We are guaranteed to find a free page if we passed the level one check
            let level_two_word = level_two.get(level_two_idx as usize).expect("level_two_idx out of bounds");
            let level_two_loaded = level_two_word.load(Ordering::Acquire);

            let idx = level_two_loaded.trailing_ones();

            // Atomically mark this page as `used` by setting the corresponding bit
            let fetched = level_two_word.fetch_or(1 << idx, Ordering::Release);

            // Check the 'old' fetched value to see if the corresponding bit was already set
            // This means that another thread has swooped in and allocated this page and we have
            // to look for another one
            if fetched & (1 << idx) != 0 {
                continue;
            }

            // If the level two bitmap is full now, set the corresponding bit in level one to reflect this
            let level_two_is_full = level_two_loaded | (1 << idx) == u128::MAX;

            if level_two_is_full {
                level_one.fetch_or(1 << level_two_idx, Ordering::Release);
            }

            let page_num = idx + (128 * level_two_idx);
            break Some(page_num as PageNum);
        }
    }

    fn search_three_level(
        level_one: &AtomicU128,
        level_one_size: u32,
        level_two: &[AtomicU128],
        level_three: &[AtomicU128],
    ) -> Option<PageNum> {
        loop {
            // Load the level one bitmap and find a free index
            let level_two_idx = level_one.load(Ordering::Acquire).trailing_ones();

            // No free indices, this block is full
            if level_two_idx == level_one_size {
                return None;
            }

            // Load the level two bitmap and find a free index
            // We are guaranteed to find a free index if we passed the level one check
            let level_two_word = level_two.get(level_two_idx as usize).expect("level_two_idx out of bounds");
            let level_two_loaded = level_two_word.load(Ordering::Acquire);

            let level_three_idx = level_two_loaded.trailing_ones();

            // Load the level three bitmap and find a free page
            // We are guaranteed to find a free page if we passed the level one check
            let level_three_word = level_three
                .get(level_three_idx as usize + 128 * level_two_idx as usize)
                .expect("level_three_idx out of bounds");

            let level_three_loaded = level_three_word.load(Ordering::Acquire);
            let idx = level_three_loaded.trailing_ones();

            // Atomically mark this page as `used` by setting the corresponding bit
            let fetched = level_three_word.fetch_or(1 << idx, Ordering::Release);

            // Check the 'old' fetched value to see if the corresponding bit was already set
            // This means that another thread has swooped in and allocated this page and we have
            // to look for another one
            if fetched & (1 << idx) != 0 {
                continue;
            }

            // If the level three bitmap is full now, set the corresponding bit in level two to reflect this
            let level_three_is_full = level_three_loaded | (1 << idx) == u128::MAX;

            if level_three_is_full {
                level_two_word.fetch_or(1 << level_three_idx, Ordering::Release);

                // Same goes for level two
                let level_two_is_full = level_two_loaded | (1 << level_three_idx) == u128::MAX;

                if level_two_is_full {
                    level_one.fetch_or(1 << level_two_idx, Ordering::Release);
                }
            }

            let page_num = idx + (128 * level_three_idx);
            break Some(page_num as PageNum);
        }
    }
}

#[repr(C)]
struct Block {
    base_page_num: PageNum,
    alloc: BlockAlloc,
}

struct PageAlloc(MaybeUninit<&'static [Block]>);

impl PageAlloc {
    pub const fn uninit() -> Self {
        Self(MaybeUninit::uninit())
    }

    pub fn init(&self, block_list: &'static [Block]) {
        // SAFETY: Kooky way of initializing the page alloc, probably need to find something nicer
        unsafe { self.0.as_ptr().cast_mut().write(block_list) }
    }

    pub fn alloc(&self) {
        // SAFETY: The page alloc is assumed to have been initialised by now
        let block_list = unsafe { self.0.assume_init() };

        for block in block_list {
            debug_println!("Base page num: {}", block.base_page_num);
        }
    }
}

static PAGE_ALLOC: PageAlloc = PageAlloc::uninit();

pub fn init() {
    // Get the memory map from the bootloader
    let mem_map = MEM_MAP_REQUEST
        .get_response()
        .expect("Bootloader did not give us a memory map response");

    // Filter the usable memory entries
    let is_usable = |entry: &Entry| {
        entry.entry_type == EntryType::USABLE
            || entry.entry_type == EntryType::BOOTLOADER_RECLAIMABLE
            || entry.entry_type == EntryType::ACPI_RECLAIMABLE
    };

    let usable_entries = mem_map.entries().iter().filter(|entry| is_usable(entry));

    // Set up structures starting from the higher half starting addr
    // We allocate areas in a bump allocator style
    let mut bump = Bump(0xFFFF_8000_0000_0000);

    // Setup the page alloc block list
    let num_blocks = usable_entries.clone().count();
    let block_list = bump.alloc_slice_uninit::<Block>(num_blocks);

    // Setup the page alloc bitmaps and initialize block list
    for (entry, block) in usable_entries.zip(block_list.iter_mut()) {
        #[allow(clippy::cast_possible_truncation, reason = "usize and u64 have same size here")]
        let base_addr = entry.base as usize;

        block.base_page_num = base_addr.div_ceil(PAGE_SIZE);
        block.alloc = BlockAlloc::setup(&mut bump, entry.length);
    }

    // Setup the page allocator
    PAGE_ALLOC.init(block_list);

    PAGE_ALLOC.alloc();
}
