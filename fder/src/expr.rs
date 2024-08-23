use sexp::Atom::*;
use sexp::*;
use core::panic;

#[derive(Debug, Clone)]
pub struct Defn {
    pub name: Option<String>,
    pub params: Option<Vec<String>>,
    pub body: Box<Expr>,
}

#[derive(Debug, Clone)]
pub enum Op1 { Add1, Sub1, Neg, IsNum, IsBool, Print}
#[derive(Debug, Clone)]
pub enum Op2 { Plus, Minus, Times, Equal, Greater, GreaterEqual, Less, LessEqual, }

#[derive(Debug, Clone)]
pub enum Expr {
    Number(i64),
    Boolean(bool),
    Var(String),
    UnOp(Op1, Box<Expr>),
    BinOp(Op2, Box<Expr>, Box<Expr>),
    Input,
    If(Box<Expr>, Box<Expr>, Box<Expr>),
    Loop(Box<Expr>),
    Break(Box<Expr>),
    Set(String, Box<Expr>),
    Block(Vec<Expr>),
    Let(String, Box<Expr>, Box<Expr>),

    Vec(Box<Expr>, Box<Expr>),
    Get(Box<Expr>, Index),

    Call(String, Option<Vec<Expr>>),
    Fun(Defn),
}

#[derive(Debug, Clone)]
pub enum Index {
    Zero,
    One,
}

impl Index { 
    pub fn val(&self) -> usize { 
        match self {
            Index::Zero => 0,
            Index::One => 1,
        }
    }
}

#[derive(Debug, Clone)]
pub enum Arg {
    Var(usize),  // variable on stack frame at rbp - 8*i 
    Lbl(String), // code label 
    Con(usize),  // constant
}

fn parse_bind(s: &Sexp) -> (String, Expr) {
    match s {
        Sexp::List(vec) => match &vec[..] {
            [Sexp::Atom(S(x)), e] => (x.to_string(), parse_expr(e)),
            _ => panic!("Invalid parse error"),
        },
        _ => panic!("Invalid parse error"),
    }
}

fn parse_ident(s: &Sexp) -> String {
    match s {
        Sexp::Atom(S(x)) => x.to_string(),
        _ => panic!("Invalid parse error"),
    }
}

pub fn parse_defn(s: &Sexp) -> Expr {
    let Sexp::List(es) = s else {
        panic!("Invalid syntax error: expected a list")
    };
    match &es[..] {
        [Sexp::Atom(S(op)), Sexp::List(xs), body] if op == "defn" => {
            let [name, params @ ..] = &xs[..] else {
                panic!("Invalid missing function name");
            };
            let body = Box::new(parse_expr(body));
            let name = parse_ident(name);
            let params: Option<Vec<String>> = if params.is_empty() {
                None
            } else {
                Some(params.iter().map(parse_ident).collect())
            };
            Expr::Fun(Defn {
                name: Some(name),
                params,
                body,
            })
        }
        [Sexp::Atom(S(op)), Sexp::List(xs), body] if op == "fn" => {
            let [params @ ..] = &xs[..]; 
            let body = Box::new(parse_expr(body));
            let params: Option<Vec<String>> = if params.is_empty() {
                None
            } else {
                Some(params.iter().map(parse_ident).collect())
            };
            Expr::Fun(Defn {
                name: None,
                params,
                body,
            })
        }


        _ => panic!("Invalid syntax error: expected a list of 4 elements: {s}"),
    }
}

fn parse_prog(e: &Sexp) -> Expr {
    let Sexp::List(es) = e else {
        panic!("syntax error: expected a list")
    };

    if let [defs @ .., expr] = &es[..] {
        let defs = defs.iter().map(|e| parse_defn(e)).collect();
        let expr = Box::new(parse_expr(expr));
        prog(defs, expr)
    } else {
        panic!("Invalid syntax error: program must contain a main expression")
    }
}

fn prog(defs: Vec<Expr>, expr: Box<Expr>) -> Expr {
    let mut res = *expr;
    for def in defs.into_iter().rev() {
        if let Expr::Fun(Defn { name, .. }) = &def {
            res = match name {
                Some(name) => Expr::Let(name.clone(), Box::new(def), Box::new(res)),
                None => panic!("syntax error: expected a function definition name")
            }
        } else {
            panic!("Invalid syntax error: expected a function definition")
        }
    }
    res
}

fn parse_index(s: &Sexp) -> Index {
    match s {
        Sexp::Atom(I(0)) => Index::Zero,
        Sexp::Atom(I(1)) => Index::One,
        _ => panic!("Invalid parse error out-of-bounds: {s}"),
    }
}

fn parse_expr(s: &Sexp) -> Expr {
    match s {
        Sexp::Atom(I(n)) => {
            if *n >= -(1 << 62) && *n <= (1 << 62) - 1 { Expr::Number(*n) } else { panic!("Invalid"); }
        },
        Sexp::Atom(S(s)) if s == "input" => Expr::Input,
        Sexp::Atom(S(s)) if s == "false" => Expr::Boolean(false),
        Sexp::Atom(S(s)) if s == "true" => Expr::Boolean(true),
        Sexp::Atom(S(s)) => Expr::Var(s.clone()),
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
                let (x, e1) = parse_bind(bind);
                let e2 = parse_expr(e2);
                Expr::Let(x, Box::new(e1), Box::new(e2))
            }
            [Sexp::Atom(S(op)), Sexp::List(binds), e] if op == "let*" => {
                let xes :Vec<(String, Expr)> = binds.iter().map(parse_bind).collect();
                let mut res = parse_expr(e);
                for (x, e) in xes.into_iter().rev() {
                    res = Expr::Let(x, Box::new(e), Box::new(res))
                }
                res
            }
            [Sexp::Atom(S(op)), Sexp::Atom(S(x)), e] if op == "set!" => {
                Expr::Set(x.to_string(), Box::new(parse_expr(e)))
            }
            [Sexp::Atom(S(op)), exprs @ ..] if op == "block" => {
                Expr::Block(exprs.into_iter().map(parse_expr).collect())
            }
            [Sexp::Atom(S(op)), e1, e2] if op == "vec" => {
                Expr::Vec(Box::new(parse_expr(e1)), Box::new(parse_expr(e2)))
            }
            [Sexp::Atom(S(op)), e1, e2] if op == "vec-get" => {
                Expr::Get(Box::new(parse_expr(e1)), parse_index(e2))
            }
            [Sexp::Atom(S(op)), _, _] if op == "defn" || op == "fn" => {
                parse_defn(s)
            }
            [Sexp::Atom(S(f)), exprs @ ..] => {
                let reserved_words: Vec<&str> = vec!["let", "add1", "sub1", "+", "-", "*", ">", ">=", "<", "<=", "set!", "block", "break", "=", "isnum", "isbool", "if", "loop", "input", "true", "false", "defn", "fn"];
                if reserved_words.contains(&f.as_str()) { panic!("Invalid: Variable name cannot be a reserved keyword: {}", f); };
                let exprs: Option<Vec<Expr>> = if exprs.is_empty() {
                    None
                } else {
                    Some(exprs.into_iter().map(parse_expr).collect())
                };
                Expr::Call(f.to_string(), exprs)
            }
            _ => panic!("Invalid parse error (1) {}", s),
        },
        _ => panic!("Invalid parse error (2) {}", s),
    }
}

pub fn parse(s: &str) -> Expr {
    let s = format!("({})", s);
    let s = sexp::parse(&s).unwrap_or_else(|_| panic!("Invalid invalid s-expr"));
    parse_prog(&s)
}
