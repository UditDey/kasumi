mod r#box;
pub mod chunk;
mod pool;

use core::marker::PhantomData;

use spinning_top::Spinlock;

use pool::ObjectPool;
pub use r#box::Box;

static POOL_256: Spinlock<Option<ObjectPool<256>>> = Spinlock::new(None);

pub enum SizeClass {
    Bytes256,
}

impl SizeClass {
    const fn size(&self) -> usize {
        match *self {
            Self::Bytes256 => 256,
        }
    }

    const fn alignment(&self) -> usize {
        match *self {
            Self::Bytes256 => ObjectPool::<256>::OBJ_ALIGNMENT,
        }
    }
}

pub trait Allocatable: Sized {
    const SIZE_CLASS: SizeClass;

    // Compile-time check to ensure size class is correctly chosen and implementing type can be correctly aligned
    const COMPTIME_CHECK: ((), ()) = (
        assert!(core::mem::size_of::<Self>() == Self::SIZE_CLASS.size()),
        assert!(Self::SIZE_CLASS.alignment() % core::mem::align_of::<Self>() == 0),
    );
}

pub fn init() {
    chunk::init();

    //*POOL_256.lock() = Some(ObjectPool::new());
    let mut pool = ObjectPool::<256>::new();

    for i in 0.. {
        crate::debug_println!("{i}: {:?}", pool.alloc());
    }
}

pub fn alloc<T: Allocatable>(val: T) -> Box<T> {
    // Const assertions in traits aren't evaluated unless referenced
    #[expect(path_statements)]
    T::COMPTIME_CHECK;

    let ptr = match T::SIZE_CLASS {
        SizeClass::Bytes256 => POOL_256
            .lock()
            .as_mut()
            .expect("init() should have been called first")
            .alloc()
            .cast(),
    };

    unsafe {
        ptr.write(val);
    }

    Box { ptr, _phantom: PhantomData }
}

fn free<T: Allocatable>(val: &mut Box<T>) {
    crate::debug_println!("freeing");
    match T::SIZE_CLASS {
        SizeClass::Bytes256 => POOL_256
            .lock()
            .as_mut()
            .expect("`init()` should have been called")
            .free(val.ptr.cast()),
    }
}
