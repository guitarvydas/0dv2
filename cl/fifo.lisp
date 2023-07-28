#|
LEGEND:
$me (same as "self")
% built-in function
_ instance variable
@upwards ancestor for looking up missing operation(s)
???/state unexported data field of ??? struct
???/operations exported operations field of ??? struct
|#

#|
(defoperand FIFO
  ((_q nil))
  ((fresh () (%persistent-alloc %my-proto))
   (clone (proto) 
	  (let ((new (fresh $me)))
	    (setf (q new) (mapcar #'clone (q $me)))))
   (free () (mapc #'free (q $me))
	 (%persistent-free $me))
   (enqueue (v) (setf _q (append _q (cons v nil)))) ;; append v to end of queue
   (push (v) (push v _q)) ;; push v to front of queue
   (dequeue () (pop _q)) ;; pop first item from front of queue (mutate q to be the rest)
   (empty? () (null _q)) ;; return true if q is empty
   (as-list () _q))
  nil
)
|#


#|
(defstruct FIFO/state
  (_q nil))

(defstruct FIFO (datum)
  (data (make-FIFO/state))
  (operations (make-function-table 
	       `((clone ,#'(lambda ($me) ...))
		 (free ,#'(lambda ($me) ...))
		 (enqueue ,#'(lambda ($me v) (setf (FIFO/state-_q (FIFO-data $me)) (append (FIFO/state-_q (FIFO-data $me)) (cons v nil)))))
		 (push ,#'(lambda ($me v) (push v (FIFO/state-_q (FIFO-data $me)))))
		 (dequeue ,#'(lambda ($me) (pop (FIFO/state-_q (FIFO-data $me)))))
		 (empty? ,#'(lambda ($me) (null (FIFO/state-_q (FIFO-data $me)))))
		 (as-list ,#'(lambda ($me) (null (FIFO/state-_q (FIFO-data $me))))))))
|#



(defun FIFO/fresh (proto)
  (let ((instance-variables (make-instance-variables-table `((_q nil)))))
    (let ((operations (make-operations-table 
                       `((clone ,#'(lambda ($me) (clone-operand $me)))
                         (free ,#'(lambda ($me) (declare (ignore $me))))
                         (enqueue ,#'(lambda ($me v)
                                       (let ((previous-value (get-named-instance-variable-value $me '_q)))
                                         (cond ((null previous-value)
                                                (set-named-instance-variable $me '_q (cons v nil)))
                                               (t (set-named-instance-variable $me '_q (append previous-value (cons v nil))))))))
                         (push ,#'(lambda ($me v)
                                    (let ((previous-value (get-named-instance-variable-value $me '_q)))
                                      (cond ((null previous-value)
                                             (set-named-instance-variable $me '_q (cons v nil)))
                                            (t (set-named-instance-variable $me '_q (cons v previous-value)))))))
                         (dequeue ,#'(lambda ($me)
                                       (let ((previous-value (get-named-instance-variable-value $me '_q)))
                                         (cond ((null previous-value)
                                                (error (format nil "error: attempt to dequeue empty FIFO ~a" $me)))
                                               (t (let ((v (first previous-value))
                                                        (tail (rest previous-value)))
                                                    (set-named-instance-variable $me '_q tail)
                                                    v))))))
                         (empty? ,#'(lambda ($me)
                                      (let ((previous-value (get-named-instance-variable-value $me '_q)))
                                        (cond ((null previous-value) t)
                                              (t nil)))))
                         (as-list ,#'(lambda ($me) (get-named-instance-variable-value $me '_q)))))))
      (make-operand instance-variables operations proto (Datum/template)))))

(defun enqueue ($me v)
  (lookup-call $me 'enqueue v))
(defun push ($me v)
  (lookup-call $me 'push v))
(defun dequeue ($me)
  (lookup-call $me 'dequeue))
(defun empty? ($me)
  (lookup-call $me 'empty?))
(defun as-list ($me)
  (lookup-call $me 'as-list))

