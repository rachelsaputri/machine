; transformer.lsp - Data Transformation Functions

(define (transform-data data)
  ; Applies basic transformations to the data
  (set 'cleaned (remove nil (map (lambda (x) (if (equal? x "") nil x)) data)))
  (set 'uppercased (map upper (remove string (remove symbol cleaned))))
  (set 'numerified (map (lambda (x) (if (number? x) x (int x))) (remove string (remove symbol cleaned))))
  
  ; Combine cleaned strings and numerified numbers
  (append (remove number (remove string cleaned)) numerified)
)
