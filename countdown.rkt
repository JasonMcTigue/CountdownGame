#lang racket
(define Smallset (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))
(define Largeset (list 25 50 75 100))

;Function to generate the target number
(define (targetNum) (for ([i 1]) (displayln (random 101 999))))

(targetNum)


;Brute force method for calculating all possibilities of two numbers
(define a 5)
(define b 25)
(define t 125)

(+ a b)
(+ b a)
(- a b)
(- b a)
(* a b)
(* b a)
(/ a b)
(/ b a)


;Reverse polish notation from class
(define start (list  -1 -1 -1 -1 1 1 1 1 1))

(define per8(remove-duplicates(permutations start)))

(define (to-rpn l) append (list 1 1) l (list -1))
(car per8)
(to-rpn (car per8))

(map to-rpn per8)









