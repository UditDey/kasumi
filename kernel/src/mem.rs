use core::sync::atomic::{AtomicU128, Ordering};

use crate::{
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

const PAGE_SIZE: u64 = 4096;

struct BitTree(AtomicU128);

impl BitTree {
    const TREE_HEIGHT: u32 = 128u8.ilog2();
    const NUM_NON_LEAVES: u8 = 128 / 2;

    pub fn find(&self) -> Option<u8> {
        let tree = self.0.load(Ordering::Acquire);

        if tree.leading_zeros() == 0 {
            return None;
        }

        let mut idx = 0;

        for _ in 0..Self::TREE_HEIGHT - 1 {
            let left_child_idx = idx * 2 + 1;
            let right_child_idx = idx * 2 + 2;

            idx = if tree & (1 << left_child_idx) == 0 {
                left_child_idx
            } else {
                right_child_idx
            };
        }

        Some(idx + 1 - Self::NUM_NON_LEAVES)
    }

    pub fn mark_used(&self, idx: u8) {}
}

struct PageAlloc<'a> {
    a: core::marker::PhantomData<&'a ()>,
}

impl<'a> PageAlloc<'a> {
    pub const fn new() -> Self {
        Self {
            a: core::marker::PhantomData,
        }
    }
}

static PAGE_ALLOC: PageAlloc = PageAlloc::new();

pub fn init() {
    // Start by setting up the page allocator
    let mem_map = MEM_MAP_REQUEST
        .get_response()
        .expect("Bootloader did not give us a memory map response");

    for entry in mem_map.entries() {
        debug_println!(
            "base: {:#X}, length: {:#X}, type: {:?}",
            entry.base,
            entry.length,
            entry.entry_type
        );
    }
}
