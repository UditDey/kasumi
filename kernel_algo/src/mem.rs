mod bump_alloc;
mod page_alloc;

pub use bump_alloc::BumpAlloc;
pub use page_alloc::PageAlloc;

/// A physical address
pub type PAddr = usize;

/// A virtual address
pub type VAddr = usize;

/// A page 'number' (not a page's address)
///
/// Page address = `PageNum` * [`PAGE_SIZE`]
pub type PageNum = usize;

pub const PAGE_SIZE: usize = 4096;
