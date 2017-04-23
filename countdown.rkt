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

(define l(list (+ a b)
(+ b a)
(- a b)
(- b a)
(* a b)
(* b a)
(/ a b)
(/ b a)))

(list l)


;Reverse polish notation from class
;(define start (list  -1 -1 -1 -1 1 1 1 1 1))
(define start (list  '+ '- '* '/ 1 1 1 1 1))


;This function removes duplicates from the list
(define per8(remove-duplicates(permutations start)))

;two 1s are added to the front of the list and then a -1 is added to the  end of the list
(define (to-rpn l) (append (list 1 1) l (list '+ '- '* '/)))
(car per8)

(to-rpn (car per8))

;Takes all arangements with 2 numbers at the start
(map to-rpn per8)


(define (valid-rpn? e (s 0)) ;default value is 0
  (if (null? e)
      (if (= s 1) #t #f);if there is one number on the stack return true
      ;if not take car of the list and check if it is a number or opp.
      (if (= (car e) 1)
          (valid-rpn? (cdr e) (+ s 1));adds one to the stack
      ;checks to make sure s has at least two numbers else return false
      (if (< s 2)
          #f
          (#t)))))

;test
(define nos(list 100 50 10 6 5 1))
(permutations nos)

(define ops ( list '+ '- '* '/))
(cartesian-product ops ops ops ops ops)

;(calculate-RPN '(3.0 4 2 * 1 5 - 2 3 ^ ^ / +)) https://rosettacode.org/wiki/Parsing/RPN_calculator_algorithm#Racket
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




