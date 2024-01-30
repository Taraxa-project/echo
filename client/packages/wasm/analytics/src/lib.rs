// use emojis;
// use wasm_bindgen::prelude::*;

// When the `wee_alloc` feature is enabled, use `wee_alloc` as the global
// allocator.
// #[cfg(feature = "wee_alloc")]
// #[global_allocator]
// static ALLOC: wee_alloc::WeeAlloc = wee_alloc::WeeAlloc::INIT;

extern "C" {
    // pub fn callback();
    pub fn callback(s: *const i32);
    //     pub fn get_msg(s: &[u8]) -> *const u8;
}

#[no_mangle]
pub fn remove_emoji(string: &str) -> String {
    use unicode_segmentation::UnicodeSegmentation;
    let graphemes = string.graphemes(true);

    let is_not_emoji = |x: &&str| emojis::get(x).is_none();

    graphemes.filter(is_not_emoji).collect()
}

#[no_mangle]
pub unsafe fn run() {
    let x = remove_emoji("Yes 😀 !");
    println!(" {} ", x);
    // callback(b"fane");
    let y = 12;
    callback(&y);
}
