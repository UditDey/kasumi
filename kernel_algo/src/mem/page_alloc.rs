#[cfg(not(loom))]
use core::sync::atomic::{AtomicU64, Ordering};

#[cfg(loom)]
use loom::sync::atomic::{AtomicU64, Ordering};

use super::{PageNum, PAGE_SIZE};

type AtomicWord = AtomicU64;
const ATOMIC_WORD_BITS: usize = 64;
const ATOMIC_WORD_MAX: u64 = u64::MAX;

struct TreeAlloc<'a>(&'a [AtomicWord]);

impl<'a> TreeAlloc<'a> {
    // A tree of height 5 with ATOMIC_WORD_BITS == 64 will have 1,073,741,824 leaf bits
    // With a page size of 4 KiB, that can represent 4 TiB of memory, which seems sufficient for a single region
    const MAX_HEIGHT: u32 = 5;

    // Tree geometry functions
    fn total_words_from_leaf_words(num_leaf_words: usize) -> usize {
        (ATOMIC_WORD_BITS * num_leaf_words - 1) / (ATOMIC_WORD_BITS - 1)
    }

    fn height_from_leaf_words(num_leaf_words: usize) -> usize {
        num_leaf_words.ilog(ATOMIC_WORD_BITS) as usize + 1
    }

    fn leaf_words_from_total_words(num_total_words: usize) -> usize {
        ((ATOMIC_WORD_BITS - 1) * num_total_words + 1) / ATOMIC_WORD_BITS
    }

    fn height_from_total_words(num_total_words: usize) -> usize {
        Self::height_from_leaf_words(Self::leaf_words_from_total_words(num_total_words))
    }

    /// Given a tree, get a slice of a layer in the tree
    ///
    /// Generic to allow for easier unit testing
    fn tree_layer<T>(tree: &[T], layer: u32) -> &[T] {
        let offset = (ATOMIC_WORD_BITS.pow(layer) - 1) / (ATOMIC_WORD_BITS - 1);
        let len = ATOMIC_WORD_BITS.pow(layer);

        tree.get(offset..(offset + len)).expect("Tree layer slice out of bounds")
    }

    /// Rounds up a number to the nearest power of a base
    fn round_up_to_power(num: usize, base: usize) -> usize {
        let log = num.ilog(base);

        if base.pow(log) == num {
            num
        } else {
            base.pow(log + 1)
        }
    }

    /// Calculates the space (in bytes) required for a tree alloc for a region based on its length (also in bytes)
    ///
    /// Returns 'None" if the region is too large and the height of the tree will exceed `MAX_HEIGHT`
    pub fn calc_size_for(len: usize) -> Option<usize> {
        // Pages occupied by this region
        let num_pages = len.div_ceil(PAGE_SIZE);

        // Number of leaf words
        let num_leaf_words_unrounded = num_pages.div_ceil(ATOMIC_WORD_BITS);

        // Number of leaf words rounded up to actually be a valid tree shape
        // (rounded up to be a power of ATOMIC_WORD_BITS)
        let num_leaf_words = Self::round_up_to_power(num_leaf_words_unrounded, ATOMIC_WORD_BITS);

        if Self::height_from_leaf_words(num_leaf_words) > Self::MAX_HEIGHT as usize {
            return None;
        }

        // Total number of words in the tree
        let num_total_words = Self::total_words_from_leaf_words(num_leaf_words);

        // Space needed for the tree
        Some(num_total_words * core::mem::size_of::<AtomicWord>())
    }

    pub fn alloc(&self) -> Option<usize> {
        // Height of this tree
        let height = Self::height_from_total_words(self.0.len());

        'search: loop {
            // Walk through the tree (excluding the leaf layer) to find a free page
            let mut layer = 0;
            let mut word_idx = 0;

            let (leaf_word, leaf_word_idx, leaf_bit_idx) = loop {
                #[allow(clippy::cast_possible_truncation, reason = "Layer will never ever be greater than u32::MAX")]
                let layer_slice = Self::tree_layer(self.0, layer as u32);

                let word = layer_slice.get(word_idx).expect("Layer slice index out of bounds");
                let bit_idx = word.load(Ordering::Acquire).trailing_ones() as usize;

                if bit_idx == ATOMIC_WORD_BITS {
                    // Full root word means no free pages left in this tree
                    // Full word in non root word means another thread modified the tree and we should restart the search
                    if layer == 0 {
                        return None;
                    }

                    continue 'search;
                }

                // Reached leaf layer, exit loop
                if layer == height - 1 {
                    break (word, word_idx, bit_idx);
                }

                word_idx = word_idx * ATOMIC_WORD_BITS + bit_idx;
                layer += 1;
            };

            // Free page's index
            let page_idx = leaf_word_idx * ATOMIC_WORD_BITS + leaf_bit_idx;

            // Mark the page as occupied in the leaf word
            let old = leaf_word.fetch_or(1 << leaf_bit_idx, Ordering::AcqRel);

            // If the bit was already set in the `old` value, it means another thread swooped in and allocated
            // this page before we could, restart our search
            if old & (1 << leaf_bit_idx) != 0 {
                continue 'search;
            }

            // Walk up the tree, updating the middle and root words
            let mut word_idx = leaf_word_idx / ATOMIC_WORD_BITS;
            let mut bit_idx = leaf_word_idx % ATOMIC_WORD_BITS;
            let mut child_word_full = old | (1 << leaf_bit_idx) == ATOMIC_WORD_MAX;

            for layer in (0..height - 1).rev() {
                #[allow(clippy::cast_possible_truncation, reason = "Layer will never ever be greater than u32::MAX")]
                let layer_slice = Self::tree_layer(self.0, layer as u32);

                if child_word_full {
                    let old = layer_slice
                        .get(word_idx)
                        .expect("Layer slice index out of bounds")
                        .fetch_or(1 << bit_idx, Ordering::AcqRel);

                    child_word_full = old | (1 << bit_idx) == ATOMIC_WORD_MAX;
                }

                bit_idx = word_idx % ATOMIC_WORD_BITS;
                word_idx /= ATOMIC_WORD_BITS;
            }

            return Some(page_idx);
        }
    }

    fn free(&self, page_idx: usize) {
        // Height of this tree
        let height = Self::height_from_total_words(self.0.len());

        // Mark this page as available in the leaf layer, and walk up the tree updating the middle and root words
        let mut word_idx = page_idx / ATOMIC_WORD_BITS;
        let mut bit_idx = page_idx % ATOMIC_WORD_BITS;

        for layer in (0..height).rev() {
            #[allow(clippy::cast_possible_truncation, reason = "Layer will never ever be greater than u32::MAX")]
            Self::tree_layer(self.0, layer as u32)
                .get(word_idx)
                .expect("Layer slice index out of bounds")
                .fetch_and(!(1 << bit_idx), Ordering::AcqRel);

            bit_idx = word_idx % ATOMIC_WORD_BITS;
            word_idx /= ATOMIC_WORD_BITS;
        }
    }
}

struct Region<'a> {
    base_page: PageNum,
    max_page: PageNum,
    tree: TreeAlloc<'a>,
}

pub struct PageAlloc<'a> {
    regions: &'a [Region<'a>],
}

impl<'a> PageAlloc<'a> {}

#[cfg(test)]
#[allow(clippy::unwrap_used, reason = "No need to be so rigid in tests")]
mod tests {
    use super::*;

    #[test]
    #[cfg(not(loom))]
    fn test_tree_geometry_fns() {
        // Creates a sample tree with given height
        // This creates a tree as a vec of vecs
        let create_tree = |height| {
            assert!(height > 0, "Cannot create tree with height less than 1");

            let mut tree = vec![];
            let mut layer_size = 1;
            let mut total_words = 0;

            for layer in 0..height {
                tree.push(vec![layer; layer_size]);
                total_words += layer_size;
                layer_size *= ATOMIC_WORD_BITS;
            }

            (tree, total_words)
        };

        // Test tree geometry functions
        for height in 1..=TreeAlloc::MAX_HEIGHT {
            let (tree, actual_total_words) = create_tree(height);
            let actual_leaf_words = tree.last().expect("Tree is empty").len();
            let actual_height = tree.len();

            assert_eq!(
                TreeAlloc::total_words_from_leaf_words(actual_leaf_words),
                actual_total_words,
                "total_words_from_leaf_words({actual_leaf_words}) failed"
            );

            assert_eq!(
                TreeAlloc::height_from_leaf_words(actual_leaf_words),
                actual_height,
                "height_from_leaf_words({actual_leaf_words}) failed"
            );

            assert_eq!(
                TreeAlloc::leaf_words_from_total_words(actual_total_words),
                actual_leaf_words,
                "leaf_words_from_total_words({actual_total_words}) failed"
            );

            assert_eq!(
                TreeAlloc::height_from_total_words(actual_total_words),
                actual_height,
                "height_from_total_words({actual_total_words}) failed"
            );
        }
    }

    #[test]
    #[cfg(not(loom))]
    fn test_tree_layer_fn() {
        // Creates a sample tree with given height
        // This creates a tree as a flat vec
        let create_tree = |height| {
            assert!(height > 0, "Cannot create tree with height less than 1");

            let mut tree = vec![];
            let mut layer_size = 1;
            let mut total_words = 0;

            for layer in 0..height {
                tree.extend(vec![layer; layer_size]);
                total_words += layer_size;
                layer_size *= ATOMIC_WORD_BITS;
            }

            (tree, total_words)
        };

        for height in 1..=TreeAlloc::MAX_HEIGHT {
            let (tree, _) = create_tree(height);

            // Test the tree layer function
            for layer in 0..height {
                let layer_slice = TreeAlloc::tree_layer(&tree, layer);
                let expected_layer_len = ATOMIC_WORD_BITS.pow(layer);

                assert_eq!(layer_slice.len(), expected_layer_len, "Layer slice length is incorrect");

                for &x in layer_slice {
                    assert_eq!(x, layer, "Layer value is incorrect");
                }
            }
        }
    }

    #[test]
    #[cfg(not(loom))]
    fn test_round_up_to_power() {
        assert_eq!(TreeAlloc::round_up_to_power(10, 5), 25);
        assert_eq!(TreeAlloc::round_up_to_power(50, 4), 64);
        assert_eq!(TreeAlloc::round_up_to_power(65, 4), 256);
        assert_eq!(TreeAlloc::round_up_to_power(64, 8), 64);
        assert_eq!(TreeAlloc::round_up_to_power(64, 64), 64);
    }

    #[test]
    #[cfg(not(loom))]
    fn test_tree_calc_size() {
        // Test case 1
        // We have a region of 20 pages, since ATOMIC_WORD_BITS = 64, this will need a tree with a single word
        assert_eq!(TreeAlloc::calc_size_for(20 * PAGE_SIZE), Some(core::mem::size_of::<AtomicWord>()));

        // Test case 2
        // We have a region of 70 pages, since ATOMIC_WORD_BITS = 64, this will need 2 leaf words, which will then be rounded up
        // to a power of 64, and the tree will have 64 leaf words and 1 root word (height = 2)
        assert_eq!(
            TreeAlloc::calc_size_for(70 * PAGE_SIZE),
            Some((64 + 1) * core::mem::size_of::<AtomicWord>())
        );

        // Test case 3
        // We have a region of 5000 pages, since ATOMIC_WORD_BITS = 64, this will need 79 leaf words, which will then be rounded up
        // to a power of 64, and the tree will have 4096 leaf words, 64 middle words and 1 root word (height = 3, total 4161 words)
        assert_eq!(
            TreeAlloc::calc_size_for(5000 * PAGE_SIZE),
            Some((4096 + 64 + 1) * core::mem::size_of::<AtomicWord>())
        );
    }

    #[test]
    #[cfg(not(loom))]
    fn test_tree_height_1() {
        // Lets assume we have a region of 64 pages, since ATOMIC_WORD_BITS = 64, this will need a tree of a single word
        assert_eq!(TreeAlloc::calc_size_for(64 * PAGE_SIZE), Some(core::mem::size_of::<AtomicWord>()));

        let tree = [AtomicWord::new(0); 1];
        let tree_alloc = TreeAlloc(&tree);

        // Allocate 4 pages
        assert_eq!(tree_alloc.alloc(), Some(0));
        assert_eq!(tree_alloc.alloc(), Some(1));
        assert_eq!(tree_alloc.alloc(), Some(2));
        assert_eq!(tree_alloc.alloc(), Some(3));

        assert_eq!(tree[0].load(Ordering::Acquire), 0b1111);

        // Free those 4 pages
        for i in 0..4 {
            tree_alloc.free(i);
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b0);

        // Allocate all pages, all bits should be 1 now
        for _ in 0..64 {
            assert!(tree_alloc.alloc().is_some());
        }

        assert_eq!(tree[0].load(Ordering::Acquire), !0b0);

        // Subsequent allocs should fail
        assert_eq!(tree_alloc.alloc(), None);
        assert_eq!(tree_alloc.alloc(), None);
        assert_eq!(tree_alloc.alloc(), None);
        assert_eq!(tree_alloc.alloc(), None);

        // Free all pages, all bits should be 0 now
        for i in 0..64 {
            tree_alloc.free(i);
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
    }

    #[test]
    #[cfg(not(loom))]
    fn test_tree_height_2() {
        // Lets assume we have a region of 4096 pages, since ATOMIC_WORD_BITS = 64, this will need a tree of a 65 words (height = 2)
        assert_eq!(TreeAlloc::calc_size_for(4096 * PAGE_SIZE), Some(65 * core::mem::size_of::<AtomicWord>()));

        let tree: [AtomicWord; 65] = std::array::from_fn(|_| AtomicWord::new(0));
        let tree_alloc = TreeAlloc(&tree);

        // Allocate 4 pages
        assert_eq!(tree_alloc.alloc(), Some(0));
        assert_eq!(tree_alloc.alloc(), Some(1));
        assert_eq!(tree_alloc.alloc(), Some(2));
        assert_eq!(tree_alloc.alloc(), Some(3));

        assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
        assert_eq!(tree[1].load(Ordering::Acquire), 0b1111);

        // Free those 4 pages
        for i in 0..4 {
            tree_alloc.free(i);
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
        assert_eq!(tree[1].load(Ordering::Acquire), 0b0);

        // Allocate 64 pages, now the 0th word in layer 1 should be full and the 0th bit in the
        // root word should reflect that
        for _ in 0..64 {
            assert!(tree_alloc.alloc().is_some());
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b1);
        assert_eq!(tree[1].load(Ordering::Acquire), !0b0);

        // Free those 64 pages
        for i in 0..64 {
            tree_alloc.free(i);
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
        assert_eq!(tree[1].load(Ordering::Acquire), 0b0);

        // Allocate 128 pages, now the 1st word in layer 1 should be full as well and the 1st bit
        // in the root word should reflect that
        for _ in 0..128 {
            assert!(tree_alloc.alloc().is_some());
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b11);
        assert_eq!(tree[1].load(Ordering::Acquire), !0b0);
        assert_eq!(tree[2].load(Ordering::Acquire), !0b0);

        // Free those 128 pages
        for i in 0..128 {
            tree_alloc.free(i);
        }

        assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
        assert_eq!(tree[1].load(Ordering::Acquire), 0b0);
        assert_eq!(tree[2].load(Ordering::Acquire), 0b0);

        // Allocate all pages, all bits should be 1 now
        for _ in 0..4096 {
            assert!(tree_alloc.alloc().is_some());
        }

        for word in &tree {
            assert_eq!(word.load(Ordering::Acquire), !0b0);
        }

        // Subsequent allocs should fail
        assert_eq!(tree_alloc.alloc(), None);
        assert_eq!(tree_alloc.alloc(), None);
        assert_eq!(tree_alloc.alloc(), None);
        assert_eq!(tree_alloc.alloc(), None);

        // Free all pages, all bits should be 0 now
        for i in 0..4096 {
            tree_alloc.free(i);
        }

        for word in &tree {
            assert_eq!(word.load(Ordering::Acquire), 0b0);
        }
    }

    #[test]
    #[cfg(not(loom))]
    fn test_tree_all_heights() {
        // Creates a sample tree with given height
        let create_tree = |height| {
            assert!(height > 0, "Cannot create tree with height less than 1");

            let mut tree = vec![];
            let mut layer_size = 1;

            for _ in 0..height {
                for _ in 0..layer_size {
                    tree.push(AtomicWord::new(0));
                }

                layer_size *= ATOMIC_WORD_BITS;
            }

            tree
        };

        // Test for heights up to 4 because otherwise the test will take forever
        for height in 1..=4 {
            println!("Testing height = {height}");

            let tree = create_tree(height);
            let tree_alloc = TreeAlloc(&tree);
            let expected_max_allocs = ATOMIC_WORD_BITS.pow(height);

            let mut prev_page_idx = None;

            for i in 0..expected_max_allocs {
                let page_idx = tree_alloc.alloc().expect("Alloc failed unexpectedly");

                if let Some(prev_page_idx) = prev_page_idx {
                    assert_eq!(page_idx, prev_page_idx + 1);
                } else {
                    assert_eq!(page_idx, 0);
                }

                prev_page_idx = Some(page_idx);
            }

            // All bits should be 1 now
            for word in &tree {
                assert_eq!(word.load(Ordering::Acquire), !0b0);
            }

            // Subsequent allocs should fail
            assert!(tree_alloc.alloc().is_none());
            assert!(tree_alloc.alloc().is_none());
            assert!(tree_alloc.alloc().is_none());
            assert!(tree_alloc.alloc().is_none());

            // Free all pages, all bits should be 0 now
            for i in 0..expected_max_allocs {
                tree_alloc.free(i);
            }

            for word in &tree {
                assert_eq!(word.load(Ordering::Acquire), 0b0);
            }
        }
    }

    //#[test]
    #[cfg(loom)]
    fn test_tree_height_1_loom() {
        // Similar to test_tree_height_1() but we verify with concurrent accesses
        use std::sync::Arc;

        // Lets assume we have a region of 64 pages, since ATOMIC_WORD_BITS = 64, this will need a tree of a single word
        assert_eq!(TreeAlloc::calc_size_for(64 * PAGE_SIZE), Some(core::mem::size_of::<AtomicWord>()));

        loom::model(|| {
            let tree = Arc::new([AtomicWord::new(0); 1]);

            // Allocate 61 pages on the main thread
            let pages = (0..61).map(|_| TreeAlloc(tree.as_slice()).alloc().unwrap()).collect::<Vec<usize>>();
            assert_eq!(pages, (0..61).collect::<Vec<usize>>());

            // Allocate 3 pages, each from a seperate thread
            let thread_1 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).alloc().unwrap()
            });

            let thread_2 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).alloc().unwrap()
            });

            let page_0 = TreeAlloc(tree.as_slice()).alloc().unwrap();
            let page_1 = thread_1.join().unwrap();
            let page_2 = thread_2.join().unwrap();

            // The new pages should be distinct and be in the range 61, 62, 63
            let mut list = [page_0, page_1, page_2];
            list.sort();
            assert_eq!(list, [61, 62, 63]);
            assert_eq!(tree[0].load(Ordering::Acquire), !0b0);

            // Free all pages
            let thread_1 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).free(0)
            });

            let thread_2 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).free(1)
            });

            TreeAlloc(tree.as_slice()).free(2);
            thread_1.join().unwrap();
            thread_2.join().unwrap();

            assert_eq!(tree[0].load(Ordering::Acquire), !0b111);
        });
    }

    //#[test]
    #[cfg(loom)]
    fn test_tree_height_2_loom() {
        // Similar to test_tree_height_2() but we verify with concurrent accesses
        use std::sync::Arc;

        // Lets assume we have a region of 4096 pages, since ATOMIC_WORD_BITS = 64, this will need a tree of a 65 words (height = 2)
        assert_eq!(TreeAlloc::calc_size_for(4096 * PAGE_SIZE), Some(65 * core::mem::size_of::<AtomicWord>()));

        loom::model(|| {
            let tree: Arc<[AtomicWord; 65]> = Arc::new(std::array::from_fn(|_| AtomicWord::new(0)));

            // Allocate 61 pages on the main thread
            let pages = (0..61).map(|_| TreeAlloc(tree.as_slice()).alloc().unwrap()).collect::<Vec<usize>>();
            assert_eq!(pages, (0..61).collect::<Vec<usize>>());

            // Allocate 3 pages, each from a seperate thread
            let thread_1 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).alloc().unwrap()
            });

            let thread_2 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).alloc().unwrap()
            });

            let page_0 = TreeAlloc(tree.as_slice()).alloc().unwrap();
            let page_1 = thread_1.join().unwrap();
            let page_2 = thread_2.join().unwrap();

            // The allocated pages should be distinct and be in the range 61, 62, 63
            let mut list = [page_0, page_1, page_2];
            list.sort();
            assert_eq!(list, [61, 62, 63]);
            assert_eq!(tree[0].load(Ordering::Acquire), 0b1);
            assert_eq!(tree[1].load(Ordering::Acquire), !0b0);

            // Free those 3 pages
            let thread_1 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).free(0)
            });

            let thread_2 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).free(1)
            });

            TreeAlloc(tree.as_slice()).free(2);
            thread_1.join().unwrap();
            thread_2.join().unwrap();

            assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
            assert_eq!(tree[1].load(Ordering::Acquire), !0b111);
        });
    }

    // TODO: Get this height = 3 loom test to run without stack overflow
    /*#[test]
    #[cfg(loom)]
    fn test_tree_height_3_loom() {
        use std::sync::Arc;

        // Lets assume we have a region of 262,144 pages, since ATOMIC_WORD_BITS = 64, this will need a tree of a 4161 words (height = 3)
        assert_eq!(
            TreeAlloc::calc_size_for(262_144 * PAGE_SIZE),
            Some(4161 * core::mem::size_of::<AtomicWord>())
        );

        loom::model(|| {
            let tree: Arc<[AtomicWord; 4161]> = Arc::new(std::array::from_fn(|_| AtomicWord::new(0)));

            // Allocate 61 pages on the main thread
            let pages = (0..61).map(|_| TreeAlloc(tree.as_slice()).alloc().unwrap()).collect::<Vec<usize>>();
            assert_eq!(pages, (0..61).collect::<Vec<usize>>());

            // Allocate 3 pages, each from a seperate thread
            let thread_1 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).alloc().unwrap()
            });

            let thread_2 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).alloc().unwrap()
            });

            let page_0 = TreeAlloc(tree.as_slice()).alloc().unwrap();
            let page_1 = thread_1.join().unwrap();
            let page_2 = thread_2.join().unwrap();

            // The allocated pages should be distinct and be in the range 61, 62, 63
            let mut list = [page_0, page_1, page_2];
            list.sort();
            assert_eq!(list, [61, 62, 63]);
            assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
            assert_eq!(tree[1].load(Ordering::Acquire), 0b1);
            assert_eq!(tree[65].load(Ordering::Acquire), !0b0);

            // Free those 3 pages
            let thread_1 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).free(0)
            });

            let thread_2 = loom::thread::spawn({
                let tree = Arc::clone(&tree);
                move || TreeAlloc(tree.as_slice()).free(1)
            });

            TreeAlloc(tree.as_slice()).free(2);
            thread_1.join().unwrap();
            thread_2.join().unwrap();

            assert_eq!(tree[0].load(Ordering::Acquire), 0b0);
            assert_eq!(tree[1].load(Ordering::Acquire), 0b0);
            assert_eq!(tree[65].load(Ordering::Acquire), !0b111);
        });
    }*/
}
