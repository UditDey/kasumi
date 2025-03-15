use core::cmp::Ordering;

use super::{Children, Node, OrderedMap, ORDER};
use crate::heap::Box;

/// Result of a node split operation
///
/// [`split_node()`] implements the B tree node split operation
///
/// It splits a node into 2 by removing elements from the original node
/// and moving them into a newly allocated node. The original node becomes
/// the "left" node (and has the lower keys), and the new node is the "right"
/// node (and has the higher keys). Additionally, the function produces a
/// key/value pair that is to be promoted from the split node into it's parent
struct SplitInfo<V> {
    promoted_key: u64,
    promoted_value: V,
    new_node: Box<Node<V>>,
}

impl<V> OrderedMap<V> {
    pub fn insert(&mut self, key: u64, value: V) {
        let split_info = Self::insert_recursive(&mut self.root, key, value);

        // Check if root was split, if so, create a new root node with the
        // promoted key/value, old root as left child and new_node as the right child
        if let Some(split_info) = split_info {
            let new_root = Box::new(Node::new());
            let old_root = core::mem::replace(&mut self.root, new_root);

            self.root.keys.push(split_info.promoted_key);
            self.root.values.push(split_info.promoted_value);
            self.root.children.push(old_root);
            self.root.children.push(split_info.new_node);
        }
    }

    /// Recursive B tree insert operation
    ///
    /// This function tries to insert a key/value pair into a node, splitting it if necessary (see [`SplitInfo`])
    fn insert_recursive(node: &mut Box<Node<V>>, key: u64, value: V) -> Option<SplitInfo<V>> {
        match node.keys.binary_search(&key) {
            // Key already present in tree, update its value
            // Safety: Each key has a corresponding value
            Ok(idx) => unsafe {
                *node.values.get_unchecked_mut(idx) = value;
                None
            },

            // Key needs to be inserted
            Err(idx) => {
                if node.is_leaf() {
                    // Try inserting the key here
                    if node.keys.len() < ORDER {
                        // Node has space, insert key
                        node.keys.insert(idx, key);
                        node.values.insert(idx, value);
                        return None;
                    }

                    // Node is full, split it
                    Some(Self::split_node(node, idx, key, value, None))
                } else {
                    // Recurse down to a child node
                    let child = node.children.get_mut(idx).expect("child node should be present");
                    let split_info = Self::insert_recursive(child, key, value);

                    // Check if child was split
                    if let Some(split_info) = split_info {
                        if node.keys.len() < ORDER {
                            // Node has space, insert promoted key and new child node
                            node.keys.insert(idx, split_info.promoted_key);
                            node.values.insert(idx, split_info.promoted_value);
                            node.children.insert(idx + 1, split_info.new_node);
                        } else {
                            // Current node is full, split this too
                            return Some(Self::split_node(
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
            }
        }
    }

    /// B tree node split operation
    ///
    /// This handles the case where a key/value pair needs to be inserted into `node` at index `idx`,
    /// but the node is full and there is no space for the insertion
    ///
    /// Half the existing key/value pairs in `node` are removed and inserted into `new_node`, then we
    /// check which one the new key/value pair needs to be inserted into and adjust
    ///
    /// When the node being split is an internal node then along with the key/value pair, an additional
    /// child node is also being inserted, this is the `internal_insert_child` argument
    ///
    /// See [`SplitInfo`] for more
    fn split_node(node: &mut Node<V>, idx: usize, key: u64, value: V, internal_insert_child: Option<Box<Node<V>>>) -> SplitInfo<V> {
        let mid = ORDER / 2;

        // new_node's children, new_node has the upper half of node's children
        let mut new_node_children: Children<V> = if node.is_leaf() {
            Children::new()
        } else {
            node.children.drain((mid + 1)..).collect()
        };

        // Insert the child node (in case of an internal node insert)
        if let Some(child) = internal_insert_child {
            new_node_children.insert(idx - mid, child);
        }

        let mut new_node = Box::new(Node {
            keys: node.keys.drain(mid..).collect(), // Remove upper half of node's key/values and put them into new_node
            values: node.values.drain(mid..).collect(),
            children: new_node_children,
        });

        // Figure out which node to insert key/value into based on the insertion index
        match idx.cmp(&mid) {
            // Key needs to be inserted in the center, so this key is the promoted one
            Ordering::Equal => SplitInfo {
                promoted_key: key,
                promoted_value: value,
                new_node,
            },

            // Key needs to be inserted in the lower half, insert into node, topmost element of node becomes promoted
            Ordering::Less => {
                node.keys.insert(idx, key);
                node.values.insert(idx, value);

                let promoted_key = node.keys.remove(node.keys.len() - 1);
                let promoted_value = node.values.remove(node.keys.len() - 1);

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

                SplitInfo {
                    promoted_key,
                    promoted_value,
                    new_node,
                }
            }
        }
    }
}
