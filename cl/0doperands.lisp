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
			 `((component ,(attr _component))
			   (port ,(attr _port))
			   (=? ,#'(lambda ($me other)
				   (and (equal (component $me) (component other))
					(equal (port $me) (port other)))))))))
	(make-operand instance-variables operations nil (Datum/template)))))
	

(defun component ($me)
  (lookup-call $me 'component))
(defun port ($me)
  (lookup-call $me 'port))
(defun =? ($me other)
  (lookup-call $me '=? other))

(defun Receiver/fresh (&key queue port)
    (let ((instance-variables (make-instance-variables-table `((_queue ,queue) (_port ,port)))))
      (let ((operations (make-operations-table 
			 `((queue ,(attr _queue))
			   (port ,(attr _port))))))
	(make-operand instance-variables operations nil (Datum/template)))))
	

(defun receiver-queue ($me)
  (lookup-call $me 'queue))
(defun receiver-port ($me)
  (lookup-call $me 'port))



(defun Message/fresh (&key port datum)
    (let ((instance-variables (make-instance-variables-table `((_port ,port) (_datum ,datum)))))
      (let ((operations (make-operations-table 
			 `((datum ,(attr _datum))
			   (port ,(attr _port))))))
	(make-operand instance-variables operations nil (Datum/template)))))
	

(defun message-datum ($me)
  (lookup-call $me 'datum))
(defun message-port ($me)
  (lookup-call $me 'port))
