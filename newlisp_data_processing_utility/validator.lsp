; validator.lsp - Data Validation Functions

(define (validate-data data)
  ; Checks for data integrity and constraints
  (if (empty? data)
    (begin
      (println "Error: Data is empty.")
      nil
    )
    (begin
      ; Example validation: Check if all numbers are positive
      (set 'negatives (remove (lambda (x) (number? x)) data))
      (if (and (empty? negatives)
               (empty? (filter (lambda (x) (< x 0)) (filter number? data))))
        true
        (begin
          (println "Error: Invalid data values detected.")
          nil
        )
      )
    )
  )
)
