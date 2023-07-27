(defun FIFO/fresh ()
  (let ((q nil))
    `(
      (append . ,(lambda (v) (setf q (append q (cons v nil))))) ;; append v to end of queue
      (push . ,(lambda (v) (push v q))) ;; push v to front of queue
      (pop . ,(lambda () (pop q))) ;; pop first item from front of queue (mutate q to be the rest)
      (is-empty . ,(lambda () (null q))) ;; return true if q is empty
      (as-list . ,(lambda () q))
      (%proto . nil)
      )))

(defun lookup (operation-name obj)
  (let ((pair (assoc operation-name obj)))
    (if pair
	(cdr pair)
	(let ((proto-pair (assoc '%proto obj)))
	  (if (and proto-pair (cdr proto-pair))
	      (lookup operation-name (cdr proto-pair))
	     nil)))))

(defmacro @ (operation-name obj &rest args)
  `(let ((%func (lookup ,operation-name ,obj)))
     (unless %func 
       (error (format nil "operator ~a not found in object ~a" ,operation-name ,obj)))
     (apply %func (list ,@args))))

(defun enqueue (fifo v)
  (@ 'append fifo v))

(defun fifopush (fifo v)
  (@ 'push fifo v))

(defun fifopop (fifo)
  (@ 'pop fifo))

(defun empty? (fifo)
  (@ 'is-empty fifo))

(defun as-list (fifo)
  (@ 'as-list fifo))
  
