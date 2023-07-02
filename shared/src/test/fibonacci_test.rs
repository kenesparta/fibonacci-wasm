use crate::Fibonacci;

macro_rules! fib_tests {
    ($($name:ident: $value:expr,)*) => {
    $(
        #[test]
        fn $name() {
            let (input, expected) = $value;
            let result = Fibonacci::new().take(input).last();
            match result {
                Some(res) => assert_eq!(expected, res),
                _ => {}
            }
        }
    )*
    }
}

fib_tests! {
    fib_1: (1, 1.0),
    fib_2: (2, 1.0),
    fib_3: (3, 2.0),
    fib_4: (4, 3.0),
    fib_10: (10, 55.0),
    fib_43: (43, 433494437.0),
}
