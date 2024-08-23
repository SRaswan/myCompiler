import random, re
from sexpdata import dumps, Symbol
import os
# p_array = [p_input, p_unary, p_binary, p_let, p_block, p_break, p_loop, p_set, p_call]

def generate_diamondback_program(identifiers, num_bindings_range, max_depth, p_array, p_leaf, allow_break_outside_loop):
    funcs = []
    defs = []
    def generate_funcs(func_names, identifiers, max_params, max_depth, input_type):
        for idx, func_name in enumerate(func_names):
            num_params = random.randint(0, max_params)
            param_types = ['num'] + [random.choice(['num', 'bool']) for _ in range(num_params)]
            
            if idx == 0:
                    return_type = 'num'
            elif idx == 1:
                return_type = 'bool'
            else:
                return_type = random.choice(['num', 'bool'])
            funcs.append((func_name, param_types, return_type))
        for idx, func_name in enumerate(func_names):
            num_params = len(funcs[idx][1]) - 1
            param_names = random.sample(identifiers, num_params)
            func_params = [Symbol('energy'), *[Symbol(param_names[i]) for i in range(num_params)]]
            func_body, _ = generate_expression(max_depth, [('energy', 'num'), *[x for x in zip(param_names, funcs[idx][1])]], 3, funcs[idx][2], input_type, 'energy')
            if_body = [Symbol('block'), [Symbol('set!'), Symbol('energy'), [Symbol('-'), Symbol('energy'), 1]], func_body]
            if_expr = [Symbol('if'), [Symbol('<='), Symbol('energy'), 0], random.randint(-100, 100) if funcs[idx][2] == 'num' else Symbol(random.choice(["true", "false"])), if_body]
            defs.append([Symbol('fun'), [Symbol(func_name), *func_params], if_expr])


    def generate_terminating_loop(depth, current_identifiers, loop_depth, expr_type, input_type):
        loop_iters = random.randint(1, 200)
        loop_var = f"loop_var_{loop_iters}"
        start_value, start_type = generate_expression(min(1, depth - 1), current_identifiers, loop_depth + 3, 'num', input_type)

        if random.random() < 0.5:
            end_value, end_type = [Symbol('+'), start_value, loop_iters], 'num'
            # Increment loop variable
            loop_condition = [Symbol('<'), Symbol(loop_var), end_value]
            set_expr = [Symbol('+'), Symbol(loop_var), 1]
        else:
            end_value, end_type = [Symbol('-'), start_value, loop_iters], 'num'
            # Decrement loop variable
            loop_condition = [Symbol('>'), Symbol(loop_var), end_value]
            set_expr = [Symbol('-'), Symbol(loop_var), 1]

        block_body = [[Symbol('set!'), Symbol(loop_var), set_expr]]

        if random.random() < 0.5 and current_identifiers != []:
            # Add additional set statements to the block
            num_sets = random.randint(1, 3)
            for _ in range(num_sets):
                set_var = random.choice(current_identifiers)
                set_value, set_type = generate_expression(depth - 1, current_identifiers, loop_depth + 3, expr_type, input_type)
                block_body.append([Symbol('set!'), Symbol(set_var[0]), set_value])

        if random.random() < 0.5:
            # Add additional expressions to the block
            num_exprs = random.randint(1, 3)
            for _ in range(num_exprs):
                expr, _ = generate_expression(depth - 1, current_identifiers, loop_depth + 3, expr_type, input_type)
                block_body.append(expr)

        break_expr, break_type = generate_expression(depth - 1, current_identifiers + [(loop_var, 'num')], loop_depth + 3, expr_type, input_type)

        loop_body = [Symbol('if'), loop_condition,
                     [Symbol('block'), *block_body],
                     [Symbol('break'), break_expr]]

        inner_loop = [Symbol('loop'), loop_body]

        if random.random() < 0.3 and loop_depth < 3:
            # Nest the loop inside another loop
            inner_loop, _ = generate_terminating_loop(depth, current_identifiers, loop_depth + 1, expr_type, input_type)

        let_bindings = [[Symbol(loop_var), start_value]]
        let_body = inner_loop

        return [Symbol('let'), let_bindings, let_body], expr_type
    def generate_expression(depth, current_identifiers, loop_depth, expr_type, input_type, energy = None):
        if depth <= 0 or (depth > 0 and random.random() < p_leaf):
            if random.random() < p_array[0] and expr_type == input_type:
                return Symbol('input'), input_type
            elif expr_type == 'num':
                if random.random() < 0.5:
                    num_identifiers = [identifier for identifier, identifier_type in current_identifiers if identifier_type == 'num']
                    return random.choice(num_identifiers) if num_identifiers != [] else random.randint(-100, 100), 'num'
                return random.randint(-100, 100), 'num'
            elif expr_type == 'bool':
                if random.random() < 0.5:
                    bool_identifiers = [identifier for identifier, identifier_type in current_identifiers if identifier_type == 'bool']
                    return random.choice(bool_identifiers) if bool_identifiers != [] else Symbol(random.choice(["true", "false"])), 'bool'
                return Symbol(random.choice(["true", "false"])), 'bool'
            else:
                if random.random() < 0.5:
                    return random.randint(-100, 100), 'num'
                else:
                    return Symbol(random.choice(["true", "false"])), 'bool'

        if random.random() < p_array[1]:
            if expr_type == 'bool':
                op = random.choice(['isnum', 'isbool'])
                sub_expr_type = 'bool'
            elif expr_type == 'num':
                op = random.choice(['add1', 'sub1'])
                sub_expr_type = 'num'
            else:
                op = random.choice(['add1', 'sub1', 'isnum', 'isbool']) 
                sub_expr_type = random.choice(['error', 'num', 'bool'])
            sub_expr, _ = generate_expression(depth - 1, current_identifiers, loop_depth, sub_expr_type, input_type)
            if op == 'isnum':
                return [Symbol(op), sub_expr], 'bool'
            elif op == 'isbool':
                return [Symbol(op), sub_expr], 'bool'
            else:
                return [Symbol(op), sub_expr], 'num'

        elif random.random() < p_array[1] + p_array[2]:
            if expr_type == 'error':
                op = random.choice(['+', '-', '*', '<', '>', '>=', '<=', '='])
                sub_type1 = random.choice(['num', 'bool'])
                sub_type2 = random.choice(['num', 'bool'])
            else:
                if expr_type == 'num':
                    op = random.choice(['+', '-', '*'])
                else:
                    op = random.choice(['<', '>', '>=', '<=', '='])
                sub_type1 = 'num' if op != '=' else random.choice(['num', 'bool'])
                sub_type2 = sub_type1

            sub_expr1, _ = generate_expression(depth - 1, current_identifiers, loop_depth, sub_type1, input_type)
            sub_expr2, _ = generate_expression(depth - 1, current_identifiers, loop_depth, sub_type2, input_type)

            if op in ['+', '-', '*']:
                return [Symbol(op), sub_expr1, sub_expr2], 'num'
            else:
                return [Symbol(op), sub_expr1, sub_expr2], 'bool'

        elif random.random() < p_array[1] + p_array[2] + p_array[3]:
            num_bindings = random.randint(*num_bindings_range)
            bindings = []
            new_identifiers = current_identifiers[:]
            chosen_identifiers = []

            for _ in range(num_bindings):
                if len(chosen_identifiers) == len(identifiers):
                    break
                identifier = random.choice(list(set(identifiers) - set(chosen_identifiers)))
                chosen_identifiers.append(identifier)
                sub_expr, sub_type = generate_expression(depth - 1, new_identifiers, loop_depth, random.choice(['num', 'bool']), input_type)
                new_identifiers.append((identifier, sub_type))
                bindings.append([Symbol(identifier), sub_expr])

            body_expr, body_type = generate_expression(depth - 1, new_identifiers, loop_depth, expr_type, input_type)

            return [Symbol('let'), bindings, body_expr], body_type
        
        elif random.random() < sum(p_array[:4]):
            num_exprs = random.randint(1, 5)
            exprs = []
            for i in range(num_exprs):
                if i == num_exprs - 1:
                    sub_expr, sub_type = generate_expression(depth - 1, current_identifiers, loop_depth, expr_type, input_type)
                elif expr_type != 'error':
                    sub_expr, sub_type = generate_expression(depth - 1, current_identifiers, loop_depth, random.choice(['num', 'bool']), input_type)
                else:
                    sub_expr, sub_type = generate_expression(depth - 1, current_identifiers, loop_depth, random.choice(['error', 'num', 'bool']), input_type)
                exprs.append(sub_expr)
            return [Symbol('block'), *exprs], expr_type

        elif allow_break_outside_loop and random.random() < sum(p_array[:5]):
            sub_expr, sub_type = generate_expression(depth - 1, current_identifiers, loop_depth, expr_type, input_type)
            return [Symbol('break'), sub_expr], sub_type
        
        elif random.random() < sum(p_array[:6]) and loop_depth < 3:
            # Generate a loop expression
            loop_expr, loop_type = generate_terminating_loop(depth - 1, current_identifiers, loop_depth + 1, expr_type, input_type)
            return loop_expr, loop_type
        elif random.random() < sum(p_array[:7]) and current_identifiers != []:
            # Generate a set expression
            set_var = random.choice(current_identifiers)
            set_expr, set_type = generate_expression(depth - 1, current_identifiers, loop_depth, expr_type, input_type)
            return [Symbol('set!'), Symbol(set_var[0]), set_expr], set_type
        elif random.random() < sum(p_array[:8]):
            # Generate a function call
            func_name, param_types, _  = random.choice([x for x in funcs if x[2] == expr_type or expr_type == 'error'])
            
            call_args = []
            for idx,param_type in enumerate(param_types):
                if idx == 0 and energy is not None:
                    arg_expr = Symbol(energy)
                else:
                    arg_expr, _ = generate_expression(depth - 1, current_identifiers, loop_depth, param_type, input_type)
                call_args.append(arg_expr)
            
            return [Symbol(func_name), *call_args], random.choice(['num', 'bool'])
        else:
            cond_expr, _ = generate_expression(depth - 1, current_identifiers, loop_depth, random.choice(['bool', 'num']), input_type)
            then_expr, then_type = generate_expression(depth - 1, current_identifiers, loop_depth, expr_type, input_type)
            else_expr, else_type = generate_expression(depth - 1, current_identifiers, loop_depth, expr_type, input_type)
            return [Symbol('if'), cond_expr, then_expr, else_expr], expr_type
    input_type = random.choice(['num', 'bool'])
    names = ["our_code_starts_here", "main", "fun1", "fun2", "fun3", "fun4", "fun5", "fun6", "fun7", "fun8", "fun9", "fun10"]
    generate_funcs(names[:random.randint(2,11)], identifiers, 8, max_depth // 2, input_type)
    expr = generate_expression(max_depth, [], 0, random.choice(['num', 'bool', 'error']), input_type)[0]
    return dumps(expr), input_type, [dumps(x) for x in defs]

def generate_and_save_programs(directory, num_programs, identifiers, num_bindings_range, max_depth, p_array, p_leaf, allow_break_outside_loop):
    os.makedirs(directory, exist_ok=True)
    for i in range(num_programs):
        program, input_type, defs = generate_diamondback_program(identifiers, num_bindings_range, max_depth, p_array, p_leaf, allow_break_outside_loop)
        file_name = os.path.join(directory, f"fuzz_{i}.snek")
        with open(file_name, 'w') as file:
            for func in defs:
                input_replacement = random.randint(-100, 100) if input_type == 'num' else random.choice(["true", "false"])
                func = re.sub('input', str(input_replacement), func)
                file.write(func)
                file.write("\n")
            file.write(program)
        with open(file_name.replace(".snek", ".input"), 'w') as file:
            if input_type == 'num':
                file.write(str(random.randint(-100, 100)))
            else:
                file.write(str(random.choice(["true", "false"])))
            
def generate_default_tests(directory = "./tests/", num_programs = 100):
    # Example usage
    identifiers = ['x', 'y', 'z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
    num_bindings_range = (1, 3)
    max_depth = 8
    p_leaf = 0.1
    p_unary = 0.1
    p_binary = 0.2
    p_let = 0.1
    p_input = 0.05
    p_break = 0.02
    p_set = 0.05
    p_block = 0.04
    p_loop = 0.05
    p_call = 0.1
    allow_break_outside_loop = random.random() < 0.05
    
    generate_and_save_programs(directory, num_programs, identifiers, num_bindings_range, max_depth, [p_input, p_unary, p_binary, p_let, p_block, p_break, p_loop, p_set, p_call], p_leaf, allow_break_outside_loop)
    
    