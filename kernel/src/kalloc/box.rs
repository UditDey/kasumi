use core::fmt::Debug;
use core::fmt::Display;
use core::marker::PhantomData;
use core::mem::ManuallyDrop;
use core::ops::{Deref, DerefMut};
use core::ptr::NonNull;

/// Box implementation that uses `KAlloc` internally
///
/// Adapted from `std::boxed::Box`
pub struct Box<T> {
    pub(super) ptr: NonNull<T>,
    pub(super) _phantom: PhantomData<T>,
}

unsafe impl<T: Send> Send for Box<T> {}

impl<T> Box<T> {
    pub fn new(val: T) -> Self {
        let ptr = super::alloc();

        unsafe {
            ptr.write(val);
        }

        Self {
            ptr,
            _phantom: PhantomData,
        }
    }

    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
        Self {
            ptr,
            _phantom: PhantomData,
        }
    }

    pub fn into_raw(b: Self) -> NonNull<T> {
        let b = ManuallyDrop::new(b);
        b.ptr
    }

    pub fn into_inner(b: Self) -> T {
        let b = ManuallyDrop::new(b);

        unsafe {
            let val = b.ptr.read();
            super::free(b.ptr);
            val
        }
    }
}

impl<T> Deref for Box<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        unsafe { self.ptr.as_ref() }
    }
}

impl<T> DerefMut for Box<T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        unsafe { self.ptr.as_mut() }
    }
}

impl<T> Drop for Box<T> {
    fn drop(&mut self) {
        unsafe {
            core::ptr::drop_in_place(self.ptr.as_ptr());
        }

        super::free(self.ptr);
    }
}

impl<T: Debug> Debug for Box<T> {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        self.deref().fmt(f)
    }
}

impl<T: Display> Display for Box<T> {
    fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
        self.deref().fmt(f)
    }
}
