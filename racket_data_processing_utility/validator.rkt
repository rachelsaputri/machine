#lang racket

;; Module for validating data against rules

(define (validate-data data)
  (define valid-records '())
  (define errors '())
  
  (for ([record data])
    (let ([result (validate-record record)])
      (if (eq? result 'valid)
          (set! valid-records (append valid-records (list record)))
          (set! errors (append errors (list record))))))
  
  (printf "Validation complete:\n")
  (printf "  Valid: ~a records\n" (length valid-records))
  (printf "  Invalid: ~a records\n" (length errors))
  
  valid-records)

(define (validate-record record)
  (cond
    [(empty? record) 'invalid]
    [else 'valid]))

(define (validate-schema record schema)
  (define required-fields (hash-keys schema))
  (define missing-fields (filter (lambda (field) 
                                   (not (hash-has-key? record field)))
                                 required-fields))
  
  (if (empty? missing-fields)
      'valid
      (list 'missing-fields missing-fields)))

(define (validate-format value format-type)
  (cond
    [(eq? format-type 'integer) (integer? value)]
    [(eq? format-type 'float) (real? value)]
    [(eq? format-type 'string) (string? value)]
    [else #t]))
