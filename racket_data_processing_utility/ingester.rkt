#lang racket

;; Module for ingesting data from various sources

(define (ingest-data file-path)
  (cond
    [(string-suffix? file-path ".csv") (ingest-csv file-path)]
    [(string-suffix? file-path ".json") (ingest-json file-path)]
    [(string-suffix? file-path ".txt") (ingest-txt file-path)]
    [else (error "Unsupported file format")]))

(define (ingest-csv file-path)
  (define lines (file->lines file-path))
  (if (null? lines)
      '()
      (let* ([header (string-split (first lines) ",")]
             [rows (rest lines)])
        (map (lambda (row)
               (hashify header (string-split row ",")))
             rows))))

(define (ingest-json file-path)
  (define json-string (file->string file-path))
  (define json-data (json->xexpr json-string))
  (xexpr->list json-data))

(define (ingest-txt file-path)
  (map string-trim (file->lines file-path)))

(define (hashify keys values)
  (let loop ([keys keys] [values values] [result '()])
    (cond
      [(or (null? keys) (null? values)) (reverse result)]
      [else (loop (rest keys)
                  (rest values)
                  (cons (make-cons (first keys) (first values))
                        result))])))

(define (make-cons key val)
  (cons key val))

(define (xexpr->list xexpr)
  ;; Simplified conversion for demonstration
  (list (cons 'data xexpr)))
