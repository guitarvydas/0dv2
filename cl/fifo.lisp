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
   (as-list () _q)
   (@upwards () nil)))
|#


#|
(defstruct FIFO/state
  (_q nil))

(defstruct FIFO
  (data (make-FIFO/state))
  (operations (make-function-table 
	       `((clone ,#'(lambda ($me) ...))
		 (free ,#'(lambda ($me) ...))
		 (enqueue ,#'(lambda ($me v) (setf (FIFO/state-_q (FIFO-data $me)) (append (FIFO/state-_q (FIFO-data $me)) (cons v nil)))))
		 (push ,#'(lambda ($me v) (push v (FIFO/state-_q (FIFO-data $me)))))
		 (dequeue ,#'(lambda ($me) (pop (FIFO/state-_q (FIFO-data $me)))))
		 (empty? ,#'(lambda ($me) (null (FIFO/state-_q (FIFO-data $me)))))
		 (as-list ,#'(lambda ($me) (null (FIFO/state-_q (FIFO-data $me)))))
		 (@upwards ,#'(lambda ($me) nil)))))
  (initialization (make-function-table
		   `(
		     (fresh ,#'(lambda () 
		     ))))
|#

(defun FIFO/fresh ()
  (let ((data (make-data-table `((_q nil)))))
    (let ((operations (make-function-table 
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
                                               (t (pop previous-value))))))
                         (empty? ,#'(lambda ($me)
                                      (let ((previous-value (get-named-instance-variable-value $me '_q)))
                                        (cond ((null previous-value) t)
                                              (t nil)))))
                         (as-list ,#'(lambda ($me) (get-named-instance-variable-value $me '_q)))))))
      (make-operand-table `((data ,data) (operations ,operations)) nil))))

(defun enqueue ($me v)
  (lookup-call 'enqueue $me v))
(defun push ($me v)
  (lookup-call 'push $me v))
(defun dequeue ($me)
  (lookup-call 'dequeue $me))
(defun empty? ($me)
  (lookup-call 'empty $me))
(defun as-list ($me)
  (lookup-call 'as-list $me))

