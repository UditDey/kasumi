use core::cmp::Ordering;
use core::ptr::NonNull;

use arrayvec::ArrayVec;

use crate::arena::Arena;

use crate::{debug_print, debug_println};

const ORDER: usize = 4; //8;

type NodePtr<V> = NonNull<Node<V>>;
type Children<V> = ArrayVec<NodePtr<V>, { ORDER + 1 }>;

struct Node<V> {
    keys: ArrayVec<u64, ORDER>,
    values: ArrayVec<V, ORDER>,
    children: Option<NonNull<Children<V>>>,
}

struct SplitInfo<V> {
    promoted_key: u64,
    promoted_value: V,
    new_node: NodePtr<V>,
}

pub struct Map<V> {
    node_arena: Arena<Node<V>>,
    children_arena: Arena<Children<V>>,
    root: NodePtr<V>,
}

impl<V> Map<V> {
    pub fn new() -> Self {
        let mut node_arena = Arena::new();

        let root = node_arena.alloc(Node {
            keys: ArrayVec::new(),
            values: ArrayVec::new(),
            children: None,
        });

        Self {
            node_arena,
            children_arena: Arena::new(),
            root,
        }
    }

    pub fn get(&self, key: u64) -> Option<&V> {
        let mut node = &self.root;

        loop {
            let n = unsafe { node.as_ref() };

            match n.children {
                // Internal node
                Some(children) => {
                    let children = unsafe { children.as_ref() };

                    let idx = match n.keys.binary_search(&key) {
                        Ok(idx) => return n.values.get(idx),
                        Err(idx) => idx,
                    };

                    node = children.get(idx).expect("Child node not found");
                }

                // Leaf node
                None => {
                    return match n.keys.binary_search(&key) {
                        Ok(idx) => n.values.get(idx),
                        Err(_) => None,
                    }
                }
            }
        }
    }

    pub fn insert(&mut self, key: u64, value: V) {
        let split_info = self.insert_recursive(self.root, key, value);

        // Check if root was split
        if let Some(split_info) = split_info {
            let mut children = ArrayVec::new();
            children.push(self.root);
            children.push(split_info.new_node);

            let children = Some(self.children_arena.alloc(children));

            let mut keys = ArrayVec::new();
            keys.push(split_info.promoted_key);

            let mut values = ArrayVec::new();
            values.push(split_info.promoted_value);

            let new_root = Node { keys, values, children };
            let new_root = self.node_arena.alloc(new_root);

            self.root = new_root;
        }
    }

    fn insert_recursive(&mut self, mut node: NodePtr<V>, key: u64, value: V) -> Option<SplitInfo<V>> {
        let node = unsafe { node.as_mut() };

        match node.keys.binary_search(&key) {
            // Key already present in map, update it's value
            Ok(idx) => {
                debug_println!("leaf insert: key already in map");
                let val = node.values.get_mut(idx).expect("Value not found");
                *val = value;
                None
            }

            // Key needs to be inserted
            Err(idx) => {
                match node.children {
                    // Internal node, recurse down to child nodes
                    Some(mut children) => {
                        let children = unsafe { children.as_mut() };

                        let child = children.get(idx).expect("Child node not found");
                        let split_info = self.insert_recursive(*child, key, value);

                        // Check if child was split
                        if let Some(split_info) = split_info {
                            if node.keys.len() < ORDER {
                                // Node has space, insert promoted key and new child node
                                debug_println!("internal insert: node has space");
                                node.keys.insert(idx, split_info.promoted_key);
                                node.values.insert(idx, split_info.promoted_value);
                                children.insert(idx + 1, split_info.new_node);
                            } else {
                                // Current node is full, split this too
                                debug_println!("internal insert: splitting node");
                                return Some(self.split_node(
                                    node,
                                    idx,
                                    split_info.promoted_key,
                                    split_info.promoted_value,
                                    Some(split_info.new_node),
                                ));
                            }
                        }

                        None
                    }

                    // Leaf node, key should be inserted here
                    None => {
                        if node.keys.len() < ORDER {
                            // Node has space, insert key
                            debug_println!("leaf insert: node has space");
                            node.keys.insert(idx, key);
                            node.values.insert(idx, value);
                            None
                        } else {
                            // Node is full, split it
                            debug_println!("leaf insert: splitting node");
                            Some(self.split_node(node, idx, key, value, None))
                        }
                    }
                }
            }
        }
    }

    fn split_node(&mut self, node: &mut Node<V>, idx: usize, key: u64, value: V, internal_insert_child: Option<NodePtr<V>>) -> SplitInfo<V> {
        let mid = ORDER / 2;

        let new_node_children = if let Some(mut children) = node.children {
            let children = unsafe { children.as_mut() };
            let mut new_node_children: Children<V> = children.drain((mid + 1)..).collect();

            if let Some(child) = internal_insert_child {
                debug_println!("node split: internal insert child going to right node");
                new_node_children.insert(idx - mid, child);
            }

            Some(self.children_arena.alloc(new_node_children))
        } else {
            None
        };

        let mut new_node = Node {
            keys: node.keys.drain(mid..).collect(),
            values: node.values.drain(mid..).collect(),
            children: new_node_children,
        };

        match idx.cmp(&mid) {
            Ordering::Equal => {
                debug_println!(
                    "node split case 1: promoting key: {}, left keys: {:?}, right keys: {:?}",
                    key,
                    node.keys,
                    new_node.keys
                );
                let new_node = self.node_arena.alloc(new_node);

                SplitInfo {
                    promoted_key: key,
                    promoted_value: value,
                    new_node,
                }
            }
            Ordering::Less => {
                node.keys.insert(idx, key);
                node.values.insert(idx, value);

                let promoted_key = node.keys.pop().unwrap();
                let promoted_value = node.values.pop().unwrap();
                debug_println!(
                    "node split case 2: promoting key: {}, left keys: {:?}, right keys: {:?}",
                    promoted_key,
                    node.keys,
                    new_node.keys
                );

                let new_node = self.node_arena.alloc(new_node);

                SplitInfo {
                    promoted_key,
                    promoted_value,
                    new_node,
                }
            }

            Ordering::Greater => {
                new_node.keys.insert(idx - mid, key);
                new_node.values.insert(idx - mid, value);

                let promoted_key = new_node.keys.remove(0);
                let promoted_value = new_node.values.remove(0);
                debug_println!(
                    "node split case 3: promoting key: {}, left keys: {:?}, right keys: {:?}",
                    promoted_key,
                    node.keys,
                    new_node.keys
                );

                let new_node = self.node_arena.alloc(new_node);

                SplitInfo {
                    promoted_key,
                    promoted_value,
                    new_node,
                }
            }
        }
    }
}
