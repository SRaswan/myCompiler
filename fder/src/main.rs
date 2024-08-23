use std::fs::File;
use std::io::prelude::*;
use std::{cmp::max, env};

use expr::{Op1, Op2, Arg, Defn, Expr};
use im::{hashmap, HashMap, HashSet};

pub mod expr;

type Stack = HashMap<String, i32>;

const FALSE: usize = 3;
const TRUE: usize = 7;

fn test_number(code: usize) -> String {
    format!("mov rcx, rax
    and rcx, 1
    cmp rcx, 0
    mov rdi, {code}
    jne label_error\n")
}


fn test_overflow(code: usize) -> String {
    format!("\n  mov rdi, {code}
    jo label_error")
}


fn test_closure(code: usize, tag: usize) -> String {
    format!("mov rcx, rax
    and rcx, 5
    cmp rcx, {tag}
    mov rdi, {code}
    jne label_error\n")
}

fn test_arity(arity: usize) -> String {
    format!("mov rcx, rax
    sub rcx, 5
    mov rcx, [rcx+8]
    cmp rcx, {arity}
    mov rdi, 199
    jne label_error\n")
}


fn label(prefix: String, count: &i32) -> String {
    format!("{prefix}_{count}")
}

fn compile_args(
    exprs: &Vec<Expr>,
    env: &Stack,
    sp: usize,
    count: &mut i32,
    brk: &str,
    f: &str,
    inloop: bool
) -> String {
    let args_code: Vec<String> = exprs
        .iter()
        .enumerate()
        .map(|(i, e)| {
            let e_code = compile_expr(e, env, sp + i, count, brk, false, f, inloop);
            let e_pos = sp + i;
            format!(
                "{e_code}
    mov [rbp - 8*{e_pos}], rax",
            )
        })
        .collect();
    args_code.join("\n")
}

fn tuple_read(code: usize, tag: usize, index: usize) -> String {
    let test = test_closure(code, tag);
    format!("{test}
    sub rax, {tag}             ; strip tag
    mov rax, [rax + 8*{index}] ; read at index"
    )
}

fn tuple_alloc(args: &Vec<Arg>) -> String {
    let mut res: Vec<String> = vec![];
    for (i, arg) in args.iter().enumerate() {
        let load_rcx = match arg {
            Arg::Con(n) => format!("mov rcx, {n}"),
            Arg::Var(i_pos) => format!("mov rcx, [rbp - 8*{i_pos}]"),
            Arg::Lbl(label) => format!("lea rcx, QWORD [rel {label}]"),
        };
        res.push(format!("{load_rcx}
    mov [r12 + 8*{i}], rcx",
        ));
    }
    res.push(format!("mov rax, r12
    add r12, 8*{}",
        args.len()
    ));
    res.join("\n")
}

fn lookup_var(env: &Stack, x: &str) -> i32 {
    match env.get(x) {
        None => panic!("Unbound variable {}", x),
        Some(x_pos) => *x_pos,
    }
}

fn compile_var(env: &Stack, x: &str) -> String {
    let x_pos = lookup_var(env, x);
    format!("mov rax, [rbp - 8*{}]", x_pos)
}

fn compile_expr(
    e: &Expr,
    env: &Stack,
    sp: usize,
    count: &mut i32,
    brk: &str,
    tr: bool,
    f: &str,
    inloop: bool
) -> String {
    match e {
        Expr::Number(n) => format!("mov rax, {}", *n << 1),

        Expr::UnOp(op, e1) => {
            let e_code = compile_expr(e1, env, sp, count, brk, false, f, inloop);
            let testnum: String = test_number(99);
            let testof: String = test_overflow(499);
            match op {
              Op1::Print => format!("\n{e_code}\n  mov rdi, rax\n  call snek_print\n"),
              Op1::Neg => format!("\n{e_code}\n{testnum}\n  neg rax\n  {testof}"),
              Op1::Add1 => format!("\n{e_code}\n{testnum}\n  add rax, 2\n  {testof}"),
              Op1::Sub1 => format!("\n{e_code}\n{testnum}\n  sub rax, 2\n  {testof}"),
              Op1::IsBool | Op1::IsNum => {
                let (num1, num2) = match op {
                  Op1::IsBool => ("3", "7"),
                  Op1::IsNum => ("7", "3"),
                  _ => unreachable!()
                };
                *count += 1;
                format!("\n  {e_code}
        and rax, 1
        cmp rax, 0
        jne not_zero_{count}
        mov rax, {num1}
        jmp is_zero_{count}
        not_zero_{count}:
        mov rax, {num2}
        is_zero_{count}:\n")
              },
            }
        }
        Expr::Var(x) => compile_var(env, x),
        Expr::Let(x, e1, e2) => {
            let e1_code = compile_expr(e1, env, sp, count, brk, false, f, inloop);
            let x_pos = sp;
            let x_save = format!("mov [rbp - 8*{}], rax", x_pos);
            let new_env = env.update(x.to_string(), x_pos as i32);
            let e2_code = compile_expr(e2, &new_env, sp + 1, count, brk, tr, f, inloop);
            format!("{e1_code:}\n{x_save:}\n{e2_code:}")
        }
        Expr::BinOp(op, e1, e2) => {
            let e1_code = compile_expr(e2, env, sp, count, brk, false, f, inloop);
            let e2_code = compile_expr(e1, env, sp+1, count, brk, false, f , inloop);
            let testnum: String = test_number(99);
            let testof:String = test_overflow(499);
            match op {
              Op2::Plus | Op2::Minus | Op2::Times => {
                let (instr, shift) = match op {
                  Op2::Plus => ("add", ""),
                  Op2::Minus => ("sub", ""),
                  Op2::Times => ("imul", "sar rax, 1"),
                  _ => unreachable!()
                };
                format!("\n  {e1_code}
        {testnum}
        mov [rbp - 8*{sp}], rax
        {e2_code}
        {testnum}
        {shift}
        {instr} rax, [rbp - 8*{sp}]
        {testof}\n")
              },
              Op2::Equal => {
                *count += 1;
                let exit = label("eq_exit".to_string(), count);
                let code = 599;
                format!("\n  {e1_code}
        mov [rbp - 8*{sp}], rax
        {e2_code}
        mov rdx, rax
        and rdx, 1
        mov rcx, [rbp - 8*{sp}]
        and rcx, 1
        xor rcx, rdx
        mov rdi, {code}
        jnz label_error
        cmp rax, [rbp - 8*{sp}]
        mov rax, {FALSE}
        jne {exit}
        mov rax, {TRUE}
      {exit}:\n")
              },
              Op2::Greater | Op2::GreaterEqual | Op2::Less | Op2::LessEqual => {
                *count += 1;
                let jcond = match op {
                  Op2::Greater => "jg",
                  Op2::GreaterEqual => "jge",
                  Op2::Less =>  "jl",
                  Op2::LessEqual => "jle",
                  _ => unreachable!(),
                };
                let exit = label("eq_exit".to_string(), count);
                format!("\n  {e1_code}
        {testnum}
        mov [rbp - 8*{sp}], rax
        {e2_code}
        {testnum}
        cmp rax, [rbp - 8*{sp}]
        mov rax, {TRUE}
        {jcond} {exit}
        mov rax, {FALSE}
      {exit}:\n")
              },
            }
        },

        Expr::If(e_cond, e_then, e_else) => {
            let e_cond_code = compile_expr(e_cond, env, sp, count, brk, false, f, inloop);
            let e_then_code = compile_expr(e_then, env, sp, count, brk, tr, f, inloop);
            let e_else_code = compile_expr(e_else, env, sp, count, brk, tr, f, inloop);
            *count += 1;
            format!(
                "{e_cond_code}
    cmp rax, {FALSE}
    je label_else_{count}
    {e_then_code}
    jmp label_exit_{count}
label_else_{count}:
    {e_else_code}
label_exit_{count}:\n")
        }
        Expr::Input => {
            format!("mov rax, [rbp - 8]")
        }
        Expr::Boolean(b) =>{
            match b {
              true => format!("\nmov rax, {TRUE}\n"),
              false => format!("\nmov rax, {FALSE}\n")
            }
        },

        Expr::Set(x, e) => {
            let x_pos = match env.get(x) {
                Some(pos) => pos,
                None => panic!("Unbound variable identifier {}", x)
            };
            let e_code = compile_expr(e, env, sp, count, brk, false, f, inloop);
            format!("{e_code}
    mov [rbp - 8*{x_pos}], rax\n")
        }
        Expr::Block(es) => {
            let n = es.len();
            let e_codes: Vec<String> = es
                .iter()
                .enumerate()
                .map(|(i, e)| compile_expr(e, env, sp, count, brk, tr && i == n - 1, f, inloop))
                .collect();
            e_codes.join("\n")
        }
        Expr::Loop(e) => {
            *count += 1;
            let loop_start = label("loop_start".to_string(), count);
            let loop_exit = label("loop_exit".to_string(), count);
            let e_code = compile_expr(e, env, sp, count, &loop_exit, false, f, true);
            format!(
                "{loop_start}:
    {e_code}
    jmp {loop_start}
{loop_exit}:")
        }
        Expr::Break(e) => {
            let e_code = compile_expr(e, env, sp, count, brk, false, f, inloop);
            format!(
                "{e_code}
    jmp {brk}"
            )
        }
        Expr::Vec(e1, e2) => {
            let e1 = e1.clone();
            let e2 = e2.clone();
            let exprs = vec![*e1, *e2];
            let exprs_code = compile_args(&exprs, env, sp, count, brk, f, inloop);
            let args: Vec<Arg> = (sp..sp + exprs.len()).map(|i| Arg::Var(i)).collect();
            let alloc_code = tuple_alloc(&args);
            format!(
                "{exprs_code}
    {alloc_code}
    add rax, 0x1")
        }
        Expr::Get(e, idx) => {
            let e_code = compile_expr(e, env, sp, count, brk, false, f, inloop);
            let tuple_read = tuple_read(399, 1, idx.val());
            format!(
                "{e_code}
    {tuple_read}",
            )
        }
        Expr::Call(f, exprs) => {
            let eval_args = if let Some(exprs) = exprs {
                compile_args(exprs, env, sp, count, brk, f, inloop)
            } else {
                String::new()
            };
            let num_args = exprs.as_ref().map_or(0, |e| e.len());
            let push_args = push_args(sp, num_args);
            let eval_f = compile_var(env, f);
            let pop_args = format!("add rsp, 8*{}", num_args);
            let test_closure = test_closure(299, 5);
            let test_arity = test_arity(num_args);
            format!("{eval_args}
    {push_args}
    {eval_f}
    {test_closure}
    {test_arity}
    push rax
    sub rax, 5
    call [rax]
    {pop_args}\n")
        }
        Expr::Fun(defn) => compile_defn(defn, env, count),
    }
}

fn push_args(sp: usize, args: usize) -> String {
    let mut res: Vec<String> = vec![];
    for i in (0..args).rev() {
        let i_pos = sp + i;
        let i_code = format!("mov rcx, [rbp - 8*{i_pos}]
    push rcx",
        );
        res.push(i_code);
    }
    res.join("\n")
}


fn compile_exit() -> String {
    format!("mov rsp, rbp
    pop rbp
    ret"
    )
}

fn compile_entry(e: &Expr, sp: usize) -> String {
    let free_vars = free_vars(e);
    let vars = expr_vars(e) + sp + free_vars.len();
    format!(
        "push rbp
    mov rbp, rsp
    sub rsp, 8*{vars}"
    )
}

fn free_vars(e: &Expr) -> HashSet<String> {
    match e {
        Expr::Number(_) | Expr::Input | Expr::Boolean(_) => HashSet::new(),
        Expr::Var(x) => [x.clone()].iter().cloned().collect(),
        Expr::Fun(defn) => {
            let mut vars = free_vars(&defn.body);
            if let Some(params) = &defn.params {
                for param in params {
                    vars.remove(param);
                }
            }
            vars
        },
        Expr::UnOp(_, e) => free_vars(e),
        Expr::Set(_, e)
        | Expr::Loop(e)
        | Expr::Break(e)
        | Expr::Get(e, _) => free_vars(e),
        Expr::Let(x, e1, e2) => {
            let mut vars = free_vars(e1);
            vars.extend(free_vars(e2));
            vars.remove(x);
            vars
        },

        Expr::BinOp(_, e1, e2) => free_vars(e1).union(free_vars(e2)),
        Expr::Vec(e1, e2) => free_vars(e1).union(free_vars(e2)),
        Expr::If(e1, e2, e3) => free_vars(e1).union(free_vars(e2)).union(free_vars(e3)),
        Expr::Block(es) => es.iter().flat_map(free_vars).collect(),
        Expr::Call(f, exprs) => {
            let mut vars = if let Some(exprs) = exprs {
                exprs.iter().flat_map(free_vars).collect::<HashSet<_>>()
            } else {
                HashSet::new()
            };
            vars.insert(f.clone());
            vars
        },

    }
}

fn expr_vars(e: &Expr) -> usize {
    match e {
        Expr::Number(_) | Expr::Var(_) | Expr::Input | Expr::Boolean(_) | Expr::Fun(_) => 0,
        Expr::UnOp(_, e) => expr_vars(e),

        Expr::Set(_, e)
        | Expr::Loop(e) 
        | Expr::Break(e) 
        | Expr::Get(e, _) => expr_vars(e),
        Expr::BinOp(_, e1, e2) => max(expr_vars(e1), 1 + expr_vars(e2)),
        Expr::Let(_, e1, e2)
        | Expr::Vec(e1, e2) => max(expr_vars(e1), 1 + expr_vars(e2)),
        Expr::If(e1, e2, e3) => max(expr_vars(e1), max(expr_vars(e2), expr_vars(e3))),
        Expr::Block(es) => es.iter().map(|e| expr_vars(e)).max().unwrap(),
        Expr::Call(_, exprs) => {
            if let Some(exprs) = exprs {
                exprs.iter()
                    .enumerate()
                    .map(|(i, e)| i + expr_vars(e))
                    .max()
                    .unwrap_or(0)
            } else {
                0
            }
        },
    }
}

fn compile_defn(defn: &Defn, env: &Stack, count: &mut i32) -> String {
    let f = &defn_name(defn, count);
    let fun_entry = compile_entry(&defn.body, 1);
    let exit_label = format!("fun_exit_{f}");
    let free_xs = free_vars_defn(defn);
    let restore_free_vars = restore_free_vars(&free_xs);
    let body_env = init_env(f, defn, &free_xs);
    let body_code = compile_expr(&defn.body, &body_env, 1+free_xs.len(), count, &exit_label, true, f, false);
    let fun_exit = compile_exit();
    *count+=1;
    let label = format!("fun_start_{f}_{count}");
    let mut closure_args = vec![Arg::Lbl(label), Arg::Con(defn.params.as_ref().map_or(0, |p| p.len()))];
    for x in free_xs {
        closure_args.push(Arg::Var(lookup_var(env, &x) as usize))
    }
    let alloc_closure_tuple = tuple_alloc(&closure_args);
    format!("jmp fun_finish_{f}_{count}
    fun_start_{f}_{count}:
        {fun_entry}
    fun_body_{f}_{count}:
        {restore_free_vars}
        {body_code}
    fun_exit_{f}_{count}:
        {fun_exit}
    fun_finish_{f}_{count}:
        {alloc_closure_tuple}
        add rax, 5\n")
}

fn free_vars_defn(defn: &Defn) -> HashSet<String> {
    let mut vars = free_vars(&defn.body);
    if let Some(ref name) = defn.name {
        vars.remove(name);
    }
    if let Some(params) = &defn.params {
        for param in params {
            vars.remove(param);
        }
    }
    vars
}

fn init_env(f: &str, defn: &Defn, free_xs: &HashSet<String>) -> HashMap<String, i32> {
    let mut params = vec![f.to_string()];
    if let Some(defn_params) = &defn.params {
        for param in defn_params {
            params.push(param.clone());
        }
    }
    let mut env = hashmap!{};
    for (i, param) in params.into_iter().enumerate() {
        let pos = -2 - (i as i32);
        env.insert(param, pos);
    }
    for (i, x) in free_xs.iter().enumerate() {
        let pos = 1+i;
        env.insert(x.to_string(), pos as i32);
    }
    env
}


fn defn_name(def: &Defn, count: &mut i32) -> String {
    match def.name {
        Some(ref name) => name.clone(),
        None => {
            *count += 1;
            format!("anon_{count}")
        }
    }
}

fn restore_free_vars(xs: &HashSet<String>) -> String {
    let mut res:Vec<String> = vec![];
    for (i, _x) in xs.iter().enumerate() {
        let read_x = tuple_read(299, 5, i+2);
        let x_pos = i+1;
        res.push(format! ("mov rax, [rbp+16]
        {read_x}
        mov [rbp - 8*{x_pos}], rax"))
    }
    res.join("\n")
}

fn compile_prog(prog: &Expr) -> String {
    let mut count = 0;
    let e_entry = compile_entry(prog, 1);
    let e_code = compile_expr(
        prog,
        &hashmap! {},
        2,
        &mut count,
        "time_to_exit",
        false,
        "main",
        false
    );
    let e_exit = compile_exit();
    format!(
        "section .text
global our_code_starts_here
extern snek_error
extern snek_print
label_error:
    push rsp
    call snek_error
our_code_starts_here:
    {e_entry}
    mov [rbp - 8], rdi
    mov r12, rsi 
    {e_code}
    {e_exit}
time_to_exit:
    ret
"
    )
}

fn main() -> std::io::Result<()> {
    let args: Vec<String> = env::args().collect();

    let in_name = &args[1];
    let out_name = &args[2];

    let mut in_file = File::open(in_name)?;
    let mut in_contents = String::new();
    in_file.read_to_string(&mut in_contents)?;

    let prog = expr::parse(&in_contents);

    let mut out_file = File::create(out_name)?;
    let asm_program = compile_prog(&prog);

    out_file.write_all(asm_program.as_bytes())?;

    Ok(())
}

