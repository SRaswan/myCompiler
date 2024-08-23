import os
import argparse
import subprocess
from fuzz import generate_default_tests

def run_test(file_path, input):
    print(f"Running {file_path} with input {input}")
    # Run the compiled Rust program
    process = subprocess.Popen([file_path, input], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    try:
        # if this returns, the process completed
        process.wait(timeout=3)
        stdout, stderr = process.communicate()
    except subprocess.TimeoutExpired:
        process.terminate()
        stdout, stderr = "", "Timeout: 3 seconds exceeded"
        

    # Extract the last line of the output
    lines = stdout.strip().split('\n')
    rust_error = stderr.strip()
    rust_output = lines[-1]
    if rust_error:
        rust_output = f"Error: {rust_error}"
    return rust_output, lines[:-1]
def run_verifier(directory, file_path, input):
    print(f"Verifying {file_path} with input {input}")
    # Copy file_path into tests/current_test.snek
    if os.path.exists(os.path.join(directory, "current_test.snek")):
        os.remove(os.path.join(directory, "current_test.snek"))
    with open(os.path.join(directory, "current_test.snek"), "w") as f:
        with open(file_path, "r") as f2:
            f.write(f2.read())
    # Run the checker program
    process = subprocess.Popen(["node", "src/checker.js", input], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    try:
        # if this returns, the process completed
        process.wait(timeout=3)
        stdout, stderr = process.communicate()
    except subprocess.TimeoutExpired:
        process.terminate()
        stdout, stderr = "", "Timeout: 3 seconds exceeded"
    # Extract the line of the output that contains the result
    lines = stdout.strip().split('\n')
    res = None
    for idx, line in enumerate(lines):
        if line.startswith("Result: "):
            res = line[len("Result: "):].strip()
            lines = lines[:idx] + lines[idx+1:]
            break
    if res is None:
        raise RuntimeError("Invalid output from checker")
    if stderr:
        res = f"Error: {stderr.strip()}"
    return res, lines
    

def compare_outputs(directory, num_programs, clear=False):
    subprocess.run(["make", "clean"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    generate_default_tests(directory, num_programs)
    for i in range(num_programs):
        diamond_file = os.path.join(directory, f"fuzz_{i}.snek")
            
        with open(diamond_file.replace(".snek", ".input"), 'r') as file:
            input = file.read()

        subprocess.run(["make", f"tests/fuzz_{i}.run"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        prog_out, prog_std = run_test(os.path.join(directory, f"fuzz_{i}.run"), input)
        checker_out, checker_std = run_verifier(directory, os.path.join(directory, f"fuzz_{i}.snek"), input)
        if (prog_out != checker_out and checker_out not in ["Invalid", "syntax", "compile", "type", "overflow"] and checker_out not in prog_out) or prog_std != checker_std:
            print(f"Test {i} failed")
            print(f"Program output: {prog_out}")
            print(f"Checker output: {checker_out}")
            print(f"Program stderr: {prog_std}")
            print(f"Checker stderr: {checker_std}")

    if clear:
        for i in range(num_programs):
            os.remove(os.path.join(directory, f"fuzz_{i}.snek"))
        os.remove(os.path.join(directory, "current_test.snek"))

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--clear", help="clear the generated tests after running", action="store_true")
    args = parser.parse_args()

    directory = "./tests/"
    num_programs = 100

    compare_outputs(directory, num_programs, args.clear)
    
    if(args.clear):
        subprocess.run(["make", "clean"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)