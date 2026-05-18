mod r#box;
mod pool;

use core::ptr::NonNull;

use crate::state::{CpuLocal, KALLOC};
use arrayvec::ArrayVec;
use pool::ObjectPool;

pub use r#box::Box;

const CACHE_SIZE: usize = 32;

#[derive(Clone, Copy)]
enum SizeClass {
    Bytes256,
}

impl SizeClass {
    fn for_type<T>() -> Self {
        let size = core::mem::size_of::<T>();
        assert!(size != 0);

        match size {
            0..=256 => Self::Bytes256,
            _ => panic!("Object too large for any size class"),
        }
    }
}

#[derive(Debug)]
pub struct KAllocLocalCache {
    cache_256: ArrayVec<NonNull<u8>, CACHE_SIZE>,
}

impl KAllocLocalCache {
    pub const fn new() -> Self {
        Self {
            cache_256: ArrayVec::new_const(),
        }
    }

    fn get(&mut self, class: SizeClass) -> &mut ArrayVec<NonNull<u8>, CACHE_SIZE> {
        match class {
            SizeClass::Bytes256 => &mut self.cache_256,
        }
    }
}

pub struct KAlloc {
    pool_256: ObjectPool<256>,
}

impl KAlloc {
    pub const fn new() -> Self {
        Self {
            pool_256: ObjectPool::new(),
        }
    }

    fn alloc(&mut self, class: SizeClass) -> NonNull<u8> {
        match class {
            SizeClass::Bytes256 => self.pool_256.alloc(),
        }
    }

    fn free(&mut self, class: SizeClass, ptr: NonNull<u8>) {
        match class {
            SizeClass::Bytes256 => self.pool_256.free(ptr),
        }
    }
}

pub(super) fn alloc<T>() -> NonNull<T> {
    let cpu_local = CpuLocal::this();
    let class = SizeClass::for_type::<T>();

    let mut kalloc_cache = cpu_local.kalloc_cache.borrow_mut();
    let cache = kalloc_cache.get(class);

    let ptr = match cache.pop() {
        Some(ptr) => ptr,
        None => {
            let mut kalloc = KALLOC.lock();
            for _ in 0..CACHE_SIZE / 2 {
                cache.push(kalloc.alloc(class));
            }
            kalloc.alloc(class)
        }
    };

    let ptr = ptr.cast::<T>();
    assert!(ptr.is_aligned());

    ptr
}

pub(super) fn free<T>(ptr: NonNull<T>) {
    let cpu_local = CpuLocal::this();
    let class = SizeClass::for_type::<T>();

    let ptr = ptr.cast::<u8>();

    let mut kalloc_cache = cpu_local.kalloc_cache.borrow_mut();
    let cache = kalloc_cache.get(class);

    if cache.try_push(ptr).is_err() {
        let mut kalloc = KALLOC.lock();
        for ptr in cache.drain(0..CACHE_SIZE / 2) {
            kalloc.free(class, ptr);
        }
        kalloc.free(class, ptr);
    }
}
