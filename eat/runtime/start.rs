use std::env;
use std::mem;

// 0 = num
// 101 = false
// 111 = true

static mut HEAP: [u64; 100000] = [0; 100000];


#[link(name = "our_code")]
extern "C" {
    // The \x01 here is an undocumented feature of LLVM that ensures
    // it does not add an underscore in front of the name.
    // Courtesy of Max New (https://maxsnew.com/teaching/eecs-483-fa22/hw_adder_assignment.html)
    #[link_name = "\x01our_code_starts_here"]
    fn our_code_starts_here(input: i64, heap: *mut u64) -> i64;
}

#[no_mangle]
#[export_name = "\x01snek_error"]
pub extern "C" fn snek_error(errcode: i64) {
    // TODO: print error message according to writeup
    let err: &str;

    if errcode == 33 {
        err = "invalid argument";
    } else if errcode == 66 {
        err = "overflow error";
    } else if errcode == 77 {
        err = "idx not a numb";
    } else if errcode == 88 {
        err = "heap ptr is not a pointer";
    } else if errcode == 99 {
        err = "out-of-bounds";
    } else {
        err = "Invalid";
    }

    eprintln!("an error occurred: {}", err);
    std::process::exit(1);
}

#[no_mangle]
#[export_name = "\x01snek_print"]
fn snek_print(val: i64) -> i64 {
    let result = snek_recurse(val);
    println!("{}", result);
    val
}

fn snek_recurse(val: i64) -> String {
    let result = if val == 3 {
        "false".to_string()
    } else if val == 7 {
        "true".to_string()
    } else if val & 1 == 0 {
        format!("{}", val >> 1)
    } else {
        let ptr: *const i64 = unsafe { mem::transmute::<i64, *const i64>(val - 1) };
        let mut current_ptr = ptr;
        let mut result = "(vec".to_string();
        let len = unsafe { *current_ptr } -1;
        current_ptr = unsafe { current_ptr.add(1) };
        for _ in 0..len {
            let value = unsafe { *current_ptr };
            result.push_str(&format!(" {}", snek_recurse(value)));
            current_ptr = unsafe { current_ptr.add(1) };
        }
        result.push_str(")");
        result
    };
    result
}

fn parse_arg(v: &Vec<String>) -> i64 {
    if v.len() <= 1 {
        return 3
    }
    let s = &v[1];
    if s == "true" {
        7
    } else if s == "false" {
        3
    } else {
        s.parse::<i64>().unwrap() << 1
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let input = parse_arg(&args);
    let i: i64 = unsafe { our_code_starts_here(input, HEAP.as_mut_ptr()) };
    snek_print(i);
}