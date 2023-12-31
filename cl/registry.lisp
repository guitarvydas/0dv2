
(defun ComponentRegistry/fresh ()
  (make-hash-table :test 'equal))


(defstruct initializer
  name
  init)

(defun ContainerInitializer/fresh (name init)
  (make-initializer :name name :init init))
(defun LeafInitializer/fresh (name init)
  (make-initializer :name name :init init))


(defun make-component-registry (leaves container-xml)
  ;; creates a registry  given a diagram and a set of Leaf prototypes
  ;; see DI-registry.md
  
  (let ((reg (ComponentRegistry/fresh)))
    (loop for leaf-init in leaves
          do (let ((name (slot-value leaf-init 'name)))
               (setf (gethash name reg) leaf-init)))
    (multiple-value-bind (decls err) 
        (read-json-graph container-xml)
      (unless (not err)
        (error (format nil "Failed parsing container XML")))
      (loop for decl in decls
            do (let ((name (cdr (assoc :name decl))))
		 (setf (gethash name reg) (ContainerInitializer/fresh name decl)))))
    reg))

(defun get-component-instance (reg name)
  (multiple-value-bind (initializer ok)
      (gethash name reg)
    (if ok
	(let ((instance (funcall (slot-value initializer 'init))))
	  (values instance t))
      (values nil nil))))

(defun container-initializer (reg decl)
  ;; instantiating ("initializing") a Container is relatively simple in principle
  ;; 2 things need to happen:
  ;;  1. instantiate fresh copies of all children components contained by the Container, as specified by the prototype
  ;;  2. instantiate fresh connections between all of the new child instances and/or the Container itself, as specified by the prototype
  (let ((self (Container/fresh (slot-value decl 'name))))
    (loop for child-decl in decl
          do (let ((name (slot-value child-decl 'name)))
               (multiple-value-bind (child-instance ok) (get-component-instance reg name)
                 (if (not ok)
                     (error (format nil "Can't find component ~a" name))
                   (insert-and-mutate child-instance (slot-value self 'children))))))
    (let ((connections nil))
      (loop for proto-conn in (slot-value decl 'connections)
	    do (let ((conn (Connector/fresh nil nil nil)))
                 (case (slot-value proto-conn 'direction)
                   (down
                    (setf (slot-value conn 'direction) 'down)
                    ;; (setf conn.sender (Sender/fresh 'self proto-conn.sender.port))
                    (setf (slot-value conn 'sender) (Sender/fresh 'self (slot-value (slot-value proto-conn 'sender) 'port)))
                    ;; (setf conn.receiver (Receiver/fresh proto-conn.receiver.component.input proto-conn.receiver.port))
                    (setf (slot-value conn 'receiver) 
                          (Receiver/fresh (slot-value (slot-value (slot-value proto-conn 'receiver) 'component) 'input)
                                        (slot-value (slot-value proto-conn 'receiver) 'port))))
                   (across
                    (setf (slot-value conn 'direction) 'across)
                    ;; (setf conn.sender (Sender/fresh proto-conn.sender.component proto-conn.sender.port))
                    (setf (slot-value conn 'sender) 
                          (Sender/fresh (slot-value (slot-value proto-conn 'sender) 'component)
                                      (slot-value (slot-value proto-conn 'sender) 'port)))
                    ;; (setf conn.receiver (Receiver/fresh proto-conn.receiver.component.input proto-conn.receiver.port))
                    (setf (slot-value conn 'receiver) 
                          (Receiver/fresh (slot-value (slot-value (slot-value proto-conn 'receiver) 'component) 'input)
                                        (slot-value (slot-value proto-conn 'receiver) 'port))))
                   (up
                    (setf (slot-value conn 'direction) 'up)
                    ;; (setf conn.sender (Sender/fresh proto-conn.sender.component proto-conn.sender.port))
                    (setf (slot-value conn 'sender) 
                          (Sender/fresh (slot-value (slot-value proto-conn 'sender) 'component)
                                      (slot-value (slot-value proto-conn 'sender) 'port)))
                    ;; (setf conn.receiver (Receiver/fresh self.output proto-conn.receiver.port))
                    (setf (slot-value conn 'receiver) 
                          (Receiver/fresh (slot-value self 'output)
                                        (slot-value (slot-value proto-conn 'port) 'port))))
                   (through
                    (setf (slot-value conn 'direction) 'through)
                    ;; (setf conn.sender (Receiver/fresh 'self proto-conn.sender.port))
                    (setf (slot-value conn 'sender) (Sender/fresh 'self (slot-value (slot-value proto-conn 'sender) 'port)))
                    ;; (setf conn.receiver (Receiver/fresh self.output proto-conn.receiver.port))
                    (setf (slot-value conn 'receiver) 
                          (Receiver/fresh (slot-value self 'output)
                                        (slot-value (slot-value proto-conn 'receiver) 'port))))
                   )
                 (insert-and-mutate conn connections)))
      (setf (slot-value self connections) connections))
    self))

(defun dump-registry (reg)
  (format *standard-output* "~%")
  (maphash #'(lambda (key v)
	       (format *standard-output* "~a ~a~%" key v))
	   reg)
  (format *standard-output* "~%"))

(defun dump-diagram (diagram-as-json-file)
    (multiple-value-bind (decls err)
        (read-json-graph diagram-as-json-file)
      (unless (not err)
        (error (format nil "Failed parsing diagram ~a" diagram-as-json-file)))
      (loop for decl in decls
	    do (let ((j (json:encode-json decl)))
		 (format *standard-output* "~a~%" j)))))
