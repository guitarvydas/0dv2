(defun read-json-graph (filename)
  (uiop:read-file-string (format nil "~a~a" *root* filename)))
