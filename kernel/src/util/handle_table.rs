use core::marker::PhantomData;

use crate::kalloc::Box;

const DIR_SIZE: usize = 32;
const MAX_ENTRIES: u16 = (DIR_SIZE * DIR_SIZE) as u16;

type Level1<V> = [Option<Box<Level2<V>>>; DIR_SIZE];
type Level2<V> = [Option<Box<V>>; DIR_SIZE];

pub trait Handle {
    fn from_raw(raw: u16) -> Self;
    fn as_raw(&self) -> u16;
}

#[macro_export]
macro_rules! make_handle {
    ($name:ident) => {
        #[derive(Clone, Copy, Debug)]
        pub struct $name(u16);

        impl Handle for $name {
            fn from_raw(raw: u16) -> Self {
                Self(raw)
            }

            fn as_raw(&self) -> u16 {
                self.0
            }
        }
    };
}

pub struct HandleTable<K, V> {
    level_1: Option<Box<Level1<V>>>,
    phantom: PhantomData<K>,
}

impl<K, V> HandleTable<K, V> {
    pub const fn new() -> Self {
        Self {
            level_1: None,
            phantom: PhantomData,
        }
    }
}

impl<K: Handle, V> HandleTable<K, V> {
    fn split_key(key: u16) -> (usize, usize) {
        assert!(key < MAX_ENTRIES, "key out of range");
        ((key >> 5) as usize, (key & 0x1F) as usize)
    }

    fn ensure_leaf(&mut self, i1: usize) -> &mut Level2<V> {
        let l1 = self
            .level_1
            .get_or_insert_with(|| Box::new(core::array::from_fn(|_| None)));
        l1[i1].get_or_insert_with(|| Box::new(core::array::from_fn(|_| None)))
    }

    pub fn get(&self, key: &K) -> Option<&V> {
        let (i1, i2) = Self::split_key(key.as_raw());
        self.level_1.as_ref()?[i1].as_ref()?[i2].as_deref()
    }

    pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
        let (i1, i2) = Self::split_key(key.as_raw());
        self.level_1.as_mut()?[i1].as_mut()?[i2].as_deref_mut()
    }

    /// Allocate the next free key and insert
    pub fn insert(&mut self, f: impl FnOnce(K) -> V) -> Option<(K, &mut V)> {
        let key = (0..MAX_ENTRIES).find(|&key| {
            let (i1, i2) = Self::split_key(key);
            self.level_1
                .as_ref()
                .and_then(|l1| l1[i1].as_ref())
                .is_none_or(|l2| l2[i2].is_none())
        })?;
        let (i1, i2) = Self::split_key(key);
        let l2 = self.ensure_leaf(i1);
        l2[i2] = Some(Box::new(f(K::from_raw(key))));
        let handle = K::from_raw(key);
        Some((handle, l2[i2].as_deref_mut().unwrap()))
    }

    pub fn remove(&mut self, key: &K) -> Option<V> {
        let (i1, i2) = Self::split_key(key.as_raw());
        let l2 = self.level_1.as_mut()?[i1].as_mut()?;
        l2[i2].take().map(Box::into_inner)
    }
}
