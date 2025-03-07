//! Heap chunk allocator
//!
//! This is the basis of the heap allocator. Its 2 basic units are:
//! - Heap Pages: 2MiB large pages that are mapped into the kernel address space
//! - Heap Chunks: 4KiB (ie small page sized) sections allocated from a heap page. Each heap chunk also has a `u64` metadata
//!   associated with it
//!
//! Chunks can then be:
//! - Used as page tables
//! - Used as the basis of [`ObjectPool`]s
//!
//!
//! ### Heap Page layout:
//! - A heap page is simply a 2MiB large page
//! - Each heap page contains 512 4KiB sections (ie small pages)
//!
//! - Section 0 is reserved for storing a [`HeapPageHeader`], which stores:
//!     - The number of chunks allocated from this heap page (when it reaches 0 the whole heap page can be deallocated)
//!     - Metadata associated with each chunk
//!
//! - The remaining 511 sections are allocated as heap chunks
//!
//!
//! ### Chunk allocation scheme:
//! - Every 'free' (ie unallocated) chunk contains a [`FreeChunkHeader`] through which free chunks form a linked list
//! - When a chunk needs to be allocated, the head of this linked list is popped out
//! - If the linked list is empty, then all chunks across all heap pages are occupied, and a new heap page must be allocated
//!   and mapped into the kernel address space
//!
//!
//! ### Chunk metadata:
//! Each chunk's associated `u64` metadata can be used to track how the chunk is being used. For example, [`ObjectPool`] uses
//! the metadata to track how many objects have been allocated within the chunk, and when the count reaches zero, the chunk
//! is freed
//!
//! ### Ownership rules:
//! - Free chunks are owned by the chunk allocator and so allocating and freeing chunks requires locking `CHUNK_ALLOC`
//!
//! - Chunk metadatas however are owned by the corresponding chunk's user (eg `ObjectPool`s), so accessing metadata
//!   doesnt lock `CHUNK_ALLOC` but its the user code's responsibility to ensure that multiple accesses to the same metadata
//!   does not happen
//!
//!
//! TODO: New heap page allocation is yet to be implemented

use core::ptr::NonNull;

use spinning_top::Spinlock;

use crate::page_alloc::{LARGE_PAGE_ALIGN, LARGE_PAGE_SIZE, SMALL_PAGE_ALIGN, SMALL_PAGE_SIZE};

const CHUNKS_PER_HEAP_PAGE: usize = 511;

struct HeapPageHeader {
    num_alloc_chunks: u64,
    chunk_metadatas: [u64; CHUNKS_PER_HEAP_PAGE],
}

struct FreeChunkHeader {
    next_free: Option<NonNull<Self>>,
}

// Ensure that `HeapPageHeader` fits in the first section of the heap page
const _: () = assert!(core::mem::size_of::<HeapPageHeader>() <= SMALL_PAGE_SIZE);

// The linker file declares a "bootstrap" heap page in the kernel BSS
extern "C" {
    static mut BOOTSTRAP_HEAP_PAGE_START: u8;
    static mut BOOTSTRAP_HEAP_PAGE_END: u8;
}

struct ChunkAlloc {
    free_chunk_list: Option<NonNull<FreeChunkHeader>>,
}

unsafe impl Send for ChunkAlloc {}

static CHUNK_ALLOC: Spinlock<Option<ChunkAlloc>> = Spinlock::new(None);

pub(super) fn init() {
    // Init the chunk allocator using the bootstrap heap page
    let heap_page_start = &raw mut BOOTSTRAP_HEAP_PAGE_START;
    let heap_page_end = &raw mut BOOTSTRAP_HEAP_PAGE_END;

    // Sanity check the bootstrap heap page size and alignment
    assert!(heap_page_start.addr() % LARGE_PAGE_ALIGN == 0);
    assert!(heap_page_end.addr() - heap_page_start.addr() == LARGE_PAGE_SIZE);

    // Initialize the `HeapPageHeader` in the bootstrap heap page
    let header_ptr = heap_page_start.cast::<HeapPageHeader>();
    assert!(header_ptr.is_aligned());
    assert!(!header_ptr.is_null());

    unsafe {
        header_ptr.write(HeapPageHeader {
            num_alloc_chunks: 0,
            chunk_metadatas: [0; CHUNKS_PER_HEAP_PAGE],
        });
    }

    // Since all chunks in the bootstrap heap page are free in the start, initialize `FreeChunkHeader`s in all of them
    // Each header points to the next, except for the last one which contains `None` (end of linked list)
    for chunk_idx in 0..CHUNKS_PER_HEAP_PAGE - 1 {
        let next_chunk_idx = chunk_idx + 1;

        // i + 1 because first section is occupied by `HeapPageHeader`
        let chunk_ptr = unsafe {
            heap_page_start
                .add((chunk_idx + 1) * SMALL_PAGE_SIZE)
                .cast::<FreeChunkHeader>()
        };

        let next_chunk_ptr = unsafe {
            let ptr = heap_page_start
                .add((next_chunk_idx + 1) * SMALL_PAGE_SIZE)
                .cast::<FreeChunkHeader>();

            NonNull::new(ptr).expect("`next_chunk_ptr` should not be null")
        };

        assert!(chunk_ptr.is_aligned());
        assert!(next_chunk_ptr.is_aligned());

        unsafe {
            chunk_ptr.write(FreeChunkHeader {
                next_free: Some(next_chunk_ptr),
            });
        }
    }

    unsafe {
        heap_page_start
            .add(CHUNKS_PER_HEAP_PAGE * SMALL_PAGE_SIZE)
            .cast::<FreeChunkHeader>()
            .write(FreeChunkHeader { next_free: None }); // Last chunk marked as end of list
    };

    // The first chunk is the head of the list
    let head = unsafe { heap_page_start.add(SMALL_PAGE_SIZE).cast::<FreeChunkHeader>() };
    let head = NonNull::new(head).expect("`head` should not be null");

    let alloc = ChunkAlloc { free_chunk_list: Some(head) };
    *CHUNK_ALLOC.lock() = Some(alloc);
}

/// Allocate a new chunk
pub fn alloc() -> NonNull<u8> {
    let mut guard = CHUNK_ALLOC.lock();
    let alloc = guard.as_mut().expect("`init()` should have been called");

    // Pop free chunk off the top of the list
    let Some(chunk) = alloc.free_chunk_list.take() else {
        todo!("No free chunks left, alloc new heap page")
    };

    alloc.free_chunk_list = unsafe { chunk.as_ref().next_free };

    // Clear chunk memory
    let chunk = chunk.cast::<u8>();

    unsafe {
        core::ptr::write_bytes(chunk.as_ptr(), 0, SMALL_PAGE_SIZE);
    }

    // Clear chunk metadata
    unsafe {
        update_metadata(chunk, |meta| *meta = 0);
    }

    chunk
}

/// Free a previously allocated chunk
pub fn free(chunk: NonNull<u8>) {
    assert!(chunk.addr().get() % SMALL_PAGE_ALIGN == 0); // Sanity check that the ptr indeed is a chunk addr

    let mut guard = CHUNK_ALLOC.lock();
    let alloc = guard.as_mut().expect("`init()` should have been called");

    // Push freed chunk onto the top of the list
    let chunk = chunk.cast::<FreeChunkHeader>();
    assert!(chunk.is_aligned());

    unsafe {
        chunk.write(FreeChunkHeader {
            next_free: alloc.free_chunk_list,
        });
    }

    alloc.free_chunk_list = Some(chunk);
}

/// Update the metadata associated with a chunk
///
/// `ptr` can be any address within the chunk. The function will round it down to the corresponding chunk's address.
/// This simplifies [`ObjectPool`]'s implementation for example
///
/// # Safety:
/// User code must ensure that it has unique access to this chunk. This ensures that multiple simultaneous accesses to the same
/// chunk's metadata does not occur. See module docs
pub unsafe fn update_metadata<F, T>(ptr: NonNull<u8>, f: F) -> T
where
    F: Fn(&mut u64) -> T,
{
    // Round down pointer to small page boundary to get corresponding chunk addr
    // Round it down again to large page boundary to get corresponding heap page addr
    let chunk_addr = (ptr.addr().get() / SMALL_PAGE_ALIGN) * SMALL_PAGE_ALIGN;
    let heap_page_addr = (chunk_addr / LARGE_PAGE_ALIGN) * LARGE_PAGE_ALIGN;

    let chunk_idx = (chunk_addr - heap_page_addr) / SMALL_PAGE_SIZE - 1;

    // We manually index into the metadata array to avoid creating a reference to the whole `HeapPageHeader` (we don't have
    // access to the whole header because we haven't locked `CHUNK_ALLOC`, we have access to just this one metadata entry)
    let metadata_array_offset = core::mem::offset_of!(HeapPageHeader, chunk_metadatas);
    let metadata_array_addr = heap_page_addr + metadata_array_offset;

    let metadata_addr = metadata_array_addr + chunk_idx * core::mem::size_of::<u64>();

    let metadata = unsafe { &mut *(metadata_addr as *mut u64) };
    f(metadata)
}
