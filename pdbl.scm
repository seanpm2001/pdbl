;;; Interpreter for P", the language for simulation of a Turing machine with
;;; left-infinite tape developed by Corrado Böhm in 1964.
;;;
;; Copyright 2017 Matthew Lavin
;;
;; This program utilizes the lalr-scm parser generation library, which is free
;; software licensed under the GNU LGPL.
;;

(load "lalr-scm/lalr.scm")

(define *tape* #())	; Tape operated on by the machine
(define *pos* 0)	; Current position of tape head
(define *state* 's1)	; Current state of machine

(define (setup tape pos state)
  (set! *tape* tape)
  (set! *pos* pos)
  (set! *state* state))

(define (set-state! state)
  (set! *state* state))

(define (set-pos! pos)
  (set! *pos* pos))

(define (movl)
  (set! *pos* (- *pos* 1)))

(define (movr)
  (set! *pos* (+ *pos* 1)))

(define (write out)
  (vector-set! *tape* *pos* out))

(define (read)
  (vector-ref *tape* *pos*))

(define (neq a b)
  (not (= a b)))

; Increment square & move head left
(define (lambda-operator)
  (write (+ (read) 1))
  (movl))

(define (while-tape func)
  (while (neq (read) 0)
	 (func)))

; Some example input to work with
(define tape1
  (list->vector '(1 1 1 1 0 _ _ _)))

(setup tape1 0 's1)

(newline)
(do ()
  ((not (= (read) 1)))
  (format #t "~d" (read))
  (newline)
  (movr))
