use core::ptr::NonNull;

use spinning_top::Spinlock;

use crate::{
    debug_print::{HEADING, SUBHEADING},
    debug_println,
    page_alloc::{LARGE_PAGE_SIZE, SMALL_PAGE_SIZE},
};

const CHUNK_ALIGN: usize = LARGE_PAGE_SIZE; // = 0x200_000
const CHUNK_SIZE: usize = LARGE_PAGE_SIZE; // = 0x200_000

pub const SLOT_ALIGN: usize = SMALL_PAGE_SIZE; // = 0x1000
pub const SLOT_SIZE: usize = SMALL_PAGE_SIZE; // = 0x1000

const SLOTS_PER_CHUNK: usize = 512 - 2;

/// Header placed at the start of each heap chunk
///
/// This occupied the first 2 slots in the chunk
///
/// # Ownership rules:
/// - `num_alloc_slots` and `unmapped_area_node` are owned by `HEAP_ALLOC`, and mutating them
///   requires acquiring a lock on `HEAP_ALLOC` first
///
/// - Each member of `slot_metadatas` is owned by its respective slot's owner, so its up to the
///   slot owner to make sure it has exclusive access before mutating it
#[repr(align(0x200_000))]
struct ChunkHeader {
    num_alloc_slots: usize,
    unmapped_area_node: UnmappedAreaNode,
    slot_metadatas: [(u64, u64); 510],
}

impl ChunkHeader {
    const _SIZE_CHECK: () = assert!(core::mem::size_of::<Self>() <= 2 * SLOT_SIZE);
    const _ALIGN_CHECK: () = assert!(core::mem::align_of::<Self>() == CHUNK_ALIGN);

    /// Get the pointer to a slot within this chunk
    fn slot_ptr(&self, slot_idx: usize) -> NonNull<u8> {
        // First 2 slots are occupied by the header, so `slot_idx` needs to be
        // shifted up by 2 to get the absolute index
        assert!(slot_idx < SLOTS_PER_CHUNK);
        let abs_slot_idx = slot_idx + 2;

        // Calculate the slot address from this header's address
        let slot_ptr = core::ptr::from_ref(self)
            .cast_mut()
            .cast::<u8>()
            .wrapping_add(abs_slot_idx * SLOT_SIZE);

        NonNull::new(slot_ptr).expect("`slot_ptr` is null")
    }
}

struct UnmappedAreaNode {
    num_unmapped_chunks: usize,
    next: Option<NonNull<Self>>,
}

#[repr(align(0x1000))]
struct FreeSlotHeader {
    next_free: Option<NonNull<Self>>,
}

impl FreeSlotHeader {
    const _ALIGN_CHECK: () = assert!(core::mem::align_of::<Self>() == SLOT_ALIGN);
}

// Bootstrap heap chunk space reserved in the BSS section (see linker script)
extern "C" {
    static mut BOOTSTRAP_HEAP_CHUNK_START: u8;
    static mut BOOTSTRAP_HEAP_CHUNK_END: u8;
}

struct HeapAlloc {
    free_slot_list: Option<NonNull<FreeSlotHeader>>,
    unmapped_area_list: Option<NonNull<UnmappedAreaNode>>,
}

unsafe impl Send for HeapAlloc {}

static HEAP_ALLOC: Spinlock<Option<HeapAlloc>> = Spinlock::new(None);

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

    // Safety: `boot_chunk_hdr` is aligned and valid for writes (part of BSS)
    unsafe {
        boot_chunk_hdr.write(ChunkHeader {
            num_alloc_slots: 0,
            unmapped_area_node: UnmappedAreaNode {
                num_unmapped_chunks: free_chunks_after_boot_chunk,
                next: None,
            },
            slot_metadatas: [(0, 0); 510],
        });
    }

    // Safety: We just initialized `boot_chunk_hdr`
    let boot_chunk_hdr = unsafe {
        boot_chunk_hdr
            .as_mut()
            .expect("`boot_chunk_hdr` ptr is null")
    };

    // Initialize free slot headers in boot chunk
    // Each slot header points to the next slot, except for the last one which points to `None`
    for i in 0..SLOTS_PER_CHUNK - 1 {
        let slot = boot_chunk_hdr.slot_ptr(i).cast::<FreeSlotHeader>();
        let next_slot = boot_chunk_hdr.slot_ptr(i + 1).cast::<FreeSlotHeader>();

        // Safety: `slot` is aligned and entire boot chunk is valid for writes (part of BSS)
        unsafe {
            slot.write(FreeSlotHeader { next_free: Some(next_slot) });
        }
    }

    // Safety: `slot` is aligned and entire boot chunk is valid for writes (part of BSS)
    unsafe {
        boot_chunk_hdr
            .slot_ptr(SLOTS_PER_CHUNK - 1)
            .cast::<FreeSlotHeader>()
            .write(FreeSlotHeader { next_free: None });
    }

    // Get addr of the `unmapped_area_node` embedded in the chunk header
    let unmapped_area_node = core::ptr::addr_of_mut!(boot_chunk_hdr.unmapped_area_node);

    // Initialize heap alloc
    let first_slot = boot_chunk_hdr.slot_ptr(0).cast::<FreeSlotHeader>();
    let unmapped_area_node = NonNull::new(unmapped_area_node).expect("`unmapped_area_node` pointer is null");

    *HEAP_ALLOC.lock() = Some(HeapAlloc {
        free_slot_list: Some(first_slot),
        unmapped_area_list: Some(unmapped_area_node),
    });
}

pub fn alloc_slot() -> NonNull<u8> {
    let mut guard = HEAP_ALLOC.lock();
    let heap_alloc = guard.as_mut().expect("heap::init() not called yet");

    // Get a free slot from the head of the free slot list
    let Some(free_slot_ptr) = heap_alloc.free_slot_list else {
        todo!("No free slots left, allocate new chunk")
    };

    // Make the free slot list head point to the next free slot
    // Safety: `free_slot_ptr` will have been correctly initialized in `init()` and is not
    // aliased since we have a lock on `HEAP_ALLOC`
    heap_alloc.free_slot_list = unsafe { free_slot_ptr.as_ref().next_free };

    let free_slot_ptr = free_slot_ptr.cast::<u8>();

    // Increment num allocs in this chunk
    unsafe {
        update_chunk_num_alloc_slots(free_slot_ptr, |num_alloc_slots| *num_alloc_slots += 1);
    }

    // Zero slot memory before handing it over
    // Safety: The range of the entire slot is valid for writes (previously mapped in) and
    // since the slot is unallocated we have exclusive access to it
    unsafe {
        free_slot_ptr.write_bytes(0, SLOT_SIZE);
    }

    free_slot_ptr
}

pub fn free_slot(slot_ptr: NonNull<u8>) {
    let mut guard = HEAP_ALLOC.lock();
    let heap_alloc = guard.as_mut().expect("heap::init() not called yet");

    assert!(slot_ptr.addr().get() % SLOT_ALIGN == 0);

    // Decrement num allocs in this chunk
    unsafe {
        update_chunk_num_alloc_slots(slot_ptr, |num_allocs| {
            *num_allocs -= 1;

            if *num_allocs == 0 {
                todo!("num allocs in this chunk reached 0, free this");
            }
        });
    }

    let slot_ptr = slot_ptr.cast::<FreeSlotHeader>();

    // Make this slot the new head of the free slot list, making it point to the old head
    // Safety: We asserted `slot_ptr` alignment, the memory is valid for writes (`alloc_slot()`
    // will not give unmapped memory) and we assume that the caller has given up this slot so we
    // have exclusive access to it
    unsafe {
        slot_ptr.write(FreeSlotHeader {
            next_free: heap_alloc.free_slot_list,
        });
    }

    heap_alloc.free_slot_list = Some(slot_ptr);
}

pub unsafe fn update_slot_metadata(ptr: NonNull<u8>, f: impl Fn(&mut (u64, u64))) {
    let (chunk_hdr, slot_idx) = slot_info(ptr);
    let array_offset = core::mem::offset_of!(ChunkHeader, slot_metadatas);

    let array_ptr = chunk_hdr.byte_add(array_offset).cast::<(u64, u64)>();
    let mut metadata_ptr = array_ptr.add(slot_idx);

    let metadata = unsafe { metadata_ptr.as_mut() };
    f(metadata)
}

unsafe fn update_chunk_num_alloc_slots(ptr: NonNull<u8>, f: impl Fn(&mut usize)) {
    let (chunk_hdr, _) = slot_info(ptr);
    let offset = core::mem::offset_of!(ChunkHeader, num_alloc_slots);

    let mut num_allocs_ptr = chunk_hdr.byte_add(offset).cast::<usize>();
    assert!(num_allocs_ptr.is_aligned());

    let num_allocs = unsafe { num_allocs_ptr.as_mut() };
    f(num_allocs);
}

fn slot_info(ptr: NonNull<u8>) -> (NonNull<ChunkHeader>, usize) {
    // Round down the pointer to the nearest chunk aligned address,
    // this pointer's chunk header will be present there
    let chunk_hdr_addr = (ptr.addr().get() / CHUNK_ALIGN) * CHUNK_ALIGN;

    // Round down the pointer to the nearest chunk aligned address,
    // this pointer's slot starts here
    let slot_addr = (ptr.addr().get() / SLOT_ALIGN) * SLOT_ALIGN;

    // Use the difference between chunk header address and slot address to calc absolute slot idx
    let abs_slot_idx = (slot_addr - chunk_hdr_addr) / SLOT_SIZE;

    let slot_idx = abs_slot_idx - 2;
    assert!(slot_idx < SLOTS_PER_CHUNK);

    let chunk_hdr_ptr = NonNull::new(chunk_hdr_addr as *mut ChunkHeader).expect("`chunk_hdr_addr` is null");

    (chunk_hdr_ptr, slot_idx)
}
