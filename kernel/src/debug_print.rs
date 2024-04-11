use core::fmt;
use core::slice;

use spinning_top::Spinlock;
use limine::framebuffer::{Framebuffer, MemoryModel};

use crate::FRAMEBUFFER_REQUEST;

pub const HEADING_PREFIX: &str =    "[kernel] ";
pub const SUBHEADING_PREFIX: &str = "       - ";

include!(concat!(env!("OUT_DIR"), "/console_font.rs"));

struct DebugPrinter {
    framebuffer: Framebuffer<'static>,
    cursor_x: u16,
    cursor_y: u16
}

impl DebugPrinter {
    pub fn new() -> Option<Self> {
        // We only support 32 bit RGB framebuffers
        let framebuffer_filter = |framebuffer: &Framebuffer| {
            framebuffer.memory_model() == MemoryModel::RGB && framebuffer.bpp() == 32
        };

        FRAMEBUFFER_REQUEST
            .get_response()
            .map(|res| res.framebuffers().find(framebuffer_filter))
            .flatten()
            .map(|framebuffer| Self {
                framebuffer,
                cursor_x: 0,
                cursor_y: 0
            })
    }

    pub fn print_char(&mut self, c: char) {
        match c {
            // New line + carriage return
            '\n' => self.new_line(),

            // Tab
            '\t' => for _ in 0..4 {
                self.print_char(' ');
            },

            // Space
            ' ' => {
                if self.cursor_x == self.framebuffer_width_chars() {
                    self.new_line()
                }
                
                self.cursor_x += 1;
            },

            // Regular character
            c => {
                if self.cursor_x == self.framebuffer_width_chars() {
                    self.new_line()
                }

                let x_offset = self.cursor_x as usize * CHAR_WIDTH as usize;
                let y_offset = self.cursor_y as usize * CHAR_HEIGHT as usize;
    
                let glyph = GLYPHS[c as usize - '!' as usize];
    
                for x in 0..CHAR_WIDTH {
                    for y in 0..CHAR_HEIGHT {
                        let coverage = glyph[y][x];
    
                        self.draw_pixel(x_offset + x, y_offset + y, coverage, coverage, coverage);
                    }
                }

                self.cursor_x += 1;
            }
        }
    }

    /// Framebuffer width in characters
    fn framebuffer_width_chars(&self) -> u16 {
        self.framebuffer.width() as u16 / CHAR_WIDTH as u16
    }

    /// Framebuffer height in characters
    fn framebuffer_height_chars(&self) -> u16 {
        self.framebuffer.height() as u16 / CHAR_HEIGHT as u16
    }

    fn draw_pixel(&self, x: usize, y: usize, r: u8, g: u8, b: u8) {
        let offset = (x * 4) + (y * self.framebuffer.pitch() as usize);

        let color = ((r as u32) << self.framebuffer.red_mask_shift()) |
                    ((g as u32) << self.framebuffer.green_mask_shift()) |
                    ((b as u32) << self.framebuffer.blue_mask_shift());

        unsafe {
            self.framebuffer
                .addr()
                .add(offset as usize)
                .cast::<u32>()
                .write_volatile(color);
        }
    }

    fn new_line(&mut self) {
        if self.cursor_y == self.framebuffer_height_chars() - 1 {
            self.scroll();
        }
        else {
            self.cursor_y += 1;
        }
        
        self.cursor_x = 0;
    }

    fn scroll(&self) {
        unsafe {
            for row in 0..self.framebuffer.height() as usize - CHAR_HEIGHT {
                let dst_ptr = self.framebuffer.addr().add(row * self.framebuffer.pitch() as usize);
                let dst_row = slice::from_raw_parts_mut(dst_ptr, self.framebuffer.width() as usize * 4);

                let src_ptr = self.framebuffer.addr().add((row + CHAR_HEIGHT) * self.framebuffer.pitch() as usize);
                let src_row = slice::from_raw_parts_mut(src_ptr, self.framebuffer.width() as usize * 4);

                dst_row.copy_from_slice(&src_row);
            }

            for row in (self.framebuffer.height() as usize - CHAR_HEIGHT)..self.framebuffer.height() as usize {
                let dst_ptr = self.framebuffer.addr().add(row * self.framebuffer.pitch() as usize);
                let dst_row = slice::from_raw_parts_mut(dst_ptr, self.framebuffer.width() as usize * 4);

                dst_row.fill(0);
            }
        }
    }
}

static DEBUG_PRINTER: Spinlock<Option<DebugPrinter>> = Spinlock::new(None);

pub fn init() {
    *DEBUG_PRINTER.lock() = DebugPrinter::new();
}

struct DebugPrintHelper;

impl fmt::Write for DebugPrintHelper {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        let mut printer = DEBUG_PRINTER.lock();

        if let Some(printer) = printer.as_mut() {
            for c in s.chars() {
                printer.print_char(c);
            }
        }

        Ok(())
    }
}

pub fn debug_print_helper(args: fmt::Arguments) {
    fmt::write(&mut DebugPrintHelper, args).unwrap();
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