#lang racket

;; Module for generating reports and exporting data

(define (generate-report data output-path)
  (define report-content (format-report data))
  (define file-extension (get-file-extension output-path))
  
  (cond
    [(eq? file-extension 'json) (export-json report-content output-path)]
    [(eq? file-extension 'csv) (export-csv report-content output-path)]
    [(eq? file-extension 'txt) (export-txt report-content output-path)]
    [else (export-txt report-content output-path)]))

(define (format-report data)
  (let ([total (length data)])
    (format "~a records processed successfully" total)))

(define (export-json data output-path)
  (define json-string (pretty-format json))
  (with-output-to-file output-path
    #:exists 'replace
    (lambda ()
      (display json-string))))

(define (export-csv data output-path)
  (define csv-string (format "record_count,~a" (length data)))
  (with-output-to-file output-path
    #:exists 'replace
    (lambda ()
      (display csv-string))))

(define (export-txt data output-path)
  (with-output-to-file output-path
    #:exists 'replace
    (lambda ()
      (display data))))

(define (get-file-extension path)
  (let ([extension (last (string-split path "."))])
    (string->symbol extension)))
