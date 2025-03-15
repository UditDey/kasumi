mod insert;
mod remove;

use core::fmt::{self, Debug};

use crate::heap::Box;
use arrayvec::ArrayVec;

const ORDER: usize = 8;
const MIN_KEYS: usize = (ORDER + 1).div_ceil(2) - 1;

type Children<V> = ArrayVec<Box<Node<V>>, { ORDER + 1 }>;

/// A node in the B tree
struct Node<V> {
    keys: ArrayVec<u64, ORDER>,
    values: ArrayVec<V, ORDER>,
    children: ArrayVec<Box<Self>, { ORDER + 1 }>,
}

impl<V> Node<V> {
    fn new() -> Self {
        Self {
            keys: ArrayVec::new(),
            values: ArrayVec::new(),
            children: ArrayVec::new(),
        }
    }

    fn is_leaf(&self) -> bool {
        self.children.is_empty()
    }
}

/// An ordered key-value map with `u64` keys, implemented using a B tree
pub struct OrderedMap<V> {
    root: Box<Node<V>>,
}

impl<V> OrderedMap<V> {
    pub fn new() -> Self {
        Self { root: Box::new(Node::new()) }
    }

    pub fn get(&self, key: u64) -> Option<&V> {
        Self::get_recursive(&self.root, key)
    }

    fn get_recursive(node: &Box<Node<V>>, key: u64) -> Option<&V> {
        match node.keys.binary_search(&key) {
            // Key found
            // Safety: Each key has a corresponding value
            Ok(idx) => unsafe { Some(node.values.get_unchecked(idx)) },

            // Key not found
            Err(child_idx) => {
                // Recurse down to a child node if it exists
                let child = node.children.get(child_idx)?;
                Self::get_recursive(child, key)
            }
        }
    }

    pub fn get_mut(&mut self, key: u64) -> Option<&mut V> {
        Self::get_mut_recursive(&mut self.root, key)
    }

    fn get_mut_recursive(node: &mut Box<Node<V>>, key: u64) -> Option<&mut V> {
        match node.keys.binary_search(&key) {
            // Key found
            // Safety: Each key has a corresponding value
            Ok(idx) => unsafe { Some(node.values.get_unchecked_mut(idx)) },

            // Key not found
            Err(idx) => {
                // Recurse down to a child node if it exists
                let child = node.children.get_mut(idx)?;
                Self::get_mut_recursive(child, key)
            }
        }
    }

    /// Returns the key/value pair who's key is closest to the given key (rounding down)
    ///
    /// Returns `None` if the map is empty
    pub fn get_nearest_floor(&self, key: u64) -> Option<(u64, &V)> {
        Self::get_nearest_floor_recursive(&self.root, key, None)
    }

    fn get_nearest_floor_recursive<'a>(node: &'a Box<Node<V>>, key: u64, best: Option<(u64, &'a V)>) -> Option<(u64, &'a V)> {
        let mut best = best;

        match node.keys.binary_search(&key) {
            // Key found
            // Safety: Each key has a corresponding value
            Ok(idx) => unsafe {
                let value = node.values.get_unchecked(idx);
                Some((key, value))
            },

            // Key not found
            Err(idx) => {
                if idx > 0 {
                    // Safety: If key insertion index `idx` is > 0, there is a key present at `idx - 1`
                    // If there is a key present at `idx - 1`, there is a corresponding value present too
                    let candidate = unsafe { (*node.keys.get_unchecked(idx - 1), node.values.get_unchecked(idx - 1)) };

                    match best {
                        None => best = Some(candidate),
                        Some((best_key, _)) if candidate.0 > best_key => best = Some(candidate),
                        _ => (),
                    }
                }

                // Recurse down to child node if it exists, otherwise return current best
                match node.children.get(idx) {
                    Some(child) => Self::get_nearest_floor_recursive(child, key, best),
                    None => best,
                }
            }
        }
    }
}

impl<V: Debug> OrderedMap<V> {
    /// Helps with the Debug impl
    fn fmt_node(map_debug: &mut fmt::DebugMap<'_, '_>, node: &Box<Node<V>>) -> fmt::Result {
        for (key, value) in node.keys.iter().zip(&node.values) {
            map_debug.entry(key, value);
        }

        for child in &node.children {
            Self::fmt_node(map_debug, child)?;
        }

        Ok(())
    }
}

impl<V: Debug> Debug for OrderedMap<V> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut map_debug = f.debug_map();
        Self::fmt_node(&mut map_debug, &self.root)?;
        map_debug.finish()
    }
}
