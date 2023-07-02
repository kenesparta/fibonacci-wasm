mod test;

use std::iter::Iterator;

pub struct Fibonacci {
    current: f64,
    next: f64,
}

impl Fibonacci {
    /// Starting the fibonacci series with `1.0` value
    pub fn new() -> Self {
        Fibonacci {
            current: 1.0,
            next: 1.0,
        }
    }
}

impl Iterator for Fibonacci {
    type Item = f64;

    /// We run this code to obtain the next element for each iteration
    fn next(&mut self) -> Option<Self::Item> {
        let result = self.next;
        self.next = self.current;
        self.current += result;
        Some(result)
    }
}

