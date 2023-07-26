;; generated by ChatGPT (see 0d-prompt.md)
;; then, corrected and tweaked by Paul Tarvydas

(defstruct eh
  name
  input
  output
  yield
  children
  connections
  handler
  leaf-handler
  instance-data
  state)

(defun EH/new (name)
  (let ((eh (make-eh)))
    (setf (eh-name eh) name
          (eh-input eh) (FIFO/new)
	  (eh-output eh) (FIFO/new)
	  (eh-yield eh) (FIFO/new))
    eh))

(defstruct message
  port
  datum)

(defstruct connector
  direction ;; 'down, 'across, 'up, 'through, 'NC (in which case, receiver is nil)
  sender
  receiver)

(defstruct sender
  component
  port)

(defstruct receiver
  queue
  port)

(defun Connector/new (d s r)
  (make-connector :direction d :sender s :receiver r))

(defun Sender/new (component port)
  (make-sender :component component :port port))

(defun Receiver/new (queue port)
  (make-receiver :queue queue :port port))

(defun Message/new (port data)
  (make-message :port port :datum data))

;; Clones a message
(defun clone-message (message)
  (make-message :port (clone-port (message-port message)) :datum (clone-datum (message-datum message))))

;; Clones the datum portion of the message
(defun clone-datum (datum)
  (copy-seq datum))

(defun clone-port (port)
  (copy-seq port))

;; Frees a message
(defun destroy-message (message)
  ;; No need to explicitly free memory in Common Lisp, as it has automatic garbage collection
  ;; Do nothing here
  (declare (ignore message))
  )

(defun Container/new (name)
  (let ((eh (EH/new name)))
    (setf (eh-handler eh) #'container-handler
          (eh-instance-data eh) nil)
    eh))

(defun Leaf/new (name handler &optional (instance-data nil))
  (let ((eh (EH/new name)))
    (setf (eh-handler eh) handler
	  (eh-instance-data eh) instance-data)
    eh))

(defun send (eh port data)
  (let ((msg (Message/new (clone-port port) (clone-datum data))))
    (enqueue (eh-output eh) msg)))

(defun yield (eh port data)
  (let ((msg (Message/new (clone-port port) (clone-datum data))))
    (enqueue (eh-yield eh) msg)))


(defun container-handler (eh message)
  (route eh eh message)
  (loop until (not (any-child-ready eh))
        do (step-children eh)))

(defun set-state (eh state)
  (setf (eh-state eh) state))

(defun sender-eq (s1 s2)
  (and (equal (sender-component s1) (sender-component s2))
       (equal (sender-port s1) (sender-port s2))))

(defun deposit (connector message)
  (let ((recvr (connector-receiver connector)))
      (if (not (null recvr))
	  (let ((new-message (clone-message message)))
	    (setf (message-port new-message) (receiver-port (connector-receiver connector)))
	    (enqueue (receiver-queue recvr) new-message)))))

(defun step1 (container child fifo)
  (let ((input-msg (fifopop fifo)))
    (format *standard-output* "~%stepping: ~a" (slot-value child 'name))
    (funcall (eh-handler child) child input-msg)
    (loop while (not (empty? (eh-output child)))
	  do (let ((output-message (fifopop (eh-output child))))
	       (route container child output-message)
	       (destroy-message output-message)))))
  
(defun step-children (container)
  (dolist (child (eh-children container))
    (if (not (empty? (eh-yield child)))
	(step1 container child (eh-yield child))
       (if (not (empty? (eh-input child)))
	   (step1 container child (eh-input child))))))

(defun route (container from message)
  (let ((from-sender (make-sender :component from :port (message-port message))))
    (dolist (connector (eh-connections container))
      (when (sender-eq from-sender (connector-sender connector))
        (deposit connector message)))))

(defun any-child-ready (container)
  (dolist (child (eh-children container))
    (when (child-is-ready child)
      (return-from any-child-ready t)))
  nil)

(defun child-is-ready (eh)
  (or (not (empty? (eh-input eh)))
      (not (empty? (eh-yield eh)))))

(defun insert-and-mutate (v lis)
  (push v lis))