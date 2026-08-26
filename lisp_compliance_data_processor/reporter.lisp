(in-package :compliance-data-processor)

(defpackage :compliance-data-processor/reporter
  (:use :common-lisp)
  (:export :generate-compliance-report
           :export-json-report
           :log-violations))

(in-package :compliance-data-processor/reporter)

(defun log-violations (error-records)
  "Logs violations found during validation."
  (format t "~%=== VIOLATIONS LOG ===~%")
  (dolist (error-record error-records)
    (format t "Record: ~a~%" (getf error-record :record))
    (dolist (err (getf error-record :errors))
      (format t "  Error: ~a~%" err))
    (format t "---~%"))
  (format t "Total Violations: ~a~%" (length error-records)))

(defun generate-compliance-report (valid-records error-records)
  "Generates a summary report."
  (let ((total (length valid-records))
        (errors (length error-records))
        (clean total))
    (format t "~%=== COMPLIANCE REPORT ===~%")
    (format t "Total Records Processed: ~a~%" (+ total errors))
    (format t "Valid Records: ~a~%" total)
    (format t "Violations/Error Records: ~a~%" errors)
    (format t "Compliance Rate: ~,2f%~%" 
            (if (= (+ total errors) 0)
                100
                (/ (* 100 clean) (+ total errors)))))
    valid-records)

(defun export-json-report (valid-records filename)
  "Exports valid records to a JSON file. (Pseudo-code for JSON)
   Requires a JSON library like alexandria or cl-json in a real implementation."
  (with-open-file (stream filename :direction :output :if-exists :supersede)
    (format stream "[{~%")
    (loop for i from 0 below (length valid-records)
          for record = (nth i valid-records)
          do (format stream "  {~a}" record)
             (when (< i (- (length valid-records) 1))
               (format stream ",~%")))
    (format stream "~%}]"))
  (format t "Report exported to ~a~%" filename))
