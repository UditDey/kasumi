use core::cmp::Ordering;
use core::ptr::NonNull;

use arrayvec::ArrayVec;

use crate::heap::{self, Allocatable, SizeClass};

const ORDER: usize = 8;

type NodePtr<V> = NonNull<Node<V>>;
type Children<V> = ArrayVec<NodePtr<V>, { ORDER + 1 }>;

/// A node in the B tree
struct Node<V> {
    keys: ArrayVec<u64, ORDER>,
    values: ArrayVec<V, ORDER>,
    children: Option<NonNull<Children<V>>>,
}

/// An ordered key-value map with `u64` keys, implemented using a B tree
pub struct OrderedMap;
