; main.lsp - NewLISP Data Processing Utility

(include "parser.lsp")
(include "transformer.lsp")
(include "validator.lsp")
(include "reporter.lsp")

(define (process-data raw-data)
  ; Step 1: Parse the raw input
  (set 'parsed-data (parse-input raw-data))
  
  ; Step 2: Transform the parsed data
  (set 'transformed-data (transform-data parsed-data))
  
  ; Step 3: Validate the transformed data
  (if (validate-data transformed-data)
    (begin
      ; Step 4: Report on success
      (generate-report transformed-data)
      (println "Data processed successfully.")
      transformed-data
    )
    (begin
      ; Report on failure
      (generate-error-report transformed-data)
      (println "Data validation failed.")
      nil
    )
  )
)

(define (main)
  (set 'sample-data '("raw" "data" "entry" 1 2 3))
  (println "Starting Data Processing...")
  (process-data sample-data)
)

; Execute main if run directly
(main)
