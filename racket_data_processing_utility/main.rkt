#lang racket

;; Main entry point for the data processing pipeline

(require "ingester.rkt"
         "transformer.rkt"
         "validator.rkt"
         "reporter.rkt")

(define (run-pipeline input-path output-path)
  (printf "Starting data processing pipeline...\n")
  
  ;; Ingest data
  (define raw-data (ingest-data input-path))
  (printf "Ingested ~a records\n" (length raw-data))
  
  ;; Validate data
  (define valid-data (validate-data raw-data))
  (printf "Validated ~a records\n" (length valid-data))
  
  ;; Transform data
  (define processed-data (transform-data valid-data))
  (printf "Transformed ~a records\n" (length processed-data))
  
  ;; Generate report
  (generate-report processed-data output-path)
  (printf "Report generated at: ~a\n" output-path))

;; Example usage
;; (run-pipeline "./input.csv" "./output.json")
