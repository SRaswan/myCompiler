use std::fs::File;
use std::io::prelude::*;
use std::{cmp::max, env};

use expr::{Defn, Expr, Prog, Op1, Op2};
use im::{hashmap, HashMap};
type Stack = HashMap<String, i32>;


pub mod expr;

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

  // ______________________________________________________________________________________________________________________________
  // Program -> Defs and Expr
  // ______________________________________________________________________________________________________________________________

fn compile_prog(prog: &Prog) -> String {
  let mut count = 0;
  let mut funcs = Stack::new();
  if let Some(defs) = &prog.defs {
    defs.iter().for_each(|def| test_def(def, &mut funcs));
  }
  let defs_code = match &prog.defs {
    Some(defs) => defs
      .iter()
      .map(|def| compile_def(def, &mut count, &mut funcs))
      .collect::<Vec<String>>()
      .join("\n"),
    None => String::new(),
  };
  let e_entry = compile_entry(&prog.expr, 1);
  let e_code = compile_expr(&prog.expr, &hashmap! {}, 2, &mut count, "time_to_exit", false, "main", false, &funcs);
  format!("section .text
global our_code_starts_here
extern snek_error
extern snek_print
label_error:
  push rsp
  call snek_error
{defs_code}
our_code_starts_here:
{e_entry}
  mov [rbp - 8], rdi
{e_code}
  mov rsp, rbp
  pop rbp
time_to_exit:
  ret\n")
}


  // ______________________________________________________________________________________________________________________________
  // Defs -> Fun
  // ______________________________________________________________________________________________________________________________
fn test_def(def: &Defn, funcs: &mut Stack) {
  let (fun_name, args, _ ) = match def {
    Defn::Fun(f, x, e) => (f, x, e),
  };
  if funcs.contains_key(fun_name) {
    panic!("Duplicate functions {}", fun_name)
  };
  let mut args_len: i32 = 0;
  if let Some(args_vec) = args {
    args_len = args_vec.len() as i32;
  }
  funcs.insert(fun_name.to_string(), args_len);
}


fn compile_def(def: &Defn, count: &mut i32, funcs: &mut Stack,) -> String {
  let (fun_name, args, body ) = match def {
    Defn::Fun(f, x, e) => (f, x, e),
  };
  let body = compile_def_body(fun_name, args, 1, body, count, &funcs);
  format!("fun_start_{fun_name}:\n  {body}\n")
}

fn compile_def_body( fun_name: &String, args: &Option<Vec<String>>, sp: usize, body: &Expr, count: &mut i32, funcs: &Stack) -> String {
  let fun_entry = compile_entry(body, sp);
  let exit_label = format!("fun_exit_{fun_name}");
  let body_code = compile_expr(body, &init_env(args), sp, count, &exit_label, true, &format!("fun_{}", fun_name), false, funcs);
  format!("{fun_entry}
fun_body_{fun_name}:
  {body_code}
  mov rsp, rbp
  pop rbp
  ret\n")
}

fn init_env(args: &Option<Vec<String>>) -> Stack {
  match args {
    Some(args_vec) => {
      let mut env = Stack::new();
      let mut scope  = Vec::<String>::new();
      for (i, arg) in args_vec.iter().enumerate() {
        if scope.contains(arg) {
          panic!("Duplicate params: {}", arg);
        };
        scope.push(arg.to_string());
        env.insert(arg.clone(),  -2-i as i32);
      }
      env
    }
    None => HashMap::new(),
  }
}

fn compile_entry(e: &Expr, sp: usize) -> String {
  let vars = expr_vars(e) + sp;
  format!("push rbp
  mov rbp, rsp
  sub rsp, 8*{vars}\n")
}

fn expr_vars(e: &Expr) -> usize {
  match e {
    Expr::Number(_) | Expr::Id(_) | Expr::Input | Expr::Boolean(_) => 0,
    Expr::UnOp(_, e) | Expr::Set(_, e) | Expr::Loop(e) | Expr::Break(e) => expr_vars(e),
    Expr::Call(_, e1) => match e1 {
      None => 0,
      Some(es) => es.iter().enumerate().map(|(i, e)| i + expr_vars(e)).max().unwrap(),
    },
    Expr::Let(e1, e2) => e1.iter().map(|e| expr_vars(&e.1)).max().unwrap() + expr_vars(e2),
    Expr::BinOp(_, e1, e2) => max(expr_vars(e1), 1 + expr_vars(e2)),
    Expr::If(e1, e2, e3) => max(expr_vars(e1), max(expr_vars(e2), expr_vars(e3))),
    Expr::Block(es) => es.iter().map(|e| expr_vars(e)).max().unwrap(),
  }
}

  // ______________________________________________________________________________________________________________________________
  // Expr
  // ______________________________________________________________________________________________________________________________

fn compile_expr (e: &Expr, env: &Stack, sp: usize, count: &mut i32, brk: &str, tr: bool, f: &str, inloop: bool, funcs: &Stack) -> String {
  match e {
    Expr::Number(n) => format!("\n  mov rax, {}", *n << 1),
    Expr::Input => {
      if !f.eq("main") { panic!("Used input in function def")}
      format!("\nmov rax, [rbp - 8]\n")
    },
    Expr::Id(x) => {
      match env.get(x) {
          Some(pos) => format!("\n  mov rax, [rbp - 8*{}]", pos),
          None => panic!("Unbound variable identifier {}", x)
      }
    },
    Expr::Boolean(b) =>{
      match b {
        true => format!("mov rax, 3"),
        false => format!("mov rax, 1")
      }
    },
    Expr::Let(x, e1) => {
      let mut new_env: Stack = env.clone();
      let mut asm = String::new();
      let mut binds  = Vec::<String>::new();
      let mut sp_add = 0;
      for (id, exp) in x {

        if binds.contains(id) {
            panic!("Duplicate binding: {}", id);
        }
        binds.push(id.to_string());
        let val = compile_expr(exp, &new_env, sp+sp_add, count, brk, false, f, inloop, &funcs);
        asm += &format!("\n{}  \nmov [rbp - 8*{}], rax", val, sp+sp_add);
        new_env.insert(id.clone(), (sp+sp_add) as i32);
        sp_add += 1;

      }
      asm += &compile_expr(e1, &new_env, sp + sp_add, count, brk, tr, f, inloop, &funcs);
      asm
    },

    Expr::UnOp(op, e1) => {
      let e_code = compile_expr(e1, env, sp, count, brk, false, f, inloop, &funcs);
      let testnum: String = test_number(33);
      let testof: String = test_overflow(66);
      match op {
        Op1::Print => format!("\n{e_code}\n  mov rdi, rax\n  call snek_print\n"),
        Op1::Add1 => format!("\n{e_code}\n{testnum}\n  add rax, 2\n  {testof}"),
        Op1::Sub1 => format!("\n{e_code}\n{testnum}\n  sub rax, 2\n  {testof}"),
        Op1::IsBool | Op1::IsNum => {
          let (num1, num2) = match op {
            Op1::IsBool => ("1", "3"),
            Op1::IsNum => ("3", "1"),
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
    },
    Expr::BinOp(op, e1, e2) => {
      let e1_code = compile_expr(e2, env, sp, count, brk, false, f, inloop, &funcs);
      let e2_code = compile_expr(e1, env, sp+1, count, brk, false, f , inloop, &funcs);
      let testnum: String = test_number(33);
      let testof:String = test_overflow(66);
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
          let code = 33;
          format!("\n  {e1_code}
  mov rcx, rax
  and rcx, 1
  mov [rbp - 8*{sp}], rax
  {e2_code}
  mov rdx, rax
  and rdx, 1
  xor rcx, rdx
  mov rdi, {code}
  jnz label_error
  cmp rax, [rbp - 8*{sp}]
  mov rax, 1
  jne {exit}
  mov rax, 3
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
  mov rax, 3
  {jcond} {exit}
  mov rax, 1
{exit}:\n")
        },
      }
    },
    Expr::If(e_cond, e_then, e_else) => {
        let e_cond_code = compile_expr(e_cond, env, sp, count, brk, false, f, inloop, &funcs);
        let e_then_code = compile_expr(e_then, env, sp, count, brk, tr, f, inloop, &funcs);
        let e_else_code = compile_expr(e_else, env, sp, count, brk, tr, f, inloop, &funcs);
        *count += 1;
        format!("\n {e_cond_code}
  cmp rax, 1
  je label_else_{count}
  {e_then_code}
  jmp label_exit_{count}
  label_else_{count}:
  {e_else_code}
  label_exit_{count}:\n")
    },
    Expr::Set(x, e) => {
        let x_pos = match env.get(x) {
            Some(pos) => pos,
            None => panic!("Unbound variable identifier {}", x)
        };
        let e_code = compile_expr(e, env, sp, count, brk, false, f, inloop, &funcs);
        format!(
            "\n{e_code}
                mov [rbp - 8*{}], rax",
            x_pos
        )
    },
    Expr::Block(es) => {
      let n = es.len();
      let e_codes: Vec<String> = es
        .iter()
        .enumerate()
        .map(|(i, e)| compile_expr(e, env, sp, count, brk, tr && i == n - 1, f, inloop, &funcs))
        .collect();
      e_codes.join("\n")
    },
    Expr::Break(e) => {
        if !inloop { panic!("break error") };
        let e_code = compile_expr(e, env, sp, count, brk, false, f, inloop, &funcs);
        format!("\n{e_code}\n  jmp {brk}")
    },
    Expr::Loop(e) => {
        *count += 1;
        let loop_start = label("loop_start".to_string(), count);
        let loop_exit = label("loop_exit".to_string(), count);
        let e_code = compile_expr(e, env, sp, count, &loop_exit, false, f, true, &funcs);
        format!("\n{loop_start}:
  {e_code}
  jmp {loop_start}
  {loop_exit}:\n"
        )
    },
  
    Expr::Call(func, e1) => {
      let mut args_code = String::new();
      let mut push_args = String::new();
      let mut pops = 0;
      let func_ext = format!("fun_{}", func);
      if let Some(exprs) = e1 {
        pops = exprs.len();
        for (i, expr) in exprs.iter().enumerate() {
          let param = compile_expr(expr, env, sp + i, count, brk, false, &f, inloop, &funcs);
          let pos = sp+i;
          let rev_pos = pops-1-i+sp;
          let param_pos = -1-pops as i32+i as i32;
          args_code.push_str(&format!("\n{param}\nmov [rbp - 8*{pos}], rax\n"));
          if tr && func_ext.eq(f){ 
            push_args.push_str(&format!("\nmov rcx, [rbp-8*{rev_pos}]\nmov [rbp-8*{param_pos}], rcx\n"));
          } else { 
            push_args.push_str(&format!("\nmov rcx, [rbp-8*{rev_pos}]\npush rcx\n"));
          }
        }
      }
      if let Some(expected_args) = funcs.get(func) {
        if *expected_args != pops as i32 {
          panic!("Invalid: Number of arguments is wrong");
        }
      } else { panic!("Invalid: Function not found"); }
      if tr && func_ext.eq(f) {
        format!("{args_code}\n{push_args}\njmp fun_body_{func}\n")

      } else {
        format!("{args_code}\n{push_args}\ncall fun_start_{func}\nadd rsp, 8*{pops}\n")
      }
    }
  }
}

fn label(prefix: String, count: &i32) -> String {
  format!("{prefix}_{count}")
}

fn test_number(code: usize) -> String {
  format!("  mov rcx, rax
  and rcx, 1
  cmp rcx, 0
  mov rdi, {code}
  jne label_error\n")
}
fn test_overflow(code: usize) -> String {
  format!("  mov rdi, {code}
  jo label_error")
}