(defun read-json-graph (filename)
  (with-input-from-string (j (uiop:read-file-string (format nil "~a~a" *root* filename)))
    (cl-json:decode-json j)))
