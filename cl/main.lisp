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
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )
  (format *standard-output* "~%--- Basic: Synchronous ---")
  (let ((echo0 (Leaf/New "10" #'echo-handler))
        (echo1 (Leaf/New "11" #'echo-handler))
	(top (Container/new "Top")))
    (setf (slot-value top 'children)
	  (list echo0 echo1))
    (let ((child0 (nth 0 (slot-value top 'children)))
          (child1 (nth 1 (slot-value top 'children))))
      (setf (slot-value top 'connections)
	    (list
	     (Connector/new 'Down 
                            (Sender/new top "stdin")
                            (Receiver/new (slot-value child0 'input) "stdin"))
	     (Connector/new 'Across
                            (Sender/new child0 "stdout")
                            (Receiver/new (slot-value child1 'input) "stdin"))
	     (Connector/new 'Up
                            (Sender/new child1 "stdout")
                            (Receiver/new (slot-value top 'output) "stdout"))
	     )
	    )
      )
    (funcall (slot-value top 'handler)
             top
             (Message/new "stdin" "hello"))
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )
  (format *standard-output* "~%--- Basic: Parallel ---")
  (let ((echo0 (Leaf/New "10" #'echo-handler))
        (echo1 (Leaf/New "11" #'echo-handler))
	(top (Container/new "Top")))
    (setf (slot-value top 'children)
	  (list echo0 echo1))
    (let ((child0 (nth 0 (slot-value top 'children)))
          (child1 (nth 1 (slot-value top 'children))))
      (setf (slot-value top 'connections)
	    (list
	     (Connector/new 'Down 
                            (Sender/new top "stdin")
                            (Receiver/new (slot-value child0 'input) "stdin"))
	     (Connector/new 'Down 
                            (Sender/new top "stdin")
                            (Receiver/new (slot-value child1 'input) "stdin"))
	     (Connector/new 'Up
                            (Sender/new child0 "stdout")
                            (Receiver/new (slot-value top 'output) "stdout"))
	     (Connector/new 'Up
                            (Sender/new child1 "stdout")
                            (Receiver/new (slot-value top 'output) "stdout"))
	     )
	    )
      )
    (funcall (slot-value top 'handler)
             top
             (Message/new "stdin" "hello"))
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )

  (format *standard-output* "~%--- Drawio: Super Basic ---")
  (let ((leaves (list
		 (LeafInitializer/new "Echo" #'echo-handler)
		 )))
    (let ((palette (make-component-registry leaves "sample.json")))
      (format *standard-output* "~%~%*** Palette ***")
      (format *standard-output* "~%~a" palette)
      (format *standard-output* "~%~%")))


  ;; (let ((echo0 (Leaf/New "30" #'echo-handler)))
  ;; 	(top (Container/new "Top")))
  ;;   (setf (slot-value top 'children)
  ;; 	  (list echo0 echo1))
  ;;   (let ((child0 (nth 0 (slot-value top 'children)))
  ;;         (child1 (nth 1 (slot-value top 'children))))
  ;;     (setf (slot-value top 'connections)
  ;; 	    (list
  ;; 	     (Connector/new 'Down 
  ;;                           (Sender/new top "stdin")
  ;;                           (Receiver/new (slot-value child0 'input) "stdin"))
  ;; 	     (Connector/new 'Down 
  ;;                           (Sender/new top "stdin")
  ;;                           (Receiver/new (slot-value child1 'input) "stdin"))
  ;; 	     (Connector/new 'Up
  ;;                           (Sender/new child0 "stdout")
  ;;                           (Receiver/new (slot-value top 'output) "stdout"))
  ;; 	     (Connector/new 'Up
  ;;                           (Sender/new child1 "stdout")
  ;;                           (Receiver/new (slot-value top 'output) "stdout"))
  ;; 	     )
  ;; 	    )
  ;;     )
#|
    (funcall (slot-value top 'handler)
             top
             (Message/new "stdin" "hello"))
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )
|#
  )


