# CountdownGame

|  Name |      Jason McTigue | 
|----------|:-------------:|
| Id Number|  G00312233 |
| Subject |    Theory Of Algorithms   | 
| Lecturer | Ian McLoughlin |
| Language | Racket |

## How to run
Download (Racket)[https://download.racket-lang.org/] and install it on your machine.

Open Dr.Racket 
Press Ctrl + R to to run the program
To calculate an RPN type an expression like (calculate-RPN '(3.0 4 2 * 1 5 - 2 3 ^ ^ / +))

####  **Rules**

- Players have to combine six selected numbers (using just the four basic arithmetic operators) to get as close as possible to a randomly generated total.

- Six numbers are randomly selected from two lists consisting of twenty-four numbers.

- There are two groups: Large Numbers and Small Numbers.

- There are four numbers in the large set { 25 , 50 , 75 , 100 }

- There are twenty numbers in the small set, two each of the numbers 1-10
{ 1 , 1 , 2 , 2 , 3 , 3 , 4 , 4 , 5 , 5 , 6 , 6 , 7 , 7 , 8 , 8 , 9 , 9 , 10 , 10 }

- The player selects as many numbers as desired (unseen) from the large set (between none and all four), and the balance are pulled from the small set to make six numbers in total.

- A random three-digit target number is then randomly generated.

- The player is then given 30 seconds to get as close as possible to the chosen target by using just the four basic arithmetic operators + - × ÷

- Not all the digits need to be used.

- Concatenation of the digits is not allowed (You can’t use a “2” and “2” to make “22”).

- At no intermediate step in the process can the current running total become negative or involve a fraction.

- Each number can only be used once in the calculation.

I found offcial rules [here](http://datagenetics.com/blog/august32014/index.html).


## Summary Of Project
This project is a version of the popular TV show Countdown written in the racket programming language.

The application is going to define a function that takes two arguments. The first argument takes a number between 101 and 999 inclusive. The second function will be a list of numbers, taken from the list of 24 numbers avaiable.

The function should return the target number and then be able to calculate an equation to reach the number or get as close as possible to the target number.

The use of a negative number or a fraction are not allowed.

## How I Developed the project

**Functions**

To start the project I first added two lists with the required numbers for the small and large sets according to the rules of the countdown game.

```racket
(define Smallset (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))
(define Largeset (list 25 50 75 100))
```

I then created a function that would generate a random number between 101 and 999 inclusive. To do this I used the random function using information that I found [here](https://docs.racket-lang.org/reference/generic-numbers.html#%28def._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._random%29%29) under section 4.2.2.7 Random Numbers.

```racket
(define (targetNum) (for ([i 1]) (displayln (random 101 999))))
```

I then added a gitignore file which I found [here](https://github.com/github/gitignore/pull/1616/files)

To check for all possibilities of two numbers I added a brute force method

```racket
(define a 5)
(define b 25)
(define t 125)

(define l(list (+ a b)
(+ b a)
(- a b)
(- b a)
(* a b)
(* b a)
(/ a b)
(/ b a)))

(list l)
```

The next step I tried was to implement Reverse Polish notation (RPN) to the project. RPN is a mathematical notation in which every operator follows all its operands, in contrast to Polish notation (PN), which puts the operator before its operands. It is also known as postfix notation. It does not need any parentheses if each operator has a fixed number of operands.

An example of a fix notation expression would be as follows:
```
5 + ((1 + 2) × 4) − 3

```

Can be written down like this in RPN:

```
5 1 2 + 4 × + 3 −
```

The difference between the RPN form and the infix form is simply that the operator is written after its two operands, rather than between
them.

How the expression is evaluated on the stack

| Input  | Action  | Stack  | Notes  |
|---|---|---|---|
| 5 |Operand   | 5 | Push onto stack  |
| 1 |Operand   | 1 5 | Push onto stack  |
| 2 |Operand   |  2 1 5 |  Push onto stack |
| + |Operand   |  3 5 | Pop the two operands (1, 2), calculate (1 + 2 = 3) and push onto stack.  |
| 4 |Operand   | 4 3 5  | Push onto stack.  |
| * |Operand   | 12 5  | Pop the two operands (3, 4), calculate (3 * 4 = 12) and push onto stack.  |
| + |Operand   | 17  |Pop the two operands (5, 12), calculate (5 + 12 = 17) and push onto stack.   |
| 3 |Operand   | 3 17  |  Push onto stack. |
| - |Operand  | 14  | Pop the two operands (17, 3), calculate (17 - 3 = 14) and push onto stack.  |
|   |Result  |  14 |   |

Example found [here](https://en.wikipedia.org/wiki/Reverse_Polish_notation)

The next step I done was to add all the notes from class to create a RPN function. I created a list that contained -1's and 1's. -1's represened the operators '+ - * /' and 1's represented the numbers. If I run the following function: 

```racket
(define start (list  -1 -1 -1 -1 1 1 1 1 1))
(permutations start)
```

It will create over 40 million combinations so for this reason you need to add the remove-duplicates function.

```racket
(define per8(remove-duplicates(permutations start)))
```
For RPN to work there needs to be at least two numbers on the stack before an operator is applied. To achieve this the following function is required:

```racket
(define (to-rpn l) (append (list 1 1) l (list -1)))
(car per8)
(to-rpn (car per8))
```
This adds two 1s to the front of the list and then adds a -1(opperator) to the end of the list. This assures that there are always two numbers and one operator on the stack.

Next I used the map functions which combines the RPN function and permutation function together.
```racket
(map to-rpn per8)
```

However these are not valid RNP expressions. To be valid the stack must meet the following two conditions 

1. There are at least two numbers on the stack
whenever an operator is read.

2. There is exactly one number on the stack
when the end of the expression is reached.

While these two conditions can be meet an expression like 1 2 3 + + + 4 5 + which starts with two numbers and ends in an operator is still invalid because when the third + symbol is read the stack has only a single item on it and the operator cannot be applied. To create a valid RPN the following function needs to be applied:

```racket
(define (valid-rpn? e (s 0))
  (if (null? e)
      (if (= s 1) #t #f);if there is one number on the stack return true
      (if (= (car e) 1)
          (valid-rpn? (cdr e) (+ s 1));adds one to the stack
      (if (< s 2)
          #f
          (#t)))))
```
This function first checks that there is a number on the stack. If there is one number on the stack it returns true if not it takes the car of the list and checks if it is a number or opp. Next the function adds one to the stack and checks to make sure s has at least two numbers else it returns false.

**Testing numbers and permutations**

The next thing I wanted to do was test all the permutations of a list of numbers and a list of operators.
```racket
(define nos(list 100 50 10 6 5 1))
(permutations nos)

(define ops ( list '+ '- '* '/))
(cartesian-product ops ops ops ops ops)
```

The last function I added into the project was an RPN calculator. The function is shown below:
```racket
(define (calculate-RPN expr)
  (for/fold ([stack '()]) ([token expr])
    (printf "~a\t -> ~a~N" token stack)
    (match* (token stack)
     [((? number? n) s) (cons n s)]
     [('+ (list x y s ___)) (cons (+ x y) s)]
     [('- (list x y s ___)) (cons (- y x) s)]
     [('* (list x y s ___)) (cons (* x y) s)]
     [('/ (list x y s ___)) (cons (/ y x) s)]
     [('^ (list x y s ___)) (cons (expt y x) s)]
     [(x s) (error "calculate-RPN: Cannot calculate the expression:" 
                   (reverse (cons x s)))])))
```

This works by inputting your equation eg (calculate-RPN '(3.0 4 2 * 1 5 - 2 3 ^ ^ / +)) and it will the calculate an answer as shown in the example below:

```
3.0	 -> ()
4	 -> (3.0)
2	 -> (4 3.0)
*	 -> (2 4 3.0)
1	 -> (8 3.0)
5	 -> (1 8 3.0)
-	 -> (5 1 8 3.0)
2	 -> (-4 8 3.0)
3	 -> (2 -4 8 3.0)
^	 -> (3 2 -4 8 3.0)
^	 -> (8 -4 8 3.0)
/	 -> (65536 8 3.0)
+	 -> (1/8192 3.0)
'(3.0001220703125)
```

