(defun read-json-graph (filename)
  (let ((jstr (uiop:read-file-string (format nil "~a~a" *root* filename))))
    (with-input-from-string (j jstr)
      (cl-json:decode-json j))))
