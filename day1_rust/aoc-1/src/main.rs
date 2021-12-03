use std::fs;
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let contents = fs::read_to_string(filename)
        .expect("Something went wrong reading the file");
    
    let mut old_val = 0;
    let mut counter = 0;
    for (idx, val) in contents.lines().enumerate() {
        let new_val = val.trim().parse::<i32>().expect("failed");
        if idx > 0 {
            if new_val > old_val {
                counter = counter + 1;
            }
        }
        old_val = new_val;
    }
    println!("{}", counter.to_string())
}
