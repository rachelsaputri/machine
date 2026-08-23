; parser.lsp - Data Parsing Functions

(define (parse-input data)
  ; Converts raw string or list data into a structured list
  (if (string? data)
    (split data " ")
    (if (list? data)
      data
      (list data)
    )
  )
)

(define (normalize-parsed-data data-list)
  ; Ensures all elements are strings or numbers
  (map (lambda (item)
         (if (float? item)
           (round item)
           item
         )
       )
       data-list
  )
)
