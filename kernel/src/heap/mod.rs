mod r#box;
pub mod chunk;
mod pool;

use core::marker::PhantomData;

use spinning_top::Spinlock;

use pool::ObjectPool;
pub use r#box::Box;

static POOL_256: Spinlock<Option<ObjectPool<256>>> = Spinlock::new(None);

pub fn init() {
    chunk::init();

    *POOL_256.lock() = Some(ObjectPool::new());
}

fn alloc<T>(val: T) -> Box<T> {
    let size = core::mem::size_of::<T>();
    let name = core::any::type_name::<T>();

    let ptr = match size {
        0..=256 => POOL_256
            .lock()
            .as_mut()
            .expect("`init()` should have been called")
            .alloc()
            .cast::<T>(),

        _ => panic!("Object (type: {name}, size: {size}) too large for any object pool"),
    };

    assert!(ptr.is_aligned());
    unsafe {
        ptr.write(val);
    }

    Box { ptr, _phantom: PhantomData }
}

fn free<T>(val: &mut Box<T>) {
    let size = core::mem::size_of::<T>();

    match size {
        0..=256 => POOL_256
            .lock()
            .as_mut()
            .expect("`init()` should have been called")
            .free(val.ptr.cast()),

        _ => unreachable!(),
    }
}
