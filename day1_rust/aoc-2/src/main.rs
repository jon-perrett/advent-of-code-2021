use std::fs;
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename = &args[1];
    let contents = fs::read_to_string(filename)
        .expect("Something went wrong reading the file");
    let line_vec: Vec<i32> =  contents.lines().map(|item| item.trim().parse::<i32>().expect("failed")).collect::<Vec<i32>>();
    
    let mut counter = 0;
    let mut prev_sum = 0;
    let mut new_sum:i32;
    for (idx, _) in line_vec[0..line_vec.len()-2].iter().enumerate() {
        let sub_vec = &line_vec[idx..idx+3];
        
        new_sum = sub_vec.iter().sum();
        if new_sum > prev_sum && prev_sum != 0 {
            counter = counter + 1
        }
        prev_sum = new_sum;

    }
    println!("{:?}", counter)
}
