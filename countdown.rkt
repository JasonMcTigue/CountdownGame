#lang racket
(define Smallset (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))
(define Largeset (list 25 50 75 100))

;Function to generate the target number
(define (targetNum) (for ([i 1]) (displayln (random 101 999))))

(targetNum)