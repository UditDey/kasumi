use x86_64::{
    PhysAddr,
    registers::control::{Cr3, Cr3Flags},
    structures::paging::{PageTable, PhysFrame},
};

use crate::pmm;

use super::{alloc_zeroed_table, get_kernel_pml4};

/// A process' virtual address space
pub struct AddressSpace {
    pml4: PhysAddr,
}

impl AddressSpace {
    pub fn new() -> Self {
        let pml4_phys = alloc_zeroed_table(pmm::alloc_small);
        let pml4 = pmm::phys_to_hhdm(pml4_phys);

        // Lower half is zero, copy higher half from kernel PML4
        let kernel_pml4 = get_kernel_pml4();

        for i in 256..512 {
            // SAFETY: We own the brand new pml4
            let pml4 = unsafe { pml4.as_mut_ptr::<PageTable>().as_mut().unwrap() };
            pml4[i] = kernel_pml4[i].clone();
        }

        Self { pml4: pml4_phys }
    }

    /// Loads the address space PML4 into `cr3`
    ///
    /// This takes an `&self` because the PML4 physical address itself
    /// doesn't change. It's allocated once in `new()` and constant
    /// thereafter, although modifying the underlying mappings themselves
    /// requires an `&mut self`
    pub fn load(&self) {
        unsafe {
            Cr3::write(
                PhysFrame::from_start_address(self.pml4).unwrap(),
                Cr3Flags::empty(),
            );
        }
    }
}

impl PartialEq for AddressSpace {
    fn eq(&self, other: &Self) -> bool {
        self.pml4 == other.pml4
    }
}
