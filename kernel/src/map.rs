use core::cmp::Ordering;
use core::ptr::NonNull;

use arrayvec::ArrayVec;

use crate::arena::Arena;

const ORDER: usize = 8;

type NodePtr<V> = NonNull<Node<V>>;
type Children<V> = ArrayVec<NodePtr<V>, { ORDER + 1 }>;

/// A node in the B tree
struct Node<V> {
    keys: ArrayVec<u64, ORDER>,
    values: ArrayVec<V, ORDER>,
    children: Option<NonNull<Children<V>>>,
}

/// Result of a node split operation
///
/// [`Map::split_node()`] implements the B tree node split operation
///
/// It splits a node into 2 by removing elements from the original node
/// and moving them into a newly allocated node. The original node becomes
/// the "left" node (and has the lower keys), and the new node is the "right"
/// node (and has the higher keys). Additionally, the function produces a
/// key/value pair that is to be promoted from the split node into it's parent
struct SplitInfo<V> {
    promoted_key: u64,
    promoted_value: V,
    new_node: NodePtr<V>,
}

/// An ordered key-value map with `u64` keys, implemented using a B tree
pub struct Map<V> {
    node_arena: Arena<Node<V>>,
    children_arena: Arena<Children<V>>,
    root: NodePtr<V>,
}

/// Safety: If V: Send then the whole map can be sent between threads too
unsafe impl<V: Send> Send for Map<V> {}

impl<V> Map<V> {
    pub fn new() -> Self {
        // Create a new tree with an empty root node
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
        // Iterate down the tree till we find the key
        let mut node = &self.root;

        loop {
            let n = unsafe { node.as_ref() };

            match n.keys.binary_search(&key) {
                // Key found
                Ok(idx) => return n.values.get(idx),

                // Key not found
                Err(idx) => {
                    match n.children {
                        // This is an internal node, go down to a child node and keep searching
                        Some(children) => {
                            let children = unsafe { children.as_ref() };
                            node = children.get(idx).expect("Child node not found");
                        }

                        // This is a leaf node, key is not present in the tree
                        None => return None,
                    }
                }
            }
        }
    }

    pub fn get_mut(&mut self, key: u64) -> Option<&mut V> {
        // Iterate down the tree till we find the key
        let mut node = &mut self.root;

        loop {
            let n = unsafe { node.as_mut() };

            match n.keys.binary_search(&key) {
                // Key found
                Ok(idx) => return n.values.get_mut(idx),

                // Key not found
                Err(idx) => {
                    match n.children {
                        // This is an internal node, go down to a child node and keep searching
                        Some(mut children) => {
                            let children = unsafe { children.as_mut() };
                            node = children.get_mut(idx).expect("Child node not found");
                        }

                        // This is a leaf node, key is not present in the tree
                        None => return None,
                    }
                }
            }
        }
    }

    /// TODO: Un-LLM-ify this
    pub fn get_nearest(&self, key: u64) -> Option<(u64, &V)> {
        let mut node = &self.root;
        let mut nearest: Option<(u64, &V)> = None;

        loop {
            let n = unsafe { node.as_ref() };
            let idx = n.keys.binary_search(&key).unwrap_or_else(|i| i);

            if idx > 0 {
                // There is a key less than or equal to the target key in this node
                let nearest_idx = idx - 1;
                let current_nearest = (n.keys[nearest_idx], &n.values[nearest_idx]);

                nearest = match nearest {
                    Some((nearest_key, _)) => {
                        if current_nearest.0 > nearest_key {
                            Some(current_nearest)
                        } else {
                            Some((nearest_key, nearest.unwrap().1))
                        }
                    }
                    None => Some(current_nearest),
                };
            }

            match n.children {
                Some(children) => {
                    let children = unsafe { children.as_ref() };
                    // Go to the child that is less than the key
                    if idx < children.len() {
                        node = children.get(idx).expect("Child node not found");
                    } else {
                        // Key is greater than all keys in this node, go to the last child
                        node = children.last().expect("Child node not found");
                    }
                }
                None => {
                    // Leaf node, return the nearest key found so far
                    return nearest;
                }
            }
        }
    }

    pub fn insert(&mut self, key: u64, value: V) {
        let split_info = self.insert_recursive(self.root, key, value);

        // Check if root was split, if so create a new root node with the
        // promoted key/value, old root as left child and new_node as the right child
        if let Some(split_info) = split_info {
            let mut children = ArrayVec::new();
            children.push(self.root);
            children.push(split_info.new_node);

            let children = Some(self.children_arena.alloc(children));

            let mut keys = ArrayVec::new();
            keys.push(split_info.promoted_key);

            let mut values = ArrayVec::new();
            values.push(split_info.promoted_value);

            let new_root = self.node_arena.alloc(Node { keys, values, children });
            self.root = new_root;
        }
    }

    /// Recursive B tree insert operation
    ///
    /// This function tries to insert a key/value pair into a node, splitting it if necessary (see [`SplitInfo`])
    fn insert_recursive(&mut self, mut node: NodePtr<V>, key: u64, value: V) -> Option<SplitInfo<V>> {
        let node = unsafe { node.as_mut() };

        match node.keys.binary_search(&key) {
            // Key already present in map, update it's value
            Ok(idx) => {
                let val = node.values.get_mut(idx).expect("Value not found");
                *val = value;
                None
            }

            // Key needs to be inserted
            Err(idx) => {
                match node.children {
                    // This is an internal node, recurse down to a child node
                    Some(mut children) => {
                        let children = unsafe { children.as_mut() };

                        let child = children.get(idx).expect("Child node not found");
                        let split_info = self.insert_recursive(*child, key, value);

                        // Check if child was split
                        if let Some(split_info) = split_info {
                            if node.keys.len() < ORDER {
                                // Node has space, insert promoted key and new child node
                                node.keys.insert(idx, split_info.promoted_key);
                                node.values.insert(idx, split_info.promoted_value);
                                children.insert(idx + 1, split_info.new_node);
                            } else {
                                // Current node is full, split this too
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

                    // This is a leaf node, key should be inserted here
                    None => {
                        if node.keys.len() < ORDER {
                            // Node has space, insert key
                            node.keys.insert(idx, key);
                            node.values.insert(idx, value);
                            None
                        } else {
                            // Node is full, split it
                            Some(self.split_node(node, idx, key, value, None))
                        }
                    }
                }
            }
        }
    }

    /// B tree node split operation
    ///
    /// This handles the case where a key/value pair needs to be inserted into `node` at index `idx`.
    /// however the node is full and there is no space for the insertion
    ///
    /// Half the existing key/value pairs in `node` are removed and inserted into `new_node`, then we
    /// check which one the new key/value pair needs to be inserted into and adjust
    ///
    /// When the node being split is an internal node then along with the key/value pair, an additional
    /// child node is also being inserted, this is the `internal_insert_child` argument
    ///
    /// See [`SplitInfo`] for more
    fn split_node(&mut self, node: &mut Node<V>, idx: usize, key: u64, value: V, internal_insert_child: Option<NodePtr<V>>) -> SplitInfo<V> {
        let mid = ORDER / 2;

        // new_node's children
        let new_node_children = match node.children {
            Some(mut children) => {
                let children = unsafe { children.as_mut() };

                // new_node has the upper half of node's children
                let mut new_node_children: Children<V> = children.drain((mid + 1)..).collect();

                // Insert the child node (in case of an internal node insert)
                if let Some(child) = internal_insert_child {
                    new_node_children.insert(idx - mid, child);
                }

                Some(self.children_arena.alloc(new_node_children))
            }

            None => None,
        };

        let mut new_node = Node {
            keys: node.keys.drain(mid..).collect(), // Remove upper half of node's key/values and put them into new_node
            values: node.values.drain(mid..).collect(),
            children: new_node_children,
        };

        // Figure out which node to insert key/value into based on the insertion index
        match idx.cmp(&mid) {
            // Key needs to be inserted in the center, so this key is the promoted one
            Ordering::Equal => {
                let new_node = self.node_arena.alloc(new_node);

                SplitInfo {
                    promoted_key: key,
                    promoted_value: value,
                    new_node,
                }
            }

            // Key needs to be inserted in the lower half, insert into node, topmost element of node becomes promoted
            Ordering::Less => {
                node.keys.insert(idx, key);
                node.values.insert(idx, value);

                let promoted_key = node.keys.remove(node.keys.len() - 1);
                let promoted_value = node.values.remove(node.keys.len() - 1);

                let new_node = self.node_arena.alloc(new_node);

                SplitInfo {
                    promoted_key,
                    promoted_value,
                    new_node,
                }
            }

            // Key needs to be inserted in the upper half, insert into new_node, bottommost element of new_node becomes promoted
            Ordering::Greater => {
                new_node.keys.insert(idx - mid, key);
                new_node.values.insert(idx - mid, value);

                let promoted_key = new_node.keys.remove(0);
                let promoted_value = new_node.values.remove(0);

                let new_node = self.node_arena.alloc(new_node);

                SplitInfo {
                    promoted_key,
                    promoted_value,
                    new_node,
                }
            }
        }
    }

    /// TODO: Un-LLM-ify the remove impl
    pub fn remove(&mut self, key: u64) -> Option<V> {
        self.remove_recursive(self.root, key)
    }

    fn remove_recursive(&mut self, mut node: NodePtr<V>, key: u64) -> Option<V> {
        let node = unsafe { node.as_mut() };

        match node.keys.binary_search(&key) {
            Ok(idx) => {
                // Key found
                if node.children.is_none() {
                    // Leaf node
                    node.keys.remove(idx);
                    let value = node.values.remove(idx);
                    Some(value)
                } else {
                    // Internal node
                    // Find the inorder predecessor (largest key in the left subtree)
                    let children = unsafe { node.children.as_mut().expect("Children should exist").as_mut() };
                    let mut predecessor_node = *children.get(idx).expect("Child should exist");
                    let mut predecessor_node_mut = unsafe { predecessor_node.as_mut() };

                    while let Some(mut pred_children) = predecessor_node_mut.children {
                        let pred_children_mut = unsafe { pred_children.as_mut() };
                        predecessor_node = *pred_children_mut
                            .last()
                            .expect("Predecessor should have children");
                        predecessor_node_mut = unsafe { predecessor_node.as_mut() };
                    }

                    // Replace the key and value to be deleted with the predecessor
                    let predecessor_key_idx = predecessor_node_mut.keys.len() - 1;
                    let predecessor_key = predecessor_node_mut.keys.remove(predecessor_key_idx);
                    let predecessor_value = predecessor_node_mut.values.remove(predecessor_key_idx);

                    let original_value = core::mem::replace(&mut node.values[idx], predecessor_value);
                    node.keys[idx] = predecessor_key;

                    // Recursively remove the predecessor from its original leaf node
                    self.remove_recursive(predecessor_node, predecessor_key)
                        .map(|_| original_value)
                }
            }
            Err(idx) => {
                // Key not found
                match node.children {
                    Some(mut children) => {
                        // Internal node, recurse down to the appropriate child
                        let children = unsafe { children.as_mut() };
                        let child = children.get_mut(idx).expect("Child not found");
                        self.remove_recursive(*child, key)
                    }
                    None => {
                        // Leaf node, key does not exist
                        None
                    }
                }
            }
        }
    }
}

use core::fmt::{self, Debug};

/// TODO: Un-LLM-ify the debug impl
impl<V: Debug> Debug for Map<V> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let mut map_debug = f.debug_map();
        self.fmt_node(&mut map_debug, self.root)?;
        map_debug.finish()
    }
}

impl<V: Debug> Map<V> {
    fn fmt_node(&self, map_debug: &mut fmt::DebugMap<'_, '_>, node_ptr: NodePtr<V>) -> fmt::Result {
        let node = unsafe { node_ptr.as_ref() };

        for i in 0..node.keys.len() {
            map_debug.entry(&node.keys[i], &node.values[i]);
        }

        if let Some(children_ptr) = node.children {
            let children = unsafe { children_ptr.as_ref() };
            for child in children.iter() {
                self.fmt_node(map_debug, *child)?;
            }
        }

        Ok(())
    }
}
