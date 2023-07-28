


;; straight-forward implementation, but probably innefficient, optimize later

(defun make-operations-table (pairs)
  (make-hashmap pairs (make-hash-table :test 'equal)))

(defun make-instance-variables-table (pairs)
  (make-hashmap pairs (make-hash-table :test 'equal)))

(defun make-operand (instance-variables operations parent-instance parent-template)
  (let ((lis (list instance-variables operations parent-instance parent-template)))
    (coerce-list-to-vector lis)))

(defun make-hashmap (pairs htable)
  (cond ((null pairs) htable)
	(t (let ((pair (first pairs))
		 (tail (rest pairs)))
	     (setf (gethash (first pair) htable) (second pair))
	     (make-hashmap tail htable)))))

(defun make-listmap (pairs)
  (cond ((null pairs) nil)
	(t (let ((pair (first pairs))
		 (tail (rest pairs)))
	     (cons (second pair) (make-listmap tail))))))

(defun coerce-list-to-vector (lis)
  (coerce lis 'vector))

(defun get-instance-variables-table (operand)
  ;; when operand is known to be a vector[4]
  (aref operand 0))

(defun get-operations-table (operand)
  ;; when operand is known to be a vector[4]
  (aref operand 1))

(defun get-parent-instance (operand)
  ;; when operand is known to be a vector[4]
  (aref operand 2))

(defun get-parent-template (operand)
  ;; when operand is known to be a vector[4]
  (aref operand 3))

(defun get-named-instance-variable-value (operand name)
  (let ((instance-variables-table (get-instance-variables-table operand)))
    (multiple-value-bind (v found)
        (gethash name instance-variables-table)
      (cond ((not found)
             (let ((parent-instance (get-parent-instance operand)))
               (cond ((null parent-instance)
                      (error (format nil "variable ~a not found in ~a" name operand)))
                     (t (get-named-instance-variable-value parent-instance name)))))
            (t v)))))

(defun set-named-instance-variable (operand name v)
  (let ((instance-variables-table (get-instance-variables-table operand)))
    (setf (gethash name instance-variables-table) v)))
  
(defun get-named-operation (operand name)
  (let ((operations-table (get-operations-table operand)))
    (multiple-value-bind (v found)
        (gethash name operations-table)
      (cond ((not found)
             (let ((parent-instance (get-parent-instance operand))
                   (parent-template (get-parent-template operand)))
               (cond ((null parent-instance)
                      (cond ((null parent-template)
                             (error (format nil "operation ~a not found in ~a" name operand)))
                            (t (get-named-operation parent-template name))))
                     (t (get-named-operation parent-instance name)))))
            (t v)))))


(defun clone-operand (operand)
  (let ((instance-variables-table (copy-table (get-instance-variables-table operand)))
        (operations-table (copy-table (get-operations-table operand)))
        (parent-instance (get-parent-instance operand))
        (parent-template (get-parent-template operand)))
    (vector instance-variables-table operations-table parent-instance parent-template)))
      

;;; https://stackoverflow.com/questions/26045442/copy-hash-table-in-lisp

(defun copy-table (table)
  (let ((new-table (make-hash-table
                    :test (hash-table-test table)
                    :size (hash-table-size table))))
    (maphash #'(lambda(key value)
                 (setf (gethash key new-table) value))
             table)
    new-table))

;;;;;;;;


(defun lookup-call (operand name &rest args)
  (let ((func (get-named-operation operand name)))
    (if (null func)
	(error (format nil "operation ~a not found in ~a" name operand))
      (apply func (cons operand args)))))

