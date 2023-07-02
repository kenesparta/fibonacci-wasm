use shared::Fibonacci;
use std::env::args;
use std::io::stdin;

fn main() {
    let mut args: Vec<_> = args().skip(1).collect();
    if args.is_empty() {
        println!("Enter a non-negative number:");
        let mut idx = String::new();
        stdin().read_line(&mut idx).expect("Failed to read line");
        args.push(idx);
    }

    for arg in args {
        let idx = arg.trim().parse().expect("Failed to parse number");
        let fib_number = Fibonacci::new().take(idx).last();
        match fib_number {
            Some(fib_unwrap) => println!(
                "Fibonacci sequence number at index {} is {}",
                idx, fib_unwrap
            ),
            None => println!("Value is not allowed"),
        }
    }
}
