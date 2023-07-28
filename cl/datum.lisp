(defun Datum/template ()
  (let ((instance-variables nil))
    (let ((operations (make-operations-table 
                       `((clone ,#'(lambda ($me) (clone-operand $me)))
                         (free ,#'(lambda ($me) (declare (ignore $me))))))))
      (make-operand instance-variables operations nil nil))))

(defun Datum/fresh (proto)
  (declare (ignore proto))
  (Datum/template))
