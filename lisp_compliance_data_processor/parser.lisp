(in-package :compliance-data-processor)

(defpackage :compliance-data-processor/parser
  (:use :common-lisp)
  (:export :parse-record
           :parse-batch
           :create-record-schema))

(in-package :compliance-data-processor/parser)

(declaim (ftype (function (t) t) parse-record))

(defun parse-record (raw-line)
  "Parses a single raw line into a structured association list."
  (let ((fields (split-seq:split-seq raw-line #	))) ;; Requires split-seq or similar
    `((:id ,(nth 0 fields))
      (:timestamp ,(nth 1 fields))
      (:action ,(nth 2 fields))
      (:user ,(nth 3 fields))
      (:status ,(nth 4 fields)))))

(defun parse-batch (raw-data)
  "Parses a list of raw lines into structured records."
  (mapcar #'parse-record raw-data))

(defun create-record-schema ()
  "Returns the expected schema for compliance records."
  '(:id :timestamp :action :user :status))
