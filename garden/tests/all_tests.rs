mod infra;

// Your tests go here!
success_tests! {
    {
        name: make_vec_succ,
        file: "make_vec.snek",
        input: "5",
        expected: "[0, 0, 0, 0, 0]",
    },
    {
        name: vec_succ,
        file: "vec.snek",
        expected: "[0, 1, 2, 3]",
    },
    {
        name: vec_get_succ,
        file: "vec_get.snek",
        input: "3",
        expected: "3",
    },
    {
        name: linked_list_manipulations,
        file: "linked_list_manipulations.snek",
        expected: "1\n2\n3\n4\n5\n5\n4\n3\n2\n1\nnil"
    },
    {
        name: test1,
        file: "test1.snek",
        input: "3",
        heap_size: 15,
        expected: "[nil, [1, 2], nil]"
    },
    {
        name: test2,
        file: "test2.snek",
        input: "1",
        heap_size: 123,
        expected: "0"
    },
    {
        name: test4,
        file: "test4.snek",
        input: "0",
        heap_size: 700,
        expected: "0"
    },
    {
        name: test5,
        file: "test5.snek",
        input: "0",
        heap_size: 700,
        expected: "0"
    },
    {
        name: test6,
        file: "test6.snek",
        input: "0",
        heap_size: 700,
        expected: "[[], 0]"
    },
    {
        name: test7,
        file: "test7.snek",
        input: "0",
        heap_size: 700,
        expected: "[[], 0]"
    },
    {
        name: test8,
        file: "test8.snek",
        input: "10",
        heap_size:36,
        expected:"[[[[[[...], 7], 4], 3], 6], 2]\n[[[[[[[...], 7], 4], 3], 6], 2], 888, 888, 888, 888, 888, 888, 888, 888, 888]"
    }

}

runtime_error_tests! {
    {
        name: make_vec_oom,
        file: "make_vec.snek",
        input: "5",
        heap_size: 5,
        expected: "out of memory",
    },
    {
        name: vec_get_oob,
        file: "vec_get.snek",
        input: "5",
        expected: "",
    },
    {
        name: test3,
        file: "test3.snek",
        input: "5",
        heap_size: 3,
        expected: "out of memory"
    },
}

static_error_tests! {}
