#lang racket

;; Module for transforming and cleansing data

(define (transform-data data)
  (cond
    [(list? data)
     (map transform-record data)]
    [else
     (error "Data must be a list")]))

(define (transform-record record)
  (cond
    [(hash? record)
     (transform-hash-record record)]
    [(list? record)
     (transform-list-record record)]
    [else
     record]))

(define (transform-hash-record record)
  (define transformed (hash-map record
                                (lambda (k v)
                                  (cons k (transform-value v)))))
  (hash-values transformed))

(define (transform-list-record record)
  (map transform-value record))

(define (transform-value value)
  (cond
    [(string? value)
     (string-trim value)]
    [(number? value)
     (inexact->exact (round value))]
    [else
     value]))

;; Example transformation rules
(define (apply-rules data rules)
  (map (lambda (record)
         (apply-record-rules record rules))
       data))

(define (apply-record-rules record rules)
  (foldl (lambda (rule acc)
           (rule acc))
         record
         rules))
