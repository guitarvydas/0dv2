(defun echo-handler (eh msg)
  (send eh "stdout" (slot-value msg 'datum)))

(defun main ()
  (format *standard-output* "~%*** Handmade Visibility Jam ***")
  (format *standard-output* "~%--- Super Basic: Single ---")
  (let ((echo0 (Leaf/New "10" #'echo-handler))
	(top (Container/new "Top")))
    (setf (slot-value top 'children)
	  (list echo0))
    (let ((child0 (nth 0 (slot-value top 'children))))
      (setf (slot-value top 'connections)
	    (list
	     (Connector/new 'Down 
			     (Sender/new top "stdin")
			     (Receiver/new (slot-value child0 'input) "stdin"))
	     (Connector/new 'Up
			     (Sender/new child0 "stdout")
			     (Receiver/new (slot-value top 'output) "stdout"))
	     )
	    )
      )
    (funcall (slot-value top 'handler)
             top
             (Message/new "stdin" "hello"))
    (as-list (slot-value top 'output))))
	  
	  
