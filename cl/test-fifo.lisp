(defun test ()
  (let ((fifo (FIFO/fresh nil)))
    (format *standard-output* "empty: ~a~%" (empty? fifo))
    (format *standard-output* "as-list: ~a~%" (as-list fifo))
    (push fifo 1)
    (format *standard-output* "as-list: ~a~%" (as-list fifo))
    (enqueue fifo 2)
    (format *standard-output* "as-list: ~a~%" (as-list fifo))
    (push fifo 0)
    (format *standard-output* "as-list: ~a~%" (as-list fifo))
    (let ((v (dequeue fifo)))
      (format *standard-output* "v: ~a~%" v)
      (format *standard-output* "as-list: ~a~%" (as-list fifo)))
    (format *standard-output* "empty: ~a~%" (empty? fifo))
    (values)))
  
