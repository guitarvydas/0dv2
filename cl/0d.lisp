;;;;;;;;

(defclass Operand ()
  ((raw :accessor raw :initform nil :initarg :raw)
   (len :accessor len :initform nil :initarg :len)
   (reflection :accessor reflection :initform nil :initarg :reflection)))

(defclass List-Operand (Operand)())

(defun Operand/new (&key raw len reflection)
  (make-instance 'Operand :raw raw :len len :reflection reflection))

(defun List-Operand/new (&key raw len reflection)
  (make-instance 'List-Operand :raw raw :len len :reflection reflection))

(defmethod clone ((self Operand))
  (Operand/new :raw (raw self) :len (len self) :reflection (reflection self)))

(defmethod reclaim ((self Operand))
  (declare (ignore self)))

(defmethod repr ((self Operand))
  self)

(defun operand-from-string (s)
  (make-instance 'Operand :raw s :len (length s) :reflection s))

(defun operand-from-any (x)
  (let ((L (if (has-method? x 'length) (length x) nil)))
    (make-instance 'Operand :raw x :len L :reflection x)))

(defun has-method? (x sym)
  (declare (ignore x sym))
  t) ;; I don't know how to query this, so I'll skip it for now...

(defun operand-eq (self other)
  (eq self other))

(defmethod as-list ((self List-Operand))
  (raw self))

(defmethod as-list ((self T)) ;; error if self is not already a List
  (assert nil))

;;;;;;;;

(defclass FIFO ()
  ((queue :accessor queue :initform nil :initarg :queue)))

(defmethod enqueue ((self FIFO) v)
  (push v (queue self)))

(defmethod dequeue ((self FIFO))
  (cond ((null (queue self)) (throw 'dequeue-empty-queue nil))
	(t (let ((r (car (last (queue self)))))
	     (setf (queue self) (butlast (queue self)))
	     r))))

(defmethod clear ((self FIFO))
  (setf (queue self) nil))

(defmethod isEmpty ((self FIFO))
  (not (null (queue self))))

(defmethod as-list ((self FIFO))
  (queue self))

;;;;;;;

(defclass eh ()
  ((name :accessor name :initform "" :initarg :name)
   (input :accessor input :initform (make-instance 'FIFO) :initarg :input)
   (output :accessor output :initform (make-instance 'FIFO) :initarg :output)
   (priority :accessor priority :initform (make-instance 'FIFO) :initarg :priority)
   (instance-data :accessor instance-data :initform nil :initarg :instance-data)
   (children :accessor children :initform (Children/new) :initarg :children)
   (connections :accessor connections :initform (Connections/new) :initarg :connections)
   (handler :accessor handler :initform #'not-handled :initarg :handler)
   (state :accessor state :initform nil :initarg :state)))

(defun not-handled (self msg)
  (declare (ignore self msg))
  (assert nil))

(defclass Container (Eh)
  ())
(defclass Leaf (Eh)
  ())

(defun Children/new ()
  (make-instance 'List-Operand :raw nil :len 0 :reflection nil))

(defun Connections/new ()
  (make-instance 'List-Operand :raw nil :len 0 :reflection nil))

;;;

(defclass Message ()
  ((port :accessor port :initform (make-instance 'Operand) :initarg :port)
   (data :accessor data :initform (make-instance 'Operand) :initarg :data)))

(defun Message/new (&key port operand)
  (make-instance 'Message :port port :data operand))

(defun message-from-string/new (port-as-string data)
  (let ((port-operand (clone (operand-from-string port-as-string)))
	(data-operand (clone (operand-from-any data))))
    (Message/new :port port-operand :data data-operand)))
	  
(defun message-clone (msg)
  (let ((port-operand (clone (port msg)))
	(data-operand (clone (data msg))))
    (Message/new :port port-operand :data data-operand)))

(defun discard-message (msg)
  (declare (ignore msg)))

(defun send (eh port operand)
  (enqueue (input eh) (Message/new :port port :operand operand)))

(defun send-priority (eh port operand)
  (enqueue (priority eh) (Message/new :port port :operand operand)))

(defun output-list (eh)
  (as-list (output eh)))

(defun container-handler (eh msg instance-data)
  (declare (ignore instance-data))
  (route eh nil msg)
  (loop while (any-child-ready eh)
	do (step-children eh)))

(defun set-state (eh state)
  (setf (state eh) state))

(defun destroy-container (eh)
  (declare (ignore eh)))

;;;;;

(defclass Connector ()
  ((direction :accessor direction :initform nil :initarg :direction)
   (sender :accessor sender :initform nil :initarg sender)
   (receiver :accessor receiver :initform nil :initarg receiver)))

;;; # Direction :: enum {
;;; #     'Down,
;;; #     'Across,
;;; #     'Up,
;;; #     'Through,
;;; # }

(defclass Sender ()
  ((component :accessor component :initform nil :initarg :component)
   (port :accessor port :initform nil :initarg :port)))

(defun Sender/new (&key component port)
  (make-instance 'Sender :component component :port port))

(defmethod sender-eq ((self Sender) (other Sender))
  (and (operand-eq (component self) (component other))
       (operand-eq (port self) (port other))))

(defmethod sender-eq ((self Sender) (other T))
    nil)
  

(defclass Receiver ()
  ((component :accessor component :initform nil :initarg :component)
   (port :accessor port :initform nil :initarg :port)))

(defun Receiver/new (&key component port)
  (make-instance 'Receiver :component component :port port))

        
(defun invoke (container child msg)
  (funcall (handler child) child msg)
  (loop while (not (isEmpty (output child)))
	do (let ((m (dequeue (output child))))
	     (route container m (instance-data child))))
  (discard-message msg))

(defun step-children (container)
  (step-children-loop container (as-list (children container))))

(defun step-children-loop (container children-list)
  (unless (null children-list)
    (let ((child (first children-list))
	  (remainder (rest children-list)))
      (cond ((not (isEmpty (priority child)))
	     (let ((msg (dequeue (priority child))))
	       (invoke container child msg)))
	    ((not (isEmpty (input child)))
	     (let ((msg (dequeue (input child))))
	       (invoke container child msg))))
      (step-children-loop container remainder))))

(defun route (container from-eh msg)
  (let ((from-sender (Sender/new from-eh (port msg)))
	(deposits 'none))
    (loop for connector in (connections container)
	  do (when (sender-eq from-sender (sender connector))
	       (deposit connector msg))
	  (setf deposits 'some))
    (unless (eq 'some deposits)
      (format *error-output* "### message ignored ~a ~a ~a ###"
	      (name container)
	      (name from-eh)
	      (funcall (repr (data msg)) (data msg))))))
    
(defun deposit (connector msg)
  (let ((new-message (Message/new :port (port (receiver connector)) :data (data msg))))
    (enqueue (input (receiver connector)) new-message)))


(defun any-child-ready (container)
  (loop for child in (children container)
        do (if (child-is-ready child)
               (return-from any-child-ready t)))
	(return-from any-child-ready nil))

(defun child-is-ready (eh)
  (or (not (isEmpty (input eh)))
      (not (isEmpty (output eh)))
      (not (isEmpty (priority eh)))))

(defun print-output-list (eh)
  (format *standard-output* "[")
  (loop for m in (output eh)
	do (format *standard-output* "~a" m))
  (format *standard-output* "]"))

    
