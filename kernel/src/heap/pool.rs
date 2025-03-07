use core::ptr::NonNull;

use crate::{
    heap::chunk,
    page_alloc::{SMALL_PAGE_ALIGN, SMALL_PAGE_SIZE},
};

union Object<const S: usize> {
    _object: [u8; S],
    next_free: Option<NonNull<Self>>,
}

/// An object pool for allocating objects of size `S`
///
/// The pool is backed by one or more heap chunks. Each 4 KiB chunk is divided into a contigous list of [`Object`]s.
/// Free (ie unallocated) objects form a linked list, each pointing to the next free object
///
/// Since each chunk must be divided into an array of [`Object`]s, `S` is constrained and static assertions are provided
/// to check that the division is valid
///
/// Allocation returns a pointer to a region of memory of size `S` and aligned to `OBJ_ALIGNMENT`. Since we typically want to
/// allocate types and not just blocks of memory, all types should be padded and aligned to fit the object size
pub struct ObjectPool<const S: usize> {
    free_obj_list: Option<NonNull<Object<S>>>,
}

unsafe impl<const S: usize> Send for ObjectPool<S> {}

impl<const S: usize> ObjectPool<S> {
    // Static check to ensure chunk can be divided correctly
    const STATIC_CHECK: ((), ()) = (
        assert!(SMALL_PAGE_SIZE % core::mem::size_of::<Object<S>>() == 0),
        assert!(SMALL_PAGE_ALIGN % core::mem::align_of::<Object<S>>() == 0),
    );

    pub const OBJ_ALIGNMENT: usize = core::mem::align_of::<Object<S>>();

    pub fn new() -> Self {
        // Static assertions in impls aren't evaluated unless referenced
        #[expect(path_statements)]
        Self::STATIC_CHECK;

        Self { free_obj_list: None }
    }

    /// Allocate an object of size `S` and alignment `ALIGNMENT`
    ///
    /// Note that the allocated memory is completely uninitialzed
    pub fn alloc(&mut self) -> NonNull<u8> {
        // Pop free object off the top of the list
        let obj = self.free_obj_list.unwrap_or_else(|| self.new_chunk());

        self.free_obj_list = unsafe { obj.as_ref().next_free };
        obj.cast::<u8>()
    }

    /// Free a previously allocated object
    pub fn free(&mut self, obj: NonNull<u8>) {
        let obj = obj.cast::<Object<S>>();
        assert!(obj.is_aligned());

        unsafe {
            obj.write(Object {
                next_free: self.free_obj_list,
            });
        }

        self.free_obj_list = Some(obj);
    }

    /// Allocates a new chunk, sets up free object linked list within it, links new list to current list, and returns an object
    /// ready to be used as an allocation
    fn new_chunk(&mut self) -> NonNull<Object<S>> {
        let objs_per_chunk = SMALL_PAGE_SIZE / core::mem::size_of::<Object<S>>();

        let objs = chunk::alloc().cast::<Object<S>>(); // Chunk treated as array of `Object<S>`
        assert!(objs.is_aligned());

        // Setup the objects as a linked list, with the second last object pointing to the current head
        // The last object is used for the current allocation
        for i in 0..objs_per_chunk - 2 {
            let obj_ptr = unsafe { objs.add(i) };
            let next_obj_ptr = unsafe { objs.add(i + 1) };

            unsafe {
                obj_ptr.write(Object {
                    next_free: Some(next_obj_ptr),
                });
            };
        }

        unsafe {
            objs.add(objs_per_chunk - 2).write(Object {
                next_free: self.free_obj_list,
            });
        }

        // First object becomes new head
        self.free_obj_list = Some(objs);

        unsafe { objs.add(objs_per_chunk - 1) } // Last obj used for current alloc
    }
}
