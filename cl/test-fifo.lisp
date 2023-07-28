(defun test ()
  (let ((fifo (FIFO/fresh)))
    (format *standard-output* "empty: ~a~%" (empty? fifo))
    (format *standard-output* "as-list: ~a~%" (as-list fifo))
    (values)))
  
