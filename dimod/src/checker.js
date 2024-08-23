const { interpreter } = require('./diamondback');

function update(program, input) {
  try {
    let result = interpreter.run(program, input);
    return result;
  } catch (e) {
    // Ugh hacky
    e = JSON.stringify(e);
    let err;
    if (e.includes('Syntax'))
      err = "syntax";
    else if (e.includes('BadProgram'))
      err = "compile";
    else if (e.includes('Type'))
      err = "type";
    else if (e.includes('Overflow'))
      err = "overflow";
    else if (e.includes('Input'))
      err = "Invalid";
    else
      throw e;
    return err;
  }
}

const fs = require('node:fs');
var path = require('path');

var progPath = path.join(__dirname, "..", "tests", "current_test.snek");
if (!fs.existsSync(progPath)) {
    progPath = path.join(__dirname, "tests", "current_test.snek");
}
if (!fs.existsSync(progPath)) {
    console.error('Could not find current_test.snek');
    process.exit(1);
}
var program = fs.readFileSync(progPath, 'utf8');

let input = process.argv[2];


let result = update(program, input);
console.log('Result: ', result.trim());