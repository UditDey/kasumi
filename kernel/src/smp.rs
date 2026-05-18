use limine::response::MpResponse;

use crate::{debug_print::HEADING, debug_println, final_init};

pub fn init(mp_resp: &MpResponse) -> ! {
    debug_println!(HEADING; "Entering SMP:");

    // Send APs to final_init
    let aps = mp_resp
        .cpus()
        .iter()
        .filter(|cpu| cpu.lapic_id != mp_resp.bsp_lapic_id());

    for ap in aps {
        ap.goto_address.write(final_init);
    }

    // Send BSP to final_init
    let bsp = mp_resp
        .cpus()
        .iter()
        .find(|cpu| cpu.lapic_id == mp_resp.bsp_lapic_id())
        .unwrap(); // Literally impossible

    final_init(bsp)
}
