#lang racket
(require "mode.rkt")

;; -----------------------------
;; Tokenize user input
;; -----------------------------
(define (tokenize input)
  (filter (λ (x) (not (string=? x "")))
          (regexp-split #px"\\s+" input)))

;; -----------------------------
;; Helpers
;; -----------------------------
(define (parse-number tok)
  (let ([n (string->number tok)])
    (if n
        n
        (error 'invalid-token))))

(define (history-ref-by-id hist id)
  (if (and (integer? id) (>= id 1) (<= id (length hist)))
      ;; history id 1 is the first result ever produced
      (list-ref (reverse hist) (sub1 id))
      (error 'bad-history)))

;; -----------------------------
;; Recursive prefix evaluator
;; Returns: (list value remaining-tokens)
;; -----------------------------
(define (eval-expr tokens history)
  (cond
    [(null? tokens) (error 'invalid-expr)]
    [else
     (define token (car tokens))
     (define rest  (cdr tokens))
     (cond
       ;; Addition
       [(string=? token "+")
        (define r1 (eval-expr rest history))
        (define r2 (eval-expr (second r1) history))
        (list (+ (first r1) (first r2)) (second r2))]

       ;; Multiplication
       [(string=? token "*")
        (define r1 (eval-expr rest history))
        (define r2 (eval-expr (second r1) history))
        (list (* (first r1) (first r2)) (second r2))]

       ;; Integer Division (error on divide by zero)
       [(string=? token "/")
        (define r1 (eval-expr rest history))
        (define r2 (eval-expr (second r1) history))
        (define den (first r2))
        (if (zero? den)
            (error 'div-by-zero)
            (list (quotient (first r1) den) (second r2)))]

       ;; Unary Negation
       [(string=? token "-")
        (define r (eval-expr rest history))
        (list (- (first r)) (second r))]

       ;; History reference: $n
       [(regexp-match #px"^\\$[0-9]+$" token)
        (define idx (string->number (substring token 1)))
        (list (history-ref-by-id history idx) rest)]

       ;; Numeric literal
       [else
        (list (parse-number token) rest)])]))

;; -----------------------------
;; Printing helper (real->double-flonum for output only)
;; -----------------------------
(define (print-result id value)
  (displayln (format "~a: ~a" id (real->double-flonum value))))

;; -----------------------------
;; Interactive / Batch REPL
;; -----------------------------
(define (repl history)
  (when prompt? (display "> "))
  (flush-output)
  (define input (read-line))
  (cond
    [(or (eof-object? input) (and (string? input) (string=? input "quit")))
     (void)] ; exit
    [else
     (with-handlers ([exn:fail?
                      (λ (e)
                        (displayln "Error: Invalid Expression")
                        (repl history))])
       (define tokens (tokenize input))
       (define result+rest (eval-expr tokens history))
       (define value (first result+rest))
       (define remaining (second result+rest))
       (if (null? remaining)
           (begin
             (print-result (add1 (length history)) value)
             ;; store original exact value in history (not the printed flonum)
             (repl (cons value history)))
           (begin
             (displayln "Error: Invalid Expression")
             (repl history))))]))

;; -----------------------------
;; Program Entry
;; -----------------------------
(repl '())
