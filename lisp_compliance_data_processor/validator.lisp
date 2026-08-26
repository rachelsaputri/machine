(in-package :compliance-data-processor)

(defpackage :compliance-data-processor/validator
  (:use :common-lisp)
  (:export :validate-record
           :validate-batch
           :check-policy-compliance))

(in-package :compliance-data-processor/validator)

(defparameter *required-fields* '(:id :timestamp :action :user :status))
(defparameter *valid-actions* '("LOGIN" "LOGOUT" "DATA_ACCESS" "DATA_EXPORT" "ADMIN_ACTION"))

(defun validate-record (record)
  "Validates a single record against schema and policy rules."
  (let ((errors '()))
    ;; Check required fields
    (dolist (field *required-fields*)
      (unless (getf record field)
        (push (format nil "Missing required field: ~a" field) errors)))
    
    ;; Check valid actions
    (let ((action (getf record :action)))
      (when action
        (unless (member action *valid-actions* :test #'string-equal)
          (push (format nil "Invalid action: ~a" action) errors))))
    
    (if errors
        (values nil errors)
        (values t '()))))

(defun validate-batch (records)
  "Validates a batch of records."
  (let ((valid-records '())
        (error-records '()))
    (dolist (record records)
      (multiple-value-bind (is-valid errors)
          (validate-record record)
        (if is-valid
            (push record valid-records)
            (push (list :record record :errors errors) error-records))))
    (values (reverse valid-records) (reverse error-records))))

(defun check-policy-compliance (record)
  "Checks if a record violates specific compliance policies."
  (let ((violations '()))
    (when (and (equal (getf record :action) "DATA_EXPORT")
               (not (equal (getf record :status) "AUTHORIZED")))
      (push "Unauthorized data export attempt" violations))
    (values violations))
