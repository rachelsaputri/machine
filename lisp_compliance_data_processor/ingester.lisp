(in-package :compliance-data-processor)

(defpackage :compliance-data-processor/ingester
  (:use :common-lisp)
  (:export :read-data-file
           :load-data-from-stream
           :init-connector))

(in-package :compliance-data-processor/ingester)

(defun read-data-file (filepath)
  "Reads data from a file and returns a list of raw records."
  (with-open-file (stream filepath :direction :input)
    (loop for line = (read-line stream nil nil) while line
          collect line)))

(defun load-data-from-stream (stream)
  "Reads data from an existing stream."
  (loop for line = (read-line stream nil nil) while line
        collect line))

(defun init-connector (config)
  "Initializes a connection based on config. Returns t on success."
  ;; Placeholder for actual connection logic
  (format t "Initializing connector with config: ~a~%" config)
  t)
