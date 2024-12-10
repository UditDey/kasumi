use core::ptr::NonNull;

use spinning_top::Spinlock;

use crate::{
    debug_print::{HEADING, SUBHEADING},
    debug_println,
    mem::{LARGE_PAGE_SIZE, SMALL_PAGE_SIZE},
};

const CHUNK_ALIGN: usize = LARGE_PAGE_SIZE;
const CHUNK_SIZE: usize = LARGE_PAGE_SIZE;

pub const SLOT_ALIGN: usize = SMALL_PAGE_SIZE;
pub const SLOT_SIZE: usize = SMALL_PAGE_SIZE;

struct FreelistNode {
    num_free_chunks: usize,
    next: Option<NonNull<Self>>,
}

// Safety: Can be accessed from any thread no problem
unsafe impl Send for FreelistNode {}

struct ChunkHeader {
    slot_bitmap: [u64; 8],
    num_occupied_slots: u16,
    slot_metadata: [u32; 511],
    next: Option<NonNull<Self>>,
    prev: Option<NonNull<Self>>,
    freelist_node: FreelistNode,
}

// Safety: Can be accessed from any thread no problem
unsafe impl Send for ChunkHeader {}

impl ChunkHeader {
    // Since the chunk header occupies slot 0 in a chunk, we need to ensure that the
    // header fits within a slot and doesn't overflow into the next one
    const _SIZE_CHECK: () = assert!(core::mem::size_of::<Self>() <= SLOT_SIZE);

    fn new(num_free_chunks_after: usize) -> Self {
        Self {
            slot_bitmap: [0; 8],
            num_occupied_slots: 0,
            slot_metadata: [0; 511],
            next: None,
            prev: None,
            freelist_node: FreelistNode {
                num_free_chunks: num_free_chunks_after,
                next: None,
            },
        }
    }

    fn alloc_slot(&mut self) -> Option<NonNull<u8>> {
        let slot_idx = self
            .slot_bitmap
            .iter_mut()
            .enumerate()
            .find_map(|(word_idx, word)| {
                let bit_idx = word.trailing_ones() as usize;

                // When bit_idx == 64, the entire word is full of 1s, and no slots are free
                if bit_idx == 64 {
                    None
                } else {
                    // Free slot found, mark as allocated and calculate it's `slot_idx`
                    *word |= 1 << bit_idx;
                    Some(word_idx * 64 + bit_idx)
                }
            });

        // There are 512 slots per chunk in total, but slot 0 is occupied by chunk header, so valid
        // range of `slot_idx` is (1..=510), map it to this range and reject out of bounds case
        let slot_idx = match slot_idx {
            None | Some(511..) => return None,
            Some(idx) => idx + 1,
        };

        // Safety: The off-set pointer is guaranteed to be within the chunk's range because `slot_idx` is in range (1..=510)
        let slot_ptr = unsafe {
            core::ptr::from_mut(self)
                .cast::<u8>()
                .add(slot_idx * SLOT_SIZE)
        };

        // Increment counter
        self.num_occupied_slots += 1;

        Some(NonNull::new(slot_ptr)).expect("`slot_ptr` is null somehow")
    }
}

struct HeapAlloc {
    chunk_list: Option<NonNull<ChunkHeader>>,
    freelist: Option<NonNull<FreelistNode>>,
}

// Safety: Can be accessed from any thread no problem
unsafe impl Send for HeapAlloc {}

static HEAP_ALLOC: Spinlock<HeapAlloc> = Spinlock::new(HeapAlloc {
    chunk_list: None,
    freelist: None,
});

// Bootstrap heap chunk space reserved in the linker script
extern "C" {
    static mut BOOTSTRAP_HEAP_CHUNK_START: u8;
    static mut BOOTSTRAP_HEAP_CHUNK_END: u8;
}

pub fn init() {
    // Set up the bootstrap heap chunk
    debug_println!(HEADING; "Initializing kernel heap");

    let boot_chunk_start = core::ptr::addr_of_mut!(BOOTSTRAP_HEAP_CHUNK_START);
    let boot_chunk_end = core::ptr::addr_of_mut!(BOOTSTRAP_HEAP_CHUNK_END);

    // Double check alignment and size of the bootstrap chunk
    assert!(boot_chunk_start as usize % CHUNK_ALIGN == 0);
    assert!(boot_chunk_end as usize - boot_chunk_start as usize == CHUNK_SIZE);

    let total_heap_chunks = (usize::MAX - boot_chunk_start as usize) / CHUNK_SIZE;
    let max_heap_size_mib = total_heap_chunks * 2;

    debug_println!(SUBHEADING; "Kernel heap starting at 0x{:X}", boot_chunk_start as usize);
    debug_println!(SUBHEADING; "Max heap size: {} MiB", max_heap_size_mib);

    // Initialize boot chunk header
    #[allow(clippy::cast_ptr_alignment, reason = "Pointer ensured to be aligned")]
    let boot_chunk_hdr = boot_chunk_start.cast::<ChunkHeader>();
    assert!(boot_chunk_hdr.is_aligned());

    let free_chunks_after_boot_chunk = total_heap_chunks - 1;

    // Safety: Pointer is valid and aligned
    unsafe {
        *boot_chunk_hdr = ChunkHeader::new(free_chunks_after_boot_chunk);
    }

    // Get addr of the freelist node embedded in the chunk header
    // Safety: We've just initialized `boot_chunk_hdr`
    let freelist_node = unsafe { core::ptr::addr_of_mut!((*boot_chunk_hdr).freelist_node) };

    // Initialize heap alloc
    let boot_chunk_hdr = NonNull::new(boot_chunk_hdr).expect("`boot_chunk_hdr` pointer is null");
    let freelist_node = NonNull::new(freelist_node).expect("`freelist_node` pointer is null");

    *HEAP_ALLOC.lock() = HeapAlloc {
        chunk_list: Some(boot_chunk_hdr),
        freelist: Some(freelist_node),
    };
}

pub fn alloc_slot() -> NonNull<u8> {
    let heap_alloc = HEAP_ALLOC.lock();

    let mut chunk_hdr = heap_alloc
        .chunk_list
        .expect("No available heap chunks left");

    // Safety: `chunk_hdr` always points to a previously initialised struct and is not aliased
    // because we have a lock on `HEAP_ALLOC`
    let slot = unsafe { chunk_hdr.as_mut().alloc_slot() };

    slot.expect("Chunk is in chunk list but has no free slots, should never happen")
}

/// # Safety:
/// Note that this DOES NOT LOCK `HEAP_ALLOC`
///
/// Although normally all accesses to a chunk header requires locking `HEAP_ALLOC`, the slot metadatas
/// are an exception. The metadatas are owned by their respective slot's owners, so it is up to the
/// slot owner to ensure that each slot metadata has one exclusive accessor at a time
pub fn update_slot_metadata<F, T>(addr_in_slot: usize, mut f: F) -> T
where
    F: FnMut(&mut u32) -> T,
{
    let chunk_addr = (addr_in_slot / CHUNK_ALIGN) * CHUNK_ALIGN;
    let slot_addr = (addr_in_slot / SLOT_ALIGN) * SLOT_ALIGN;

    let slot_idx = (slot_addr - chunk_addr) / SLOT_SIZE;
    assert!(slot_idx != 0);

    let chunk_hdr = unsafe {
        (chunk_addr as *mut ChunkHeader)
            .as_mut()
            .expect("`chunk_addr` is null")
    };

    let metadata = chunk_hdr
        .slot_metadata
        .get_mut(slot_idx)
        .expect("`slot_idx` out of bounds");

    f(metadata)
}
