use core::alloc::Layout;
use core::mem::ManuallyDrop;
use core::ptr::NonNull;

use crate::heap::{self, SLOT_ALIGN, SLOT_SIZE};

union Node<T> {
    data: ManuallyDrop<T>,
    next_free: Option<NonNull<Self>>,
}

pub struct Arena<T> {
    freelist: Option<NonNull<Node<T>>>,
    slot_list: NonNull<u8>,
}

impl<T> Arena<T> {
    pub const _DROP_CHECK: () = assert!(!core::mem::needs_drop::<T>());

    pub const NODES_PER_SLOT: usize = SLOT_SIZE / core::mem::size_of::<Node<T>>();

    const _ALIGN_CHECK: () = {
        let layout = Layout::array::<Node<T>>(Self::NODES_PER_SLOT);

        // Workaround for `Result::unwrap()` not being const yet
        if let Ok(layout) = layout {
            assert!(layout.align() % SLOT_ALIGN == 0);
        } else {
            panic!();
        }
    };

    pub fn new() -> Self {
        let slot = heap::alloc_slot();
        let freelist_head = Self::init_slot(slot);

        Self {
            freelist: Some(freelist_head),
            slot_list: slot,
        }
    }

    pub fn alloc(&mut self, value: T) -> NonNull<T> {
        // If freelist is `None` it means we have no free nodes left
        let Some(mut free_node_ptr) = self.freelist else {
            todo!("Allocate additional slot")
        };

        // Decrement alloc count
        unsafe {
            heap::update_slot_metadata(free_node_ptr.cast(), |(alloc_count, _next_slot)| *alloc_count += 1);
        }

        // Safety: `free_node` always points to a node that has been previously initialised by `init_slot()`
        let free_node = unsafe { free_node_ptr.as_mut() };

        // Safety: If a node is present in the freelist, it means it is of the `next_free` variant
        self.freelist = unsafe { free_node.next_free };
        free_node.data = ManuallyDrop::new(value);

        free_node_ptr.cast::<T>()
    }

    pub fn free(&mut self, ptr: NonNull<T>) {
        let mut node_ptr = ptr.cast::<Node<T>>();
        let node = unsafe { node_ptr.as_mut() };

        // Decrement alloc count
        unsafe {
            heap::update_slot_metadata(node_ptr.cast(), |(alloc_count, _next_slot)| {
                *alloc_count -= 1;

                if *alloc_count == 0 {
                    todo!("Free this slot");
                }
            });
        };

        *node = Node { next_free: self.freelist };
        self.freelist = Some(node_ptr);
    }

    #[allow(clippy::indexing_slicing, reason = "Too verbose without it, slice len is const as well")]
    fn init_slot(slot: NonNull<u8>) -> NonNull<Node<T>> {
        unsafe {
            heap::update_slot_metadata(slot, |(alloc_count, next_slot_addr)| {
                *alloc_count = 0;
                *next_slot_addr = 0;
            });
        }

        let nodes = unsafe { core::slice::from_raw_parts_mut(slot.as_ptr().cast::<Node<T>>(), Self::NODES_PER_SLOT) };

        // Setup remaining nodes as freelist, each pointing to the next
        for i in 0..nodes.len() - 1 {
            nodes[i] = Node {
                next_free: Some(NonNull::new(core::ptr::from_mut(&mut nodes[i + 1])).expect("node ptr is null")),
            };
        }

        // Last node points to nothing (end of freelist)
        nodes[nodes.len() - 1] = Node { next_free: None };

        // Head of the freelist formed by this slot (node 0)
        let freelist_head = core::ptr::addr_of_mut!(nodes[0]);

        NonNull::new(freelist_head).expect("freelist_head ptr is null")
    }
}
