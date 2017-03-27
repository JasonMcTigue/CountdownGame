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
....

## How it works

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

Functions

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