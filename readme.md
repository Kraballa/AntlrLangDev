# GScript scripting language
'GScript' (gamescript) is a simplistic interpreted (for now) dynamically typed (for now) programming language. It was created using the parser generator Antlr. I may potentially use it in future games which is why it's called 'gamescript'. The main purpose of this project is the study of programming language design and development.

## Features
- 4 types: int, float, string, bool
- functions, both native (defined inside gamescript), and external (callback to csharp)
- scoped variables, name overloading and parameter overloading with a `global` keyword
- nested functions, function scoping and overloading

## Missing Features
- no array types
- dynamic typing by virtue of not storing type data. in the near future we'll have static typing.

## Code Examples
For a lot of code check `testscript.txt`, it contains the entire test suite with which the language is validated. Here are some smaller code examples.

### Scoping Behavior
To sum up the above, you can do this:

```
function assert(ojb){
    if(!obj){
        print("error, assertion failed");
    }
}

test = 0;
function testA(test){
    assert(test == 1);
    assert(global.test == 0);

    function testB(test){
        assert(test == 2);
        assert(global.test == 0);
    }
    testB(2);
}
testA(1);
```

None of the above is crazy, the goal is just to achieve parity with csharp and many other programming languages in terms of overloading/scoping behavior.

### Random function
Dice roll example making use of the external `rand()` function:
```
roll = (rand()*6)|int;
```

### Operator Precedence
Operator precedence and boolean logic work as expected.
```
[...]
assert(true);
assert(!false);
assert(true | false);
assert(!(true & false));
assert(true | false & false); //fails if and/or precedence faulty

assert(1);
assert(-1+2);
assert(0.001);
```

### Power Function
```
[...]
function pow(val, power){
    power = power|int;
    ret = 1;
    i = 0;
    while(i < power){
        ret = ret * val;
        i = i+1;
    }
    return ret;
}

assert(pow(4,0) == 1);
assert(pow(4,1) == 4);
assert(pow(4,2) == 16);
assert(pow(4,3) == 64);
```