mod infra;

// Your tests go here!
success_tests! {

    {
        name: linsearch,
        file: "linsearch.snek",
        input: "-8956",
        expected: "6",
    },
    {
        name: simple_examples,
        file: "simple_examples.snek",
        input: "2",
        expected: "(vec 1 2 (vec 1 2 (vec 1 2 (vec 1 2 (vec 1 2 (vec 1 true))))))\n(vec 1 2 (vec 1 2 (vec 1 2 (vec 1 2 (vec 1 true)))))",
    },
    {
        name: vec_get,
        file: "vec_get.snek",
        input: "10",
        expected: "30",
    },
    {
        name: vec_inc_0,
        file: "vec_inc_0.snek",
        input: "10",
        expected: "(vec 20 (vec 30 (vec 40 false)))",
    },
    {
        name: vec_inc,
        file: "vec_inc.snek",
        input: "10",
        expected: "(vec 20 (vec 30 (vec 40 false)))",
    },
    {
        name: vec_new,
        file: "vec_new.snek",
        input: "10",
        expected: "(vec 10 (vec 20 (vec 30 false)))",
    },
    {
        name: vec_sum,
        file: "vec_sum.snek",
        input: "10",
        expected: "60",
    },
    {
        name: fact,
        file: "fact.snek",
        input: "10",
        expected: "3628800",
    },
    {
        name: even_odd_1,
        file: "even_odd.snek",
        input: "10",
        expected: "10\ntrue\ntrue",
    },
    {
        name: even_odd_2,
        file: "even_odd.snek",
        input: "9",
        expected: "9\nfalse\nfalse",
    },
    {
        name: test1,
        file: "test1.snek",
        expected: "3",
    },
    {
        name: test2,
        file: "test2.snek",
        expected: "true",
    },
    {
        name: test3,
        file: "test3.snek",
        expected: "6",
    },
    {
        name: test4,
        file: "test4.snek",
        expected: "-6",
    },
    {
        name: test5,
        file: "test5.snek",
        input: "3",
        expected: "6",
    },
    {
        name: test8,
        file: "test8.snek",
        expected: "-3776",
    },
    {
        name: test9,
        file: "test9.snek",
        expected: "6572",
    },
    {
        name: test10,
        file: "test10.snek",
        expected: "102",
    },
    {
        name: test11,
        file: "test11.snek",
        input: "33",
        expected: "38",
    },
    {
        name: test13,
        file: "test13.snek",
        expected: "false",
    },
    {
        name: test14,
        file: "test14.snek",
        expected: "false",
    },

    {
        name: test19,
        file: "test19.snek",
        expected: "20",
    },
    {
        name: test20,
        file: "test20.snek",
        input: "5",
        expected: "20",
    },
    {
        name: test21,
        file: "test21.snek",
        input: "5",
        expected: "15",
    },
    {
        name: test22,
        file: "test22.snek",
        expected: "21",
    },
    {
        name: test23,
        file: "test23.snek",
        expected: "25",
    },
    {
        name: test24,
        file: "test24.snek",
        expected: "22",
    },
    {
        name: test25,
        file: "test25.snek",
        expected: "30",
    },
    {
        name: test26,
        file: "test26.snek",
        expected: "30",
    },
    {
        name: test27,
        file: "test27.snek",
        expected: "4",
    },
    {
        name: test28,
        file: "test28.snek",
        expected: "22",
    },
    {
        name: test29,
        file: "test29.snek",
        expected: "50",
    },
    {
        name: test30,
        file: "test30.snek",
        expected: "3",
    },
    {
        name: test31,
        file: "test31.snek",
        expected: "4",
    },
    {
        name: test32,
        file: "test32.snek",
        expected: "3",
    },
    {
        name: test34,
        file: "test34.snek",
        expected: "2",
    },
    {
        name: test36,
        file: "test36.snek",
        expected: "8",
    },
    {
        name: test37,
        file: "test37.snek",
        expected: "3",
    },
    {
        name: test39,
        file: "test39.snek",
        expected: "true",
    },
    {
        name: test40,
        file: "test40.snek",
        expected: "210",
    },
    {
        name: test42,
        file: "test42.snek",
        input: "26",
        expected: "false",
    },
    {
        name: test46,
        file: "test46.snek",
        input: "97",
        expected: "true",
    },
    {
        name: test47,
        file: "test47.snek",
        input: "4",
        expected: "4\n1",
    },
    {
        name: test53,
        file: "test53.snek",
        expected: "0",
    },
    {
        name: test54,
        file: "test54.snek",
        expected: "0",
    },
    {
        name: test57,
        file: "test57.snek",
        expected: "200\n200",
    },
    {
        name: test58,
        file: "test58.snek",
        expected: "12\n13\n14\n15\n25\n26\n33\nfalse\nfalse",
    },
    {
        name: test59,
        file: "test59.snek",
        input: "10",
        expected: "55\n55",
    },
    {
        name: test60,
        file: "test60.snek",
        expected: "1\n2\nfalse\nfalse",
    },
    {
        name: test61,
        file: "test61.snek",
        expected: "1\n2\n3\nfalse\nfalse",
    },
    {
        name: test62,
        file: "test62.snek",
        expected: "1\n3\n2\n3\n3\n3\n4\n3\n5\n3\n6",
    },
    {
        name: test63,
        file: "test63.snek",
        input: "10",
        expected: "55",
    },
    {
        name: test64,
        file: "test64.snek",
        input: "10",
        expected: "(vec 10 20 30 true)",
    },
    {
        name: test65,
        file: "test65.snek",
        input: "10",
        expected: "(vec 30 (vec true (vec 10)))",
    },
    {
        name: test66,
        file: "test66.snek",
        input: "10",
        expected: "(vec 10 20 (vec 30))",
    },
    {
        name: test67,
        file: "test67.snek",
        input: "-8",
        expected: "8",
    },
    {
        name: test68,
        file: "test68.snek",
        input: "-8",
        expected: "30\n30",
    },
    {
        name: test69,
        file: "test69.snek",
        input: "-8",
        expected: "(vec 3 6)",
    },
    {
        name: bst1,
        file: "bst.snek",
        input: "1",
        expected: "false\n(vec 30 (vec 10 (vec 5 (vec 2 (vec 1) (vec 0)) (vec 8)) (vec 11)) (vec 40))",
    }, 
    {
        name: bst2,
        file: "bst.snek",
        input: "37",
        expected: "false\n(vec 30 (vec 10 (vec 5 (vec 2) (vec 8)) (vec 11)) (vec 40 (vec 37) (vec 0)))",
    },
    {
        name: bst3,
        file: "bst.snek",
        input: "7",
        expected: "false\n(vec 30 (vec 10 (vec 5 (vec 2) (vec 8 (vec 7) (vec 0))) (vec 11)) (vec 40))",
    },
    {
        name: bst4,
        file: "bst.snek",
        input: "42",
        expected: "false\n(vec 30 (vec 10 (vec 5 (vec 2) (vec 8)) (vec 11)) (vec 40 (vec 0) (vec 42)))",
    },
    {
        name: points1,
        file: "points.snek",
        input: "3",
        expected: "(vec 4 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0))))) (vec 3 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0))))) (vec 2 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0))))) (vec 1 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0))))) (vec 0 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0))))))))))\n(vec 4 5)",
    },
    {
        name: points2,
        file: "points.snek",
        input: "-1",
        expected: "(vec 0 (vec 0))\n(vec 0 1)",
    },
    {
        name: points3,
        file: "points.snek",
        input: "4",
        expected: "(vec 5 (vec 5 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0)))))) (vec 4 (vec 5 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0)))))) (vec 3 (vec 5 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0)))))) (vec 2 (vec 5 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0)))))) (vec 1 (vec 5 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0)))))) (vec 0 (vec 5 (vec 4 (vec 3 (vec 2 (vec 1 (vec 0))))))))))))\n(vec 5 6)",
    },


}

runtime_error_tests! {
    {
        name: error_bounds,
        file: "error_bounds.snek",
        input: "10",
        expected: "bounds",
    },
    {
        name: error3,
        file: "error3.snek",
        input: "false",
        expected: "idx",
    },
    {
        name: error_tag,
        file: "error_tag.snek",
        input: "false",
        expected: "pointer",
    },
    {
        name: test6,
        file: "test6.snek",
        expected: "overflow error",
    },
    {
        name: test7,
        file: "test7.snek",
        expected: "overflow error",
    },
    {
        name: test12,
        file: "test12.snek",
        expected: "invalid argument",
    },
    {
        name: test43,
        file: "test43.snek",
        expected: "invalid argument",
    },
    {
        name: test44,
        file: "test44.snek",
        expected: "invalid argument",
    },
    {
        name: test45,
        file: "test45.snek",
        expected: "invalid argument",
    },
    

}

static_error_tests! {
    {
        name: duplicate_params,
        file: "duplicate_params.snek",
        expected: "Duplicate params",
    },
    {
        name: test15,
        file: "test15.snek",
        expected: "Unbound variable identifier x",
    },
    {
        name: test16,
        file: "test16.snek",
        expected: "break",
    },
    {
        name: test17,
        file: "test17.snek",
        expected: "keyword",
    },
    {
        name: test18,
        file: "test18.snek",
        expected: "keyword",
    },
    {
        name: test38,
        file: "test38.snek",
        expected: "Duplicate binding",
    },
    {
        name: test35,
        file: "test35.snek",
        expected: "keyword",
    },
    {
        name: test33,
        file: "test33.snek",
        expected: "Invalid",
    },
    {
        name: test41,
        file: "test41.snek",
        expected: "Unbound variable identifier",
    },
    {
        name: test48,
        file: "test48.snek",
        expected: "keyword",
    },
    {
        name: test49,
        file: "test49.snek",
        expected: "Input",
    },
    {
        name: test50,
        file: "test50.snek",
        expected: "arguments",
    },
    {
        name: test51,
        file: "test51.snek",
        expected: "Duplicate",
    },
    {
        name: test52,
        file: "test52.snek",
        expected: "break",
    },
    {
        name: test55,
        file: "test55.snek",
        expected: "Function",
    },
    {
        name: test56,
        file: "test56.snek",
        expected: "Function",
    },
}
