use limine::framebuffer::{Framebuffer, MemoryModel};
use spinning_top::Spinlock;

use crate::FRAMEBUFFER_REQUEST;

pub const HEADING_PREFIX: &str = "[kernel] ";
pub const SUBHEADING_PREFIX: &str = "       - ";

include!(concat!(env!("OUT_DIR"), "/console_font.rs"));

struct DebugPrinter {
    framebuf_addr: *mut u8,
    framebuf_width: u64,
    framebuf_height: u64,
    framebuf_pitch: u64,
    framebuf_red_shift: u8,
    framebuf_green_shift: u8,
    framebuf_blue_shift: u8,
    cursor_x: u64,
    cursor_y: u64,
}

// SAFETY: framebuf_addr is just a simple raw pointer and can be used by all threads
unsafe impl Send for DebugPrinter {}

impl DebugPrinter {
    pub fn new() -> Option<Self> {
        // We only support 32 bit RGB framebuffers
        let framebuf_filter = |framebuf: &Framebuffer| framebuf.memory_model() == MemoryModel::RGB && framebuf.bpp() == 32;

        // Find the first framebuffer that matches our condition
        // If theres no response or suitable framebuffer we just return `None` and
        // debug printing won't happen
        let framebuf = FRAMEBUFFER_REQUEST.get_response()?.framebuffers().find(framebuf_filter)?;

        // We have to make a copy of all data limine gives us since it all lives
        // in bootloader reclaimable memory, which means once we do reclaim it,
        // the data may be overwritten as we may use that memory for other purposes
        let framebuf_addr = framebuf.addr();
        let framebuf_width = framebuf.width();
        let framebuf_height = framebuf.height();
        let framebuf_pitch = framebuf.pitch();
        let framebuf_red_shift = framebuf.red_mask_shift();
        let framebuf_green_shift = framebuf.green_mask_shift();
        let framebuf_blue_shift = framebuf.blue_mask_shift();

        // Sanity test that framebuffer addr is u32 aligned
        if framebuf_addr as usize % 4 != 0 {
            return None;
        }

        Some(Self {
            framebuf_addr,
            framebuf_width,
            framebuf_height,
            framebuf_pitch,
            framebuf_red_shift,
            framebuf_green_shift,
            framebuf_blue_shift,
            cursor_x: 0,
            cursor_y: 0,
        })
    }

    pub fn print_char(&mut self, c: char) {
        match c {
            // New line + carriage return
            '\n' => self.new_line(),

            // Tab
            '\t' => {
                for _ in 0..4 {
                    self.print_char(' ');
                }
            }

            // Space
            ' ' => {
                // If the cursor is past the end of the screen go to new line
                // else just move to the next column
                if self.cursor_x == self.framebuffer_width_chars() {
                    self.new_line();
                } else {
                    self.cursor_x += 1;
                }
            }

            // Regular character
            c => {
                // If the cursor is past the end of the screen go to new line
                if self.cursor_x == self.framebuffer_width_chars() {
                    self.new_line();
                }

                // Pixel position where the top left of the glyph will be drawn
                let x_offset = self.cursor_x * CHAR_WIDTH;
                let y_offset = self.cursor_y * CHAR_HEIGHT;

                // Glyph coverage bitmap for this character
                let glyph = GLYPHS
                    .get(c as usize - '!' as usize)
                    .expect("Character outside of ASCII range");

                // Draw the character
                for y in 0..CHAR_HEIGHT {
                    for x in 0..CHAR_WIDTH {
                        #[allow(clippy::cast_possible_truncation, reason = "usize and u64 have same size here")]
                        #[allow(clippy::indexing_slicing, reason = "x/y will always be in CHAR_WIDTH/CHAR_HEIGHT range")]
                        let coverage = glyph[y as usize][x as usize];

                        self.draw_pixel(x_offset + x, y_offset + y, coverage, coverage, coverage);
                    }
                }

                // Go to next column
                self.cursor_x += 1;
            }
        }
    }

    /// Framebuffer width in characters
    fn framebuffer_width_chars(&self) -> u64 {
        self.framebuf_width / CHAR_WIDTH
    }

    /// Framebuffer height in characters
    fn framebuffer_height_chars(&self) -> u64 {
        self.framebuf_height / CHAR_HEIGHT
    }

    #[allow(clippy::many_single_char_names, reason = "Variable meanings are obvious")]
    fn draw_pixel(&self, x: u64, y: u64, r: u8, g: u8, b: u8) {
        // x/y should be within the framebuffer's bounds
        assert!(x < self.framebuf_width, "x outside of framebuffer bounds");
        assert!(y < self.framebuf_height, "y outside of framebuffer bounds");

        // x * 4 because 32 bit RGB has 4 bytes per pixel
        let offset = (x * 4) + (y * self.framebuf_pitch);

        #[allow(clippy::cast_possible_truncation, reason = "usize and u64 have same size here")]
        let offset = offset as usize;

        let color = (u32::from(r) << self.framebuf_red_shift)
            | (u32::from(g) << self.framebuf_green_shift)
            | (u32::from(b) << self.framebuf_blue_shift);

        // SAFETY: This offset pointer is guaranteed to be within the framebuffer bounds
        // because x/y are within the width/height range and we trust that limine has
        // given us correct framebuffer info overall
        let ptr = unsafe { self.framebuf_addr.add(offset) };

        #[allow(clippy::cast_ptr_alignment, reason = "ptr was tested to have u32 alignment in `new()`")]
        let ptr = ptr.cast::<u32>();

        // SAFETY: ptr is a valid pointer within the framebuffer
        unsafe {
            ptr.write_volatile(color);
        }
    }

    fn new_line(&mut self) {
        // If we're at the last row scroll the screen, else just go to the next row
        if self.cursor_y == self.framebuffer_height_chars() - 1 {
            self.scroll();
        } else {
            self.cursor_y += 1;
        }

        // Go back to the start of the line as well
        self.cursor_x = 0;
    }

    /// Scrolls the screen downards by one row
    fn scroll(&self) {
        // Returns a slice representing a horizontal line at coordinate `y` in the framebuffer
        let line = |y: u64| {
            assert!(y < self.framebuf_height, "y outside of framebuffer bounds");

            #[allow(clippy::cast_possible_truncation, reason = "usize and u64 have same size here")]
            let offset = (y * self.framebuf_pitch) as usize;

            // SAFETY: This offset pointer is guaranteed to be within the framebuffer bounds
            // because `y` is in the height range
            let ptr = unsafe { self.framebuf_addr.add(offset) };

            // Length of the slice, * 4 because we have 4 bytes per pixel
            #[allow(clippy::cast_possible_truncation, reason = "usize and u64 have same size here")]
            let len = self.framebuf_width as usize * 4;

            // SAFETY: `ptr` is a valid pointer to the start of a line with length `len`
            unsafe { core::slice::from_raw_parts_mut(ptr, len) }
        };

        // Go over every line (excluding the last row) and copy the corresponding line in the next row into it
        for y in 0..(self.framebuf_height - CHAR_HEIGHT) {
            let src_line = line(y);
            let dst_line = line(y + CHAR_HEIGHT);

            src_line.copy_from_slice(dst_line);
        }

        // Go over every line in the last row and zero it
        for y in (self.framebuf_height - CHAR_HEIGHT)..self.framebuf_height {
            line(y).fill(0);
        }
    }
}

static DEBUG_PRINTER: Spinlock<Option<DebugPrinter>> = Spinlock::new(None);

pub fn init() {
    *DEBUG_PRINTER.lock() = DebugPrinter::new();
}

pub struct Helper;

impl core::fmt::Write for Helper {
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

pub fn helper(args: core::fmt::Arguments) {
    _ = core::fmt::write(&mut Helper, args);
}

#[macro_export]
macro_rules! debug_print {
    ($prefix:expr; $($arg:tt)*) => {
        $crate::debug_print!("{}{}", $prefix, format_args!($($arg)*));
    };

    ($($arg:tt)*) => {
        $crate::debug_print::helper(format_args!($($arg)*))
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
