(in-package :compliance-data-processor)

(defpackage :compliance-data-processor/transformer
  (:use :common-lisp)
  (:export :apply-compliance-rules
           :normalize-fields
           :enrich-data))

(in-package :compliance-data-processor/transformer)

(defun normalize-fields (record)
  "Normalizes field values (e.g., timestamps, casing)."
  (let ((new-record record))
    ;; Normalize status
    (setf (getf new-record :status) 
          (string-upcase (getf record :status)))
    ;; Normalize user
    (setf (getf new-record :user) 
          (string-downcase (getf record :user)))
    new-record))

(defun apply-compliance-rules (record)
  "Applies specific compliance transformation rules."
  (let ((rule-applied nil))
    (cond
      ((equal (getf record :action) "LOGIN")
       (setf rule-applied t)
       (setf (getf record :priority) :high))
      ((equal (getf record :action) "DATA_EXPORT")
       (setf rule-applied t)
       (setf (getf record :priority) :critical)))
      (t
       (setf (getf record :priority) :normal)))
    (values record rule-applied)))

(defun enrich-data (records)
  "Enriches the data batch with calculated fields."
  (loop for record in records
        collect (multiple-value-bind (rec applied)
                    (apply-compliance-rules record)
                  rec)))
