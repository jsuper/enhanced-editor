;; comment function for enhanced-editors

(defun delete-string-forward (string &optional bound count)
  "Delete the string which found in buffer,
   bound - specify the max position which need to handle, must be interge 
   count - defined how many mapped should be deleted, integer
  "
  (let ((bound (if bound 
		   (if (integerp bound)
		       bound
		     (error "type of second arg must be integer or nil"))
		 (point-max)))
	(count (if count
		   (if (integerp count)
		       count
		     (error "type of third arg must be integer or nil"))
		 1)))
    (dotimes (i count)
      (when (search-forward string bound t)
	(delete-region (- (point) (length string)) (point)))
      )
    ))

(defun delete-string-backward (string &optional bound count)
  (let ((bound (if bound 
		   (if (integerp bound)
		       bound
		     (error "type of second arg must be integer or nil"))
		 (point-min)))
	(count (if count
		   (if (integerp count)
		       count
		     (error "type of third arg must be integer or nil"))
		 1)))
    (dotimes (i count)
      (when (search-backward string bound t count)
	(delete-region (point) (+ (point) (length string)))))
    ))



(provide 'enhanced-common-function)
