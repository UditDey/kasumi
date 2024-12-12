use core::cmp::Ordering;
use core::ptr::NonNull;

use crate::arena::Arena;

struct Rng(u64, u64);

impl Rng {
    fn new() -> Self {
        let seed = 69420;
        Rng(seed ^ 0xf4db_df21_83dc_efb7, seed ^ 0x1ad5_be0d_6dd2_8e9b)
    }

    fn rand_u64(&mut self) -> u64 {
        let mut x = self.0;
        let y = self.1;
        self.0 = y;
        x ^= x << 23;
        self.1 = x ^ y ^ (x >> 17) ^ (y >> 26);
        self.1.wrapping_add(y)
    }

    fn rand_bool(&mut self) -> bool {
        (self.rand_u64() & 1) != 0
    }
}

#[derive(Clone, Copy)]
union DownPtr<K: Ord + Copy, V: Copy> {
    key: NonNull<KeyNode<K, V>>,
    value: NonNull<V>,
}

#[derive(Clone, Copy)]
struct KeyNode<K: Ord + Copy, V: Copy> {
    key: K,
    next: Option<NonNull<Self>>,
    down: DownPtr<K, V>,
}

pub struct KVMap<K: Ord + Copy, V: Copy> {
    key_arena: Arena<KeyNode<K, V>>,
    value_arena: Arena<V>,
    start_node: Option<NonNull<KeyNode<K, V>>>,
    rng: Rng,
}

impl<K: Ord + Copy, V: Copy> KVMap<K, V> {
    pub fn new() -> Self {
        Self {
            key_arena: Arena::new(),
            value_arena: Arena::new(),
            start_node: None,
            rng: Rng::new(),
        }
    }

    pub fn insert(&mut self, key: K, value: V) {
        todo!()
    }
}
