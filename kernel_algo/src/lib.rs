// Enable all lint groups except restriction
#![deny(
    clippy::all,
    clippy::correctness,
    clippy::suspicious,
    clippy::style,
    clippy::complexity,
    clippy::perf,
    clippy::pedantic
)]
// Lints from the restrictions group
#![deny(
    clippy::allow_attributes_without_reason,
    clippy::as_underscore,
    clippy::deref_by_slicing,
    clippy::else_if_without_else,
    clippy::empty_enum_variants_with_brackets,
    clippy::empty_structs_with_brackets,
    clippy::float_arithmetic,
    clippy::fn_to_numeric_cast_any,
    clippy::if_then_some_else_none,
    clippy::indexing_slicing,
    clippy::map_err_ignore,
    clippy::multiple_unsafe_ops_per_block,
    clippy::pattern_type_mismatch,
    clippy::tests_outside_test_module,
    clippy::todo,
    clippy::undocumented_unsafe_blocks,
    clippy::unwrap_used
)]
#![cfg_attr(not(test), no_std)]

pub mod mem;
