use core::alloc::Layout;
use core::mem::ManuallyDrop;
use core::ptr::NonNull;

use crate::debug_println;

use super::heap::{self, SLOT_ALIGN, SLOT_SIZE};

union Node<T> {
    data: ManuallyDrop<T>,
    next_free: Option<NonNull<Self>>,
}

#[derive(Debug)]
pub struct Arena<T> {
    freelist: Option<NonNull<Node<T>>>,
}

impl<T> Arena<T> {
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
        let freelist_head = Self::init_slot(heap::alloc_slot());

        Self {
            freelist: Some(freelist_head),
        }
    }

    pub fn alloc(&mut self, val: T) -> Option<NonNull<T>> {
        // If freelist is `None` it means we have no free nodes left
        // TODO: Allocate additional slot in this case
        let mut free_node_ptr = self.freelist?;

        // Decrement alloc count
        heap::update_slot_metadata(free_node_ptr.addr().get(), |alloc_count| *alloc_count += 1);

        // Safety: `free_node` always points to a node that has been previously initialised by `init_slot()`
        let free_node = unsafe { free_node_ptr.as_mut() };

        // Safety: If a node is present in the freelist, it means it is of the `next_free` variant
        self.freelist = unsafe { free_node.next_free };
        free_node.data = ManuallyDrop::new(val);

        Some(free_node_ptr.cast::<T>())
    }

    pub fn free(&mut self, ptr: *mut T) {
        let node_ptr = ptr.cast::<Node<T>>();
        let node = unsafe { node_ptr.as_mut().expect("`node_ptr` is null") };

        // Decrement alloc count
        heap::update_slot_metadata(node_ptr.addr(), |alloc_count| {
            *alloc_count -= 1;

            if *alloc_count == 0 {
                // TODO: Free this slot
                //debug_println!("slot fully free");
            }
        });

        *node = Node { next_free: self.freelist };
        let new_freelist_head = NonNull::new(core::ptr::from_mut(node)).expect("`node` ptr is null");

        self.freelist = Some(new_freelist_head);
    }

    #[allow(clippy::indexing_slicing, reason = "Too verbose without it, slice len is const as well")]
    fn init_slot(slot: NonNull<u8>) -> NonNull<Node<T>> {
        let nodes = unsafe { core::slice::from_raw_parts_mut(slot.as_ptr().cast::<Node<T>>(), Self::NODES_PER_SLOT) };

        // Setup remaining nodes as freelist, each pointing to the next
        for i in 0..nodes.len() - 1 {
            nodes[i] = Node {
                next_free: Some(NonNull::new(core::ptr::from_mut(&mut nodes[i + 1])).expect("node ptr is null")),
            };
        }

        // Last node points to nothing (end of freelist)
        nodes[nodes.len() - 1] = Node { next_free: None };

        NonNull::new(core::ptr::from_mut(&mut nodes[0])).expect("node ptr is null")
    }
}
