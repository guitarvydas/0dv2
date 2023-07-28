(defun Datum/template ()
  (let ((instance-variables nil))
    (let ((operations (make-operations-table 
                       `((clone ,#'(lambda ($me) (clone-operand $me)))
                         (destroy ,#'(lambda ($me) (declare (ignore $me))))))))
      (make-operand instance-variables operations nil nil))))

(defun Datum/fresh (proto)
  (declare (ignore proto))
  (Datum/template))

(defun clone ($me)
  (lookup-call $me 'clone))
(defun destroy ($me)
  (lookup-call $me 'destroy))
