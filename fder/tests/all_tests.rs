mod infra;

// Your tests go here!
success_tests! {
    {
        name: fact,
        file: "fact.snek",
        input: "10",
        expected: "3628800",
    },
    {
        name: lam0,
        file: "lam0.snek",
        input: "0",
        expected: "6",
    },
    {
        name: lam1,
        file: "lam1.snek",
        input: "0",
        expected: "50",
    },
    {
        name: lam2,
        file: "lam2.snek",
        input: "0",
        expected: "(vec 6 50)",
    },
    {
        name: lam_compose,
        file: "lam-compose.snek",
        input: "100",
        expected: "102",
    },
    {
        name: lam_fac,
        file: "lam-fac.snek",
        input: "5",
        expected: "120",
    },
    {
        name: lam_map,
        file: "lam-map.snek",
        input: "100",
        expected: "(vec 110 (vec 120 (vec 130 false)))",
    },
    {
        name: lam_fold,
        file: "lam-fold.snek",
        input: "100",
        expected: "5050",
    },
    {
        name: lam_free0,
        file: "lam-free0.snek",
        input: "100",
        expected: "6",
    },
    {
        name: lam_free1,
        file: "lam-free1.snek",
        input: "1",
        expected: "(vec 6 15)",
    },
    {
        name: test1,
        file: "test1.snek",
        input: "10",
        expected: "10",
    },
    {
        name: test2,
        file: "test2.snek",
        input: "0",
        expected: "0",
    },
    {
        name: test3,
        file: "test3.snek",
        input: "97",
        expected: "true",
    },
    {
        name: test4,
        file: "test4.snek",
        input: "4",
        expected: "0",
    },
    {
        name: test5,
        file: "test5.snek",
        input: "50",
        expected: "(vec 6 50)",
    },
    {
        name: test6,
        file: "test6.snek",
        input: "50",
        expected: "31\n31",
    },
    {
        name: test7,
        file: "test7.snek",
        input: "50",
        expected: "45",
    },
    {
        name: test8,
        file: "test8.snek",
        input: "50",
        expected: "50",
    },
    {
        name: test9,
        file: "test9.snek",
        input: "50",
        expected: "20",
    },
    {
        name: test10,
        file: "test10.snek",
        input: "50",
        expected: "3",
    },
    {
        name: test11,
        file: "test11.snek",
        input: "7",
        expected: "720",
    },
    
    {
        name: test13,
        file: "test13.snek",
        input: "50",
        expected: "(vec 4 4)",
    },
    {
        name: test14,
        file: "test14.snek",
        input: "50",
        expected: "109",
    },
    {
        name: test15,
        file: "test15.snek",
        input: "50",
        expected: "3\n4\n3\n7\n4\n4",
    },
    {
        name: test16,
        file: "test16.snek",
        input: "50",
        expected: "(vec 2 6)",
    },
    {
        name: test17,
        file: "test17.snek",
        input: "50",
        expected: "3\n4\n3\n4",
    },
    {
        name: test18,
        file: "test18.snek",
        input: "50",
        expected: "37\n1\n1",
    },
    {
        name: test19,
        file: "test19.snek",
        input: "50",
        expected: "85",
    },
    {
        name: test20,
        file: "test20.snek",
        input: "50",
        expected: "52",
    },
    {
        name: test21,
        file: "test21.snek",
        input: "50",
        expected: "11",
    },
    {
        name: test22,
        file: "test22.snek",
        input: "50",
        expected: "false",
    },
    {
        name: test23,
        file: "test23.snek",
        input: "50",
        expected: "210",
    },
    {
        name: test24,
        file: "test24.snek",
        input: "50",
        expected: "(vec 60 (vec 70 (vec 80 false)))",
    },
    {
        name: test25,
        file: "test25.snek",
        input: "50",
        expected: "85",
    },



}

runtime_error_tests! {
    {
        name: lam_not_fun,
        file: "lam_not_fun.snek",
        input: "0",
        expected: "callee is not a function",
    },
    {
        name: lam_arity,
        file: "lam_arity.snek",
        input: "0",
        expected: "arity mismatch",
    },
    {
        name: test12,
        file: "test12.snek",
        input: "50",
        expected: "callee",
    },
}

static_error_tests! {
    {
        name: unbound,
        file: "unbound.snek",
        expected: "Unbound variable",
    }
}
