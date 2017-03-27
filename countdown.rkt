#lang racket
(define Smallset (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10))
(define Largeset (list 25 50 75 100))

;Function to generate the target number
(define (targetNum) (for ([i 1]) (displayln (random 101 999))))

(targetNum)

(struct number (int))
(define ints (list (number 1)
                   (number 2)
                   (number 3)))

(define sum 
  (λ (lst)
    (cond ((null? lst) 0)
          (else (+ (number-int (car lst))
                   (sum (cdr lst)))))))

(sum ints)
