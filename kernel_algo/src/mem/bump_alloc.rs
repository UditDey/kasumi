use core::marker::PhantomData;

/// A bump allocator to help set up kernel structures
///
/// Setting up kernel structures such as the page allocator and scheduler can be a bit tricky because you need to do an
/// in-place init, in memory that is initially unmapped. This bump allocator helps set those structures up
///
/// This operates on a buffer where structures will be set up. The init process will then take place in 2 steps:
/// - Mock alloc: Bumps the pointer but does not actually create the structures (since the memory is still unmapped).
///   This step lets us determine the space that will be taken by the kernel structures so we can map that space in
///
/// - Actual alloc: Bumps the pointer and actually create the structures. This works because the required memory would be
///   mapped in after step 1
pub struct BumpAlloc<'a> {
    ptr: *mut u8,
    last_addr: *mut u8,

    // Pretend that we own the buffer, this way we can be sure that the allocated slices also share the same lifetime
    // as the buffer. Actually owning the buffer, on the other hand, causes miri to complain about stacked borrows,
    // using a `PhantomData` solves both goals
    //
    // Is this necessary? Maybe not, but doesn't hurt
    buf: PhantomData<&'a mut [u8]>,
}

impl<'a> BumpAlloc<'a> {
    /// Create a bump allocator that operates in a given buffer
    ///
    /// # Panics
    /// Panics if the buffer has zero size
    pub fn new(buf: &'a mut [u8]) -> Self {
        let last_addr = core::ptr::from_mut(buf.last_mut().expect("Zero sized buffer given"));
        let ptr = buf.as_mut_ptr();

        Self {
            ptr,
            last_addr,
            buf: PhantomData,
        }
    }

    pub fn alloc_slice<T>(&mut self, len: usize) -> &'a mut [T] {
        align_ptr::<T>(&mut self.ptr);
        self.assert_ptr_bounds();
        self.assert_slice_bounds::<T>(len);

        // Safety: The pointer is aligned and within bounds of the buffer, and the slice as a whole is within bounds as well
        let slice = unsafe { core::slice::from_raw_parts_mut(self.ptr.cast::<T>(), len) };

        self.ptr = self.ptr.wrapping_add(len * core::mem::size_of::<T>());
        slice
    }

    pub fn alloc_slice_mock<T>(&mut self, len: usize) {
        align_ptr::<T>(&mut self.ptr);
        self.assert_ptr_bounds();
        self.ptr = self.ptr.wrapping_add(len * core::mem::size_of::<T>());
    }

    fn assert_ptr_bounds(&self) {
        assert!(self.ptr <= self.last_addr);
    }

    fn assert_slice_bounds<T>(&self, len: usize) {
        assert!(self.ptr.cast::<T>().wrapping_add(len).cast::<u8>() <= self.last_addr);
    }
}

fn align_ptr<T>(ptr: &mut *mut u8) {
    let align = core::mem::align_of::<T>();
    let offset = ptr.align_offset(align);
    *ptr = ptr.wrapping_add(offset);
    assert!(ptr.cast::<T>().is_aligned());
}
