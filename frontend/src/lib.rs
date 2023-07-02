use shared::Fibonacci;
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
extern "C" {
    pub fn alert(s: &str);
    // pub fn prompt(s: &str);
}

#[wasm_bindgen]
pub fn fibonacci(index: usize) {
    if index <= 0 {
        alert(&format!("Value is not allowed"));
        return;
    }

    let result = Fibonacci::new().take(index).last();
    match result {
        Some(res) => alert(&format!("Fibonacci sequence number at index {} is {}", index, res)),
        None => alert(&format!("Value is not allowed")),
    }
}
