use std::fs;
use std::env;
use std::io::Write;
use std::path::Path;
use std::ops::RangeInclusive;

use fontdue::{Font, FontSettings};

const FONT_SIZE: f32 = 13.8;
const CHAR_RANGE: RangeInclusive<char> = '!'..='~'; // ASCII char range
const BRIGHTNESS_SCALE: f32 = 0.93;

pub fn main() {
    // Tell cargo about our linker script
    println!("cargo:rustc-link-arg=-Tlinker.ld");
    println!("cargo:rerun-if-changed=linker.ld");

    // Build kernel console font
    let font_data = fs::read("NotoSansMono-Regular.ttf").unwrap();
    let font = Font::from_bytes(font_data, FontSettings::default()).unwrap();

    let out_dir = env::var("OUT_DIR").unwrap();
    let out_file = fs::File::create(Path::new(&out_dir).join("console_font.rs")).unwrap();

    // Calculate bitmap size
    let char_width = CHAR_RANGE
        .map(|c| font.metrics(c, FONT_SIZE).advance_width.ceil() as usize)
        .max()
        .unwrap();

    let horiz_metrics = font.horizontal_line_metrics(FONT_SIZE).unwrap();
    let char_height = horiz_metrics.new_line_size.ceil() as usize;

    let baseline_y = horiz_metrics.ascent.ceil() as i32;

    writeln!(
        &out_file,
        "pub const CHAR_WIDTH: usize = {char_width};
        pub const CHAR_HEIGHT: usize = {char_height};

        pub type Glyph = &'static [&'static [u8; CHAR_WIDTH]; CHAR_HEIGHT];

        pub const GLYPHS: &[Glyph] = &["
    ).unwrap();

    for c in CHAR_RANGE {
        let mut bitmap = vec![vec![0u8; char_width]; char_height];

        let (metrics, data) = font.rasterize(c, FONT_SIZE);
        
        for x in 0..metrics.width as i32 {
            for y in 0..metrics.height as i32 {
                let bitmap_x = x + metrics.xmin.max(0) as i32;
                let bitmap_y = y + baseline_y  - metrics.height as i32 - metrics.ymin;

                let idx = x + (y * metrics.width as i32);
                let coverage = (data[idx as usize] as f32 * BRIGHTNESS_SCALE) as u8;

                bitmap[bitmap_y as usize][bitmap_x as usize] = coverage;
            }
        }

        write!(&out_file, "// {c}\n&[").unwrap();

        for row in &bitmap {
            write!(&out_file, "&{row:?}, ").unwrap();
        }

        writeln!(&out_file, "],").unwrap();
    }

    writeln!(&out_file, "];").unwrap();
}