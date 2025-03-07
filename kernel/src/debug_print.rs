use limine::framebuffer::{Framebuffer as LimineFramebuf, MemoryModel};
use spinning_top::Spinlock;

use crate::FRAMEBUFFER_REQUEST;

pub const HEADING: &str = "[kernel] ";
pub const SUBHEADING: &str = "       - ";

include!(concat!(env!("OUT_DIR"), "/console_font.rs"));

/// Represents an RGB32 framebuffer
struct Framebuffer {
    addr: *mut u8,
    width: usize,
    height: usize,
    pitch: usize,
    red_shift: u8,
    green_shift: u8,
    blue_shift: u8,
}

// Safety: addr is just a simple raw pointer and can be used by all threads
unsafe impl Send for Framebuffer {}

impl Framebuffer {
    #[expect(clippy::many_single_char_names)]
    fn draw_pixel(&mut self, x: usize, y: usize, r: u8, g: u8, b: u8) {
        // x/y should be within the framebuffer's bounds
        assert!(x < self.width, "x out of framebuffer bounds");
        assert!(y < self.height, "y out of framebuffer bounds");

        // x * 4 because 32 bit RGB has 4 bytes per pixel
        let offset = (x * 4) + (y * self.pitch);

        let color = (u32::from(r) << self.red_shift) | (u32::from(g) << self.green_shift) | (u32::from(b) << self.blue_shift);

        // Safety: This offset pointer is guaranteed to be within the framebuffer bounds
        // because x/y are within the width/height range
        let ptr = unsafe { self.addr.add(offset) };

        unsafe {
            ptr.cast::<u32>().write_volatile(color);
        }
    }

    fn width_in_chars(&self) -> usize {
        self.width / CHAR_WIDTH
    }

    fn height_in_chars(&self) -> usize {
        self.height / CHAR_HEIGHT
    }

    fn scroll(&mut self, amount: usize) {
        // Returns a slice representing a horizontal line at coordinate `y` in the framebuffer
        let line = |y| {
            assert!(y < self.height, "y out of framebuffer bounds");
            let offset = y * self.pitch;

            // Safety: This offset pointer is guaranteed to be within the framebuffer bounds
            // because `y` is in the height range
            let ptr = unsafe { self.addr.add(offset) };

            // Length of the slice, * 4 because we have 4 bytes per pixel
            let len = self.width * 4;

            // Safety: `ptr` is a valid pointer to the start of a line with length `len`
            unsafe { core::slice::from_raw_parts_mut(ptr, len) }
        };

        for y in 0..(self.height - amount) {
            let src_line = line(y);
            let dst_line = line(y + amount);

            src_line.copy_from_slice(dst_line);
        }

        for y in (self.height - amount)..self.height {
            line(y).fill(0);
        }
    }
}

struct DebugPrinter {
    framebuf: Framebuffer,
    cursor_x: usize,
    cursor_y: usize,
}

impl DebugPrinter {
    fn new() -> Option<Self> {
        // We only support 32 bit RGB framebuffers
        let framebuf_filter = |framebuf: &LimineFramebuf| framebuf.memory_model() == MemoryModel::RGB && framebuf.bpp() == 32;

        // Find the first framebuffer that matches our condition
        // If theres no response or suitable framebuffer we just return `None` and
        // debug printing won't happen
        let framebuf = FRAMEBUFFER_REQUEST
            .get_response()?
            .framebuffers()
            .find(framebuf_filter)?;

        // We have to make a copy of all data limine gives us (once bootloader memory is reclaimed it'll be lost)
        let addr = framebuf.addr();
        let width = framebuf.width() as usize;
        let height = framebuf.height() as usize;
        let pitch = framebuf.pitch() as usize;
        let red_shift = framebuf.red_mask_shift();
        let green_shift = framebuf.green_mask_shift();
        let blue_shift = framebuf.blue_mask_shift();

        // Sanity test that framebuffer addr is u32 aligned
        if addr as usize % 4 != 0 {
            return None;
        }

        let framebuf = Framebuffer {
            addr,
            width,
            height,
            pitch,
            red_shift,
            green_shift,
            blue_shift,
        };

        Some(Self {
            framebuf,
            cursor_x: 0,
            cursor_y: 0,
        })
    }

    pub fn print_char(&mut self, c: char) {
        match c {
            // New line + carriage return
            '\n' => self.new_line(),

            // Space
            ' ' => {
                // If the cursor is past the end of the screen go to new line
                // else just move to the next column
                if self.cursor_x == self.framebuf.width_in_chars() {
                    self.new_line();
                } else {
                    self.cursor_x += 1;
                }
            }

            // Regular character
            c => {
                // If the cursor is past the end of the screen go to new line
                if self.cursor_x == self.framebuf.width_in_chars() {
                    self.new_line();
                }

                // Pixel position where the top left of the glyph will be drawn
                let x_offset = self.cursor_x * CHAR_WIDTH;
                let y_offset = self.cursor_y * CHAR_HEIGHT;

                // Glyph coverage bitmap for this character
                let glyph = GLYPHS
                    .get(c as usize - '!' as usize) // Glyph array starts from '!'
                    .expect("Character outside of ASCII range");

                for (y, row) in glyph.iter().enumerate() {
                    for (x, pixel) in row.iter().enumerate() {
                        self.framebuf
                            .draw_pixel(x_offset + x, y_offset + y, *pixel, *pixel, *pixel);
                    }
                }

                // Go to next column
                self.cursor_x += 1;
            }
        }
    }

    fn new_line(&mut self) {
        // If we're at the last row scroll the screen, else just go to the next row
        if self.cursor_y == self.framebuf.height_in_chars() - 1 {
            self.framebuf.scroll(CHAR_HEIGHT);
        } else {
            self.cursor_y += 1;
        }

        // Go back to the start of the line as well
        self.cursor_x = 0;
    }
}

static DEBUG_PRINTER: Spinlock<Option<DebugPrinter>> = Spinlock::new(None);

pub fn init() {
    *DEBUG_PRINTER.lock() = DebugPrinter::new();
}

pub struct DebugPrintHelper;

impl core::fmt::Write for DebugPrintHelper {
    fn write_str(&mut self, s: &str) -> core::fmt::Result {
        let mut printer = DEBUG_PRINTER.lock();

        if let Some(printer) = printer.as_mut() {
            for c in s.chars() {
                printer.print_char(c);
            }
        }

        Ok(())
    }
}

pub fn debug_print_helper(args: core::fmt::Arguments) {
    _ = core::fmt::write(&mut DebugPrintHelper, args);
}

#[macro_export]
macro_rules! debug_print {
    ($prefix:expr; $($arg:tt)*) => {
        $crate::debug_print!("{}{}", $prefix, format_args!($($arg)*));
    };

    ($($arg:tt)*) => {
        $crate::debug_print::debug_print_helper(format_args!($($arg)*))
    };
}

#[macro_export]
macro_rules! debug_println {
    () => {
        $crate::debug_println!("")
    };

    ($prefix:expr; $($arg:tt)*) => {
        $crate::debug_print!("{}{}\n", $prefix, format_args!($($arg)*))
    };

    ($($arg:tt)*) => {
        $crate::debug_print!("{}\n", format_args!($($arg)*))
    };
}
