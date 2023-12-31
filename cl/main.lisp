(defun echo-handler (eh msg)
  (send eh "stdout" (message-datum msg)))

(defun main ()
  (format *standard-output* "~%*** Handmade Visibility Jam ***")
  (format *standard-output* "~%--- Super Basic: Single ---")
  (let ((echo0 (Leaf/fresh "10" #'echo-handler))
	(top (Container/fresh "Top")))
    (setf (slot-value top 'children)
	  (list echo0))
    (let ((child0 (nth 0 (slot-value top 'children))))
      (setf (slot-value top 'connections)
	    (list
	     (Connector/fresh :direction 'Down 
                              :sender (Sender/fresh :component top :port "stdin")
                              :receiver (Receiver/fresh :queue (eh-input child0) :port "stdin"))
	     (Connector/fresh :direction 'Up
                              :sender (Sender/fresh :component child0 :port "stdout")
                              :receiver (Receiver/fresh :queue (eh-output top) :port "stdout"))
	     )
	    )
      )
    (funcall (slot-value top 'handler)
             top
             (Message/fresh :port "stdin" :datum "hello"))
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )
  (format *standard-output* "~%--- Basic: Synchronous ---")
  (let ((echo0 (Leaf/fresh "10" #'echo-handler))
        (echo1 (Leaf/fresh "11" #'echo-handler))
	(top (Container/fresh "Top")))
    (setf (slot-value top 'children)
	  (list echo0 echo1))
    (let ((child0 (nth 0 (slot-value top 'children)))
          (child1 (nth 1 (slot-value top 'children))))
      (setf (slot-value top 'connections)
	    (list
	     (Connector/fresh :direction 'Down 
                            :sender (Sender/fresh :component top :port "stdin")
                            :receiver (Receiver/fresh :queue (eh-input child0) :port "stdin"))
	     (Connector/fresh :direction 'Across
                            :sender (Sender/fresh :component child0 :port "stdout")
                            :receiver (Receiver/fresh :queue (eh-input child1) :port "stdin"))
	     (Connector/fresh :direction 'Up
                            :sender (Sender/fresh :component child1 :port "stdout")
                            :receiver (Receiver/fresh :queue (eh-output top) :port "stdout"))
	     )
	    )
      )
    (funcall (slot-value top 'handler)
             top
             (Message/fresh :port "stdin" :datum "hello"))
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )
  (format *standard-output* "~%--- Basic: Parallel ---")
  (let ((echo0 (Leaf/fresh "10" #'echo-handler))
        (echo1 (Leaf/fresh "11" #'echo-handler))
	(top (Container/fresh "Top")))
    (setf (slot-value top 'children)
	  (list echo0 echo1))
    (let ((child0 (nth 0 (slot-value top 'children)))
          (child1 (nth 1 (slot-value top 'children))))
      (setf (slot-value top 'connections)
	    (list
	     (Connector/fresh :direction 'Down 
                            :sender (Sender/fresh :component top :port "stdin")
                            :receiver (Receiver/fresh :queue (eh-input child0) :port "stdin"))
	     (Connector/fresh :direction 'Down 
                            :sender (Sender/fresh :component top :port "stdin")
                            :receiver (Receiver/fresh :queue (eh-input child1) :port "stdin"))
	     (Connector/fresh :direction 'Up
                            :sender (Sender/fresh :component child0 :port "stdout")
                            :receiver (Receiver/fresh :queue (eh-output top) :port "stdout"))
	     (Connector/fresh :direction 'Up
                            :sender (Sender/fresh :component child1 :port "stdout")
                            :receiver (Receiver/fresh :queue (eh-output top) :port "stdout"))
	     )
	    )
      )
    (funcall (slot-value top 'handler)
             top
             (Message/fresh :port "stdin" :datum "hello"))
    (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
    )

;;   (format *standard-output* "~%--- Drawio: Super Basic ---")
;;   (let ((leaves (list
;; 		 (LeafInitializer/fresh "Echo" #'echo-handler)
;; 		 )))
;;     (let ((palette (make-component-registry leaves "sample.json")))
;;       (format *standard-output* "~%~%*** Palette ***")
;;       (format *standard-output* "~%~a" palette)
;;       (format *standard-output* "~%~%")
;;       (multiple-value-bind (top ok) 
;;           (get-component-instance palette "main")
;;         (values top ok)
;;         )
;;       )
;;     )
    


;;   ;; (let ((echo0 (Leaf/fresh "30" #'echo-handler)))
;;   ;; 	(top (Container/fresh "Top")))
;;   ;;   (setf (slot-value top 'children)
;;   ;; 	  (list echo0 echo1))
;;   ;;   (let ((child0 (nth 0 (slot-value top 'children)))
;;   ;;         (child1 (nth 1 (slot-value top 'children))))
;;   ;;     (setf (slot-value top 'connections)
;;   ;; 	    (list
;;   ;; 	     (Connector/fresh :direction 'Down 
;;   ;;                           :sender (Sender/fresh :component top :port "stdin")
;;   ;;                           :receiver (Receiver/fresh :queue (eh-input child0) :port "stdin"))
;;   ;; 	     (Connector/fresh :direction 'Down 
;;   ;;                           :sender (Sender/fresh :component top :port "stdin")
;;   ;;                           :receiver (Receiver/fresh :queue (eh-input child1) :port "stdin"))
;;   ;; 	     (Connector/fresh :direction 'Up
;;   ;;                           :sender (Sender/fresh :component child0 :port "stdout")
;;   ;;                           :receiver (Receiver/fresh :queue (eh-output top) :port "stdout"))
;;   ;; 	     (Connector/fresh :direction 'Up
;;   ;;                           :sender (Sender/fresh :component child1 :port "stdout")
;;   ;;                           :receiver (Receiver/fresh :queue (eh-output top) :port "stdout"))
;;   ;; 	     )
;;   ;; 	    )
;;   ;;     )
;; #|
;;     (funcall (slot-value top 'handler)
;;              top
;;              (Message/fresh "stdin" "hello"))
;;     (format *standard-output* "~%output: ~a" (as-list (slot-value top 'output)))
;;     )
;; |#
  (values)
  )


