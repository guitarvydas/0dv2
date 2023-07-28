(defun Datum/fresh (&key datum)
  (let ((instance-variables (make-instance-variables-table `((_datum ,datum)))))
    (let ((operations (make-operations-table 
                       `((clone ,#'(lambda ($me) (clone-operand $me)))
                         (free ,#'(lambda ($me) (declare (ignore $me))))))))
	(make-operand instance-variables operations nil nil))))

#|
(defoperand Sender (datum nil)
  ((_component nil)
   (_port nil))
  ((component () _component)
   (port () _port)
   (=? (other) (and 
                 (equal (component $me) (component other))
                 (equal (port $me) (port other)))))

)
|#

(defun Sender/fresh (&key component port)
    (let ((instance-variables (make-instance-variables-table `((_component ,component) (_port ,port)))))
      (let ((operations (make-operations-table 
			 `((component #'(lambda ($me) (get-named-instance-variable-value $me '_component)))
			   (port #'(lambda ($me) (get-named-instance-variable-value $me '_port)))
			   (=? #'(lambda ($me other)
				   (and (equal (component $me) (component other))
					(equal (port $me) (port other)))))))))
	(make-operand instance-variables operations nil datum))))
	

(defun component ($me)
  (lookup-call $me 'component))
(defun port ($me)
  (lookup-call $me 'port))
(defun =? ($me)
  (lookup-call $me '=?))
