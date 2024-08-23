use sexp::Atom::*;
use sexp::*;

use core::panic;

pub enum Op1 { Add1, Sub1, IsNum, IsBool, Print}

pub enum Op2 { Plus, Minus, Times, Equal, Greater, GreaterEqual, Less, LessEqual, }

pub struct Prog {
  pub defs: Option<Vec<Defn>>,
  pub expr: Box<Expr>,
}

pub enum Defn {
  Fun(String, Option<Vec<String>>, Box<Expr>),
}

pub enum Expr {
  Number(i64),
  Boolean(bool),
  Id(String),
  Let(Vec<(String, Expr)>, Box<Expr>),
  UnOp(Op1, Box<Expr>),
  BinOp(Op2, Box<Expr>, Box<Expr>),
  Input,
  If(Box<Expr>, Box<Expr>, Box<Expr>),
  Loop(Box<Expr>),
  Break(Box<Expr>),
  Set(String, Box<Expr>),
  Block(Vec<Expr>),

  Call(String, Option<Vec<Expr>>),

  Vec(Vec<Expr>),
  Get(Box<Expr>, Box<Expr>),
  Length(Box<Expr>),
}

fn parse_expr(s: &Sexp) -> Expr {
  match s {
    Sexp::Atom(I(n)) => {
        if *n >= -(1 << 62) && *n <= (1 << 62) - 1 { Expr::Number(*n) } else { panic!("Invalid"); }
    }
    Sexp::Atom(S(s)) if s == "input" => Expr::Input,
    Sexp::Atom(S(s)) if s == "false" => Expr::Boolean(false),
    Sexp::Atom(S(s)) if s == "true" => Expr::Boolean(true),
    Sexp::Atom(S(s)) => Expr::Id(s.clone()),
    Sexp::List(vec) => match &vec[..] {
      [Sexp::Atom(S(op)), e] if op == "add1" => Expr::UnOp(Op1::Add1, Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), e] if op == "sub1" => Expr::UnOp(Op1::Sub1, Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), e] if op == "isnum" => Expr::UnOp(Op1::IsNum, Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), e] if op == "isbool" => Expr::UnOp(Op1::IsBool, Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), e] if op == "print" => Expr::UnOp(Op1::Print, Box::new(parse_expr(e))),

      [Sexp::Atom(S(op)), e1, e2] if op == "+" => Expr::BinOp(Op2::Plus, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == "-" => Expr::BinOp(Op2::Minus, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == "*" => Expr::BinOp(Op2::Times, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == "=" => Expr::BinOp(Op2::Equal, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == ">" => Expr::BinOp(Op2::Greater, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == ">=" => Expr::BinOp(Op2::GreaterEqual, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == "<" => Expr::BinOp(Op2::Less, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1, e2] if op == "<=" => Expr::BinOp(Op2::LessEqual, Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e] if op == "loop" => Expr::Loop(Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), e] if op == "break" => Expr::Break(Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), e1, e2, e3] if op == "if" => Expr::If(Box::new(parse_expr(e1)), Box::new(parse_expr(e2)), Box::new(parse_expr(e3))),
      [Sexp::Atom(S(op)), bind, e2] if op == "let" => {
        let x = parse_bind(bind);
        let e2 = parse_expr(e2);
        Expr::Let(x, Box::new(e2))
      }
      [Sexp::Atom(S(op)), Sexp::Atom(S(x)), e] if op == "set!" => Expr::Set(x.to_string(), Box::new(parse_expr(e))),
      [Sexp::Atom(S(op)), exprs @ ..] if op == "block" => Expr::Block(exprs.into_iter().map(parse_expr).collect()),
      [Sexp::Atom(S(op)), exprs @ ..] if op == "vec" => Expr::Vec(exprs.into_iter().map(parse_expr).collect()),
      [Sexp::Atom(S(op)), e1, e2] if op == "vec-get" => Expr::Get(Box::new(parse_expr(e1)), Box::new(parse_expr(e2))),
      [Sexp::Atom(S(op)), e1] if op == "vec-len" => Expr::Length(Box::new(parse_expr(e1))),


      [Sexp::Atom(S(funname)), arg @ ..] => {
        let reserved_words: Vec<&str> = vec!["let", "add1", "sub1", "+", "-", "*", ">", ">=", "<", "<=", "set!", "block", "break", "=", "isnum", "isbool", "if", "loop", "input", "true", "false", "fun"];
        if reserved_words.contains(&funname.as_str()) { panic!("Invalid: Variable name cannot be a reserved keyword: {}", funname); };
        if arg.is_empty() {
          Expr::Call(funname.to_string(), None)
        } else {
          Expr::Call(funname.to_string(), Some(arg.into_iter().map(parse_expr).collect()))
        }
      },
      _ => panic!("parse error (1) Invalid {}", s),
    },
    _ => panic!("parse error (2) Invalid {}", s),
  }
}

fn parse_bind(s: &Sexp) -> Vec<(String, Expr)> {
  let reserved_words: Vec<&str> = vec!["let", "add1", "sub1", "+", "-", "*", ">", ">=", "<", "<=", "set!", "block", "break", "=", "isnum", "isbool", "if", "loop", "input", "true", "false", "fun"];
  match s {
    Sexp::List(vec) => {
      let mut bindings = Vec::new();
      for item in vec {
        match item {
          Sexp::List(vec) => match &vec[..] {
            [Sexp::Atom(S(x)), e] => {
                if reserved_words.contains(&x.as_str()) { panic!("Variable name cannot be a reserved keyword: {}", x); }
                bindings.push((x.to_string(), parse_expr(e)))
            },
            _ => panic!("parse err Invalid")
          }
          _ => panic!("parse err Invalid")
        }
      }
      bindings
    }
    _ => panic!("Invalid binding"),
  }
}

pub fn parse_defn(s: &Sexp) -> Defn {
  let Sexp::List(es) = s else {
      panic!("Invalid syntax error: expected a list")
  };
  match &es[..] {
    [Sexp::Atom(S(op)), Sexp::List(es), body] if op == "fun" => {
      let [name, params @ ..] = &es[..] else {
        panic!("Invalid missing function name");
      };

      let body = Box::new(parse_expr(body));
      let name: String = parse_ident(name);
      let params = if params.is_empty() {
        None
      } else {
        Some(params.iter().map(|param| parse_ident(param)).collect())
      };
      Defn::Fun(name, params, body)
    },
    _ => panic!("parse error Invalid"),
  }
}


fn parse_prog(e: &Sexp) -> Prog {
  let Sexp::List(es) = e else {
      panic!("Invalid syntax error: expected a list")
  };
  // println!("{:?} with length = {}", es, es.len());

  if let [expr] = &es[..] {
      Prog { defs: None, expr: Box::new(parse_expr(expr)) }
  } else if let [defs @ .., expr] = &es[..] {
      let defs = Some(defs.iter().map(|e| parse_defn(e)).collect());
      Prog { defs: defs, expr: Box::new(parse_expr(expr)) }
  } else {
      panic!("Invalid syntax error: program must contain a main expression")
  }
}

pub fn parse(s: &str) -> Prog {
  let s = format!("({})", s);
  let s = sexp::parse(&s).unwrap_or_else(|_| panic!("Invalid s-expr"));
  parse_prog(&s)
}

fn parse_ident(s: &Sexp) -> String {
  let reserved_words: Vec<&str> = vec!["let", "add1", "sub1", "+", "-", "*", ">", ">=", "<", "<=", "set!", "block", "break", "=", "isnum", "isbool", "if", "loop", "input", "true", "false", "fun"];
  match s {
    Sexp::Atom(S(x)) => {
      if reserved_words.contains(&x.as_str()) { panic!("Variable name cannot be a reserved keyword: {}", x); };
      x.to_string()
    }
    _ => panic!("Invalid parse error"),
  }
}