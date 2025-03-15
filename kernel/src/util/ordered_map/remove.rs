use super::{Node, OrderedMap, MIN_KEYS};
use crate::heap::Box;

struct RemovalInfo<V> {
    value: V,
    underflow: bool,
}

impl<V> OrderedMap<V> {
    pub fn remove(&mut self, key: u64) -> Option<V> {
        let removal_info = Self::remove_recursive(&mut self.root, key)?;

        if removal_info.underflow && self.root.keys.is_empty() {
            if self.root.is_leaf() {
                // Tree becomes empty
                self.root = Box::new(Node::new());
            } else {
                // Promote the first child as the new root
                self.root = self.root.children.remove(0);
            }
        }

        Some(removal_info.value)
    }

    fn remove_recursive(node: &mut Box<Node<V>>, key: u64) -> Option<RemovalInfo<V>> {
        match node.keys.binary_search(&key) {
            // Key found
            Ok(idx) => {
                if node.is_leaf() {
                    // Key found in leaf node, simply remove the key and check for underflow
                    node.keys.remove(idx);

                    Some(RemovalInfo {
                        value: node.values.remove(idx),
                        underflow: node.keys.len() < MIN_KEYS,
                    })
                } else {
                    // Key found in internal node
                    // Try removing the key and replacing from left child
                    if let Some(value) = Self::replace_from_left(node, idx) {
                        return Some(RemovalInfo { value, underflow: false });
                    }

                    // Try removing the key and replacing from right child
                    if let Some(value) = Self::replace_from_right(node, idx) {
                        return Some(RemovalInfo { value, underflow: false });
                    }

                    // Else, no choice but to remove and risk an underflow, caller will handle fixing it
                    node.keys.remove(idx);
                    let value = node.values.remove(idx);

                    Some(RemovalInfo {
                        value,
                        underflow: node.keys.len() < MIN_KEYS,
                    })
                }
            }

            // Key not found
            Err(child_idx) => {
                // Recurse down to child node if it exists
                let child = node.children.get_mut(child_idx)?;
                let removal_info = Self::remove_recursive(child, key);

                match removal_info {
                    // Key removed from child node, rebalance if necessary
                    Some(removal_info) => {
                        if removal_info.underflow {
                            if Self::rotate_from_left(node, child_idx) {
                                return Some(RemovalInfo {
                                    value: removal_info.value,
                                    underflow: false,
                                });
                            }

                            if Self::rotate_from_right(node, child_idx) {
                                return Some(RemovalInfo {
                                    value: removal_info.value,
                                    underflow: false,
                                });
                            }

                            Self::merge_with_sibling(node, child_idx);

                            return Some(RemovalInfo {
                                value: removal_info.value,
                                underflow: node.keys.len() < MIN_KEYS,
                            });
                        }

                        Some(RemovalInfo {
                            value: removal_info.value,
                            underflow: false,
                        })
                    }

                    // Key not found in entire child tree
                    None => None,
                }
            }
        }
    }

    /// This handles the case where we want to remove the key at `idx` from `node` and we are trying to replace it
    /// with a key from the left child of `idx`
    ///
    /// This checks if the left child has enough keys such that removing one won't cause it to underflow. If it succeeds,
    /// it removes the key at `idx` from `node`, replaces it with a key from the left child, and returns the removed key
    ///
    /// This never causes underflows because `node` retains its size (removed key is immediately replaced) and `left_child`
    /// is checked for underflow
    ///
    ///
    /// ## Illustration:
    ///
    /// Removing 8 from the root node by replacing from left child:
    ///
    ///                      [4 8]
    ///                  /     |     \
    ///           [1 2]     [5 6 7]     [9 10 11]
    ///
    /// This becomes:
    ///
    ///                      [4 7]
    ///                  /     |     \
    ///           [1 2]      [5 6]     [9 10 11]
    ///
    fn replace_from_left(node: &mut Box<Node<V>>, idx: usize) -> Option<V> {
        let left_child = node.children.get_mut(idx).expect("`left_child` should exist");

        // Proceed only if `left_child` will not underflow
        if left_child.keys.len() >= MIN_KEYS {
            let left_key = left_child.keys.pop().expect("`left_child` shouldn't be empty");
            let left_value = left_child.values.pop().expect("`left_child` shouldn't be empty");

            let node_key = node.keys.get_mut(idx).expect("`idx` out of bounds");
            *node_key = left_key;

            let node_value = node.values.get_mut(idx).expect("`idx` out of bounds");
            let removed_value = core::mem::replace(node_value, left_value);

            return Some(removed_value);
        }

        None
    }

    /// This handles the case where we want to remove the key at `idx` from `node` and we are trying to replace it
    /// with a key from the right child of `idx`
    ///
    /// This checks if the right child has enough keys such that removing one won't cause it to underflow. If it succeeds,
    /// it removes the key at `idx` from `node`, replaces it with a key from the right child, and returns the removed key
    ///
    /// This never causes underflows because `node` retains its size (removed key is immediately replaced) and `right_child`
    /// is checked for underflow
    ///
    ///
    /// ## Illustration:
    ///
    /// Removing 4 from the root node by replacing from right child:
    ///
    ///                      [4 8]
    ///                  /     |     \
    ///           [1 2]     [5 6 7]     [9 10 11]
    ///
    /// This becomes:
    ///
    ///                      [5 8]
    ///                  /     |     \
    ///           [1 2]      [6 7]     [9 10 11]
    ///
    fn replace_from_right(node: &mut Box<Node<V>>, idx: usize) -> Option<V> {
        let right_child = node.children.get_mut(idx + 1).expect("`right_child` should exist");

        if right_child.keys.len() >= MIN_KEYS {
            let right_key = right_child.keys.pop_at(0).expect("`right_child` shouldn't be empty");

            let right_value = right_child.values.pop_at(0).expect("`right_child` shouldn't be empty");

            let node_key = node.keys.get_mut(idx).expect("`idx` out of bounds");
            *node_key = right_key;

            let node_value = node.values.get_mut(idx).expect("`idx` out of bounds");
            let removed_value = core::mem::replace(node_value, right_value);

            return Some(removed_value);
        }

        None
    }

    /// This handles the case where a child of `node` has underflowed and we are trying to fix it by moving a key from
    /// its left sibling
    ///
    /// This moves a key from `node` into the underflown child to fix it, and moves a key from its left sibling to occupy
    /// the gap in `node` (ie a three-way rotation)
    ///
    /// This never causes further underflows because `node` retains its size (removed key is immediately replaced) and the
    /// left sibilng is checked for potential underflow
    ///
    ///
    /// ## Illustration:
    ///
    /// Fixing underflow in the 3rd child by rotating from its left sibling:
    ///
    ///                      [4 8]
    ///                  /     |     \
    ///           [1 2]     [5 6 7]     [10]
    ///
    /// This becomes:
    ///
    ///                      [4 7]
    ///                  /     |     \
    ///           [1 2]      [5 6]     [8 10]
    ///
    fn rotate_from_left(node: &mut Box<Node<V>>, child_idx: usize) -> bool {
        if child_idx == 0 {
            // No left sibling exists
            return false;
        }

        let left_sibling = node.children.get_mut(child_idx - 1).expect("`left_sibling` should exist");

        if left_sibling.keys.len() < MIN_KEYS {
            // Left sibling will also underflow
            return false;
        }

        let left_key = left_sibling.keys.pop().expect("`left_sibling` shouldn't be empty");
        let left_value = left_sibling.values.pop().expect("`left_sibling` shouldn't be empty");

        let node_key = node.keys.get_mut(child_idx - 1).expect("corresponding node key should exist");
        let node_key = core::mem::replace(node_key, left_key);

        let node_value = node.values.get_mut(child_idx - 1).expect("corresponding node key should exist");
        let node_value = core::mem::replace(node_value, left_value);

        let child = node.children.get_mut(child_idx).expect("`child_idx` out of bounds");
        child.keys.insert(0, node_key);
        child.values.insert(0, node_value);

        true
    }

    /// This handles the case where a child of `node` has underflowed and we are trying to fix it by moving a key from
    /// its right sibling
    ///
    /// This moves a key from `node` into the underflown child to fix it, and moves a key from its right sibling to occupy
    /// the gap in `node` (ie a three-way rotation)
    ///
    /// This never causes further underflows because `node` retains its size (removed key is immediately replaced) and the
    /// right sibilng is checked for potential underflow
    ///
    ///
    /// ## Illustration:
    ///
    /// Fixing underflow in the 1st child by rotating from its right sibling:
    ///
    ///                      [4 8]
    ///                  /     |     \
    ///             [2]     [5 6 7]     [9 10]
    ///
    /// This becomes:
    ///
    ///                      [5 8]
    ///                  /     |     \
    ///           [2 4]      [6 7]     [9 10]
    ///
    fn rotate_from_right(node: &mut Box<Node<V>>, child_idx: usize) -> bool {
        if child_idx >= node.keys.len() {
            // No right sibling exists
            return false;
        }

        let right_sibling = node.children.get_mut(child_idx + 1).expect("`right_sibling` should exist");

        if right_sibling.keys.len() < MIN_KEYS {
            // Right sibling will also underflow
            return false;
        }

        let right_key = right_sibling.keys.pop_at(0).expect("`right_sibling` shouldn't be empty");
        let right_value = right_sibling.values.pop_at(0).expect("`right_sibling` shouldn't be empty");

        let node_key = node.keys.get_mut(child_idx).expect("corresponding node key should exist");
        let node_key = core::mem::replace(node_key, right_key);

        let node_value = node.values.get_mut(child_idx).expect("corresponding node key should exist");
        let node_value = core::mem::replace(node_value, right_value);

        let child = node.children.get_mut(child_idx).expect("`child_idx` out of bounds");
        child.keys.push(node_key);
        child.values.push(node_value);

        true
    }

    /// This handles the case where a child of `node` has underflowed and we cannot fix it by rotating from either sibling
    /// (because then the siblings themselves might underflow)
    ///
    /// This merges the underflown child with a sibling and a key from `node`, producing one node with a sufficient number of keys
    ///
    /// This risks underflowing `node` because we remove a key from it without replacing it
    ///
    /// ## Illustration:
    ///
    /// Fixing underflow in the 1st child by merging with its right sibling:
    ///
    ///                      [4 8]
    ///                  /     |     \
    ///             [2]      [5 6]     [9 10]
    ///
    /// This becomes:
    ///
    ///                      [8]
    ///                  /          \
    ///            [2 4 5 6]       [9 10]
    ///
    /// Note that the root node has underflown in this case, and will have to be fixed further up the call stack
    ///
    fn merge_with_sibling(node: &mut Box<Node<V>>, child_idx: usize) {
        if child_idx > 0 {
            // Merge underflown child into left sibling
            let mut child = node.children.pop_at(child_idx).expect("`child_idx` out of bounds");

            let node_key = node.keys.pop_at(child_idx - 1).expect("corresponding node key should exist");
            let node_value = node.values.pop_at(child_idx - 1).expect("corresponding node key should exist");

            let left_sibling = node.children.get_mut(child_idx - 1).expect("`left_sibling` should exist");

            left_sibling.keys.push(node_key);
            left_sibling.values.push(node_value);

            left_sibling.keys.extend(child.keys.drain(..));
            left_sibling.values.extend(child.values.drain(..));
            left_sibling.children.extend(child.children.drain(..));
        } else {
            // Merge right sibling into underflown child
            let mut right_sibling = node.children.pop_at(child_idx + 1).expect("`right_sibling` should exist");

            let node_key = node.keys.pop_at(child_idx).expect("corresponding node key should exist");
            let node_value = node.values.pop_at(child_idx).expect("corresponding node key should exist");

            let child = node.children.get_mut(child_idx).expect("`child_idx` out of bounds");

            child.keys.push(node_key);
            child.values.push(node_value);

            child.keys.extend(right_sibling.keys.drain(..));
            child.values.extend(right_sibling.values.drain(..));
            child.children.extend(right_sibling.children.drain(..));
        }
    }
}
