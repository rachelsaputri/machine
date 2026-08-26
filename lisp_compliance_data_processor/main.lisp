(in-package :common-lisp)

;; Ensure packages are defined
(defpackage :compliance-data-processor
  (:use :common-lisp))

(in-package :compliance-data-processor)

;; Include other modules
(include "ingester.lisp")
(include "parser.lisp")
(include "transformer.lisp")
(include "validator.lisp")
(include "reporter.lisp")

;; Re-export main entry points
(defpackage :compliance-data-processor/main
  (:use :common-lisp
        :compliance-data-processor/ingester
        :compliance-data-processor/parser
        :compliance-data-processor/transformer
        :compliance-data-processor/validator
        :compliance-data-processor/reporter)
  (:export :run-pipeline
           :process-data-file))

(in-package :compliance-data-processor/main)

(defun run-pipeline (input-filepath output-filepath)
  "Main pipeline function."
  (format t "Starting Compliance Data Processing Pipeline...~%")
  
  ;; 1. Ingest
  (let ((raw-data (read-data-file input-filepath)))
    (format t "Ingested ~a records.~%" (length raw-data))
    
    ;; 2. Parse
    (let ((parsed-data (parse-batch raw-data)))
      (format t "Parsed ~a records.~%" (length parsed-data))
      
      ;; 3. Transform
      (let ((transformed-data (enrich-data parsed-data)))
        (format t "Transformed data.~%")
        
        ;; 4. Validate
        (multiple-value-bind (valid-records error-records)
            (validate-batch transformed-data)
          (format t "Validation complete.~%")
          
          ;; 5. Report
          (log-violations error-records)
          (generate-compliance-report valid-records error-records)
          (export-json-report valid-records output-filepath)
          
          (format t "Pipeline finished.~%"))))))

(defun process-data-file (input-file)
  "Convenience function to process a single file."
  (let ((output (concatenate 'string (pathname-name input-file) ".json")))
    (run-pipeline (namestring input-file) output)))

;; Main execution
(defvar *input-file* "data/input.csv")
(defvar *output-file* "output/report.json")

(defun main ()
  "Entry point."
  (run-pipeline *input-file* *output-file*))

;; Run if loaded directly
(when (equal (find-package :common-lisp) (find-package :compliance-data-processor/main))
  (main))
