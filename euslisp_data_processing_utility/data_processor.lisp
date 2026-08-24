;; EusLisp Data Processing Utility
;; This module provides core functions for data ingestion, transformation, validation, and reporting.

(in-package :user)

;; Define a generic structure for data records to ensure consistent processing
(defstruct data-record
  id
  timestamp
  category
  payload
  status)

;; Function to simulate data ingestion from a source (e.g., list of raw data)
(defun ingest-data (raw-data)
  "Ingests raw data and converts it into data-record structures."
  (let ((records nil))
    (loop for item in raw-data do
      (let ((id (gensym "RECORD-")))
        (push (make-data-record
               :id id
               :timestamp (get-universal-time)
               :category (car item)
               :payload (cadr item)
               :status :pending)
              records)))
    (nreverse records)))

;; Function to validate data records
(defun validate-data (records)
  "Validates a list of data-record structures."
  (let ((valid-records nil) (invalid-count 0))
    (loop for record in records do
      (if (and (data-record-id record)
               (data-record-payload record))
          (push record valid-records)
          (incf invalid-count))))
    (list :valid (nreverse valid-records) :invalid-count invalid-count)))

;; Function to transform data
(defun transform-data (valid-records)
  "Transforms the payload of valid records by appending a processing tag."
  (loop for record in valid-records collect
    (setf (data-record-status record) :processed)
    (setf (data-record-payload record)
          (format nil "[PROCESSED] ~A" (data-record-payload record)))
    record))

;; Function to report on the processing results
(defun report-results (valid-records invalid-count)
  "Prints a summary of the data processing results."
  (format t "=== DATA PROCESSING REPORT ===~%")
  (format t "Total Processed: ~A~%" (length valid-records))
  (format t "Invalid/Failed: ~A~%" invalid-count)
  (format t "=============================~%")
  (dolist (record valid-records)
    (format t "ID: ~A | Status: ~A | Payload: ~A~%"
            (data-record-id record)
            (data-record-status record)
            (data-record-payload record))))

;; Main execution flow
(defun run-data-pipeline (raw-input)
  "Executes the full data processing pipeline: ingest -> validate -> transform -> report."
  (print "Starting Data Processing Pipeline...")
  
  ;; 1. Ingest
  (let ((ingested (ingest-data raw-input)))
    (format t "~%~A records ingested.~%" (length ingested))
    
    ;; 2. Validate
    (let ((result (validate-data ingested)))
      (let ((valid (first (cdr (assoc :valid result))))
            (invalid-count (first (cdr (assoc :invalid-count result)))))
        (format t "~A valid, ~A invalid.~%" (length valid) invalid-count)
        
        ;; 3. Transform
        (let ((transformed (transform-data valid)))
          (format t "Transformation complete.~%")
          
          ;; 4. Report
          (report-results transformed invalid-count)))))
  
  (print "Pipeline finished."))

;; Example execution
;; (run-data-pipeline '(("user" "alice") ("admin" "bob") ("guest" "charlie")))
