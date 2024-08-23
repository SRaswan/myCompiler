use std::env;
use std::mem;

static mut HEAP: [u64; 100000] = [0; 100000];

#[link(name = "our_code")]
extern "C" {
    // The \x01 here is an undocumented feature of LLVM (which Rust uses) that ensures
    // it does not add an underscore in front of the name, which happens on OSX
    // Courtesy of Max New
    // (https://maxsnew.com/teaching/eecs-483-fa22/hw_adder_assignment.html)
    #[link_name = "\x01our_code_starts_here"]
    fn our_code_starts_here(input: i64, heap: *mut u64) -> i64;
}

#[no_mangle]
#[export_name = "\x01snek_error"]
pub fn snek_error(errcode: i64) {
    if errcode == 99 {
        eprintln!("Run-time error: invalid argument not a num");
    } else if errcode == 199 {
        eprintln!("Run-time error: arity mismatch");
    } else if errcode == 299 {
        eprintln!("Run-time error: callee is not a function");
    } else if errcode == 399 {
        eprintln!("Run-time error: not a pointer");
    } else if errcode == 499 {
        eprintln!("Run-time error: overflow");
    } else if errcode == 599 {
        eprintln!("Run-time error: unequal types");
    }else {
        eprintln!("Run-time error: [{}]", errcode);
    }
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
    } else if val & 0b111 == 0b001 {
        let ptr: *const i64 = unsafe { mem::transmute::<i64, *const i64>(val - 1) };
        let val1 = unsafe { *ptr };
        let val2 = unsafe { *ptr.add(1) };
        format!("(vec {} {})", snek_recurse(val1), snek_recurse(val2))
    } else {
        let ptr: *const i64 = unsafe { mem::transmute::<i64, *const i64>(val - 1) };
        format!("{}",  ptr as i64)
    };
    result
}


fn parse_arg(v: &Vec<String>) -> i64 {
    if v.len() <= 1 {
        return 3;
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
