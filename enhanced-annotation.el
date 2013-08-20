;;Enhanced Annotation for Emacs User

(require 'mode-annotation-cfg)

(defun annotate-current-line (mode-cfg)
  (let ((annotation-symbol (get-annotation-symbol mode-cfg))
	(support-block-annotation (get-suport-block-annotation mode-cfg)))
    (if annotation-symbol
	(progn
	  (goto-char (line-beginning-position))
	  (insert-string annotation-symbol))
      (progn
	(if support-block-annotation
	    (progn
	      (goto-char (line-beginning-position))
	      (insert-string (get-begin-block-symbol mode-cfg))
	      (goto-char (line-end-position))
	      (insert-string (get-end-block-symbol mode-cfg))))
	(message "Cannot find avaiable annotation configuration")))))


(defun annotate-region (start-pos end-pos line-count)
  (with-current-buffer
      (let ((mode-cfg (query-cfg-by-mode-name (format "%s" major-mode))))
	(message "Will annotate %d lines" line-count)
	(if (equal 1 line-count)
	    (annotate-current-line mode-cfg)
	  (progn
	    (if (get-suport-block-annotation mode-cfg)
		(progn
		  (goto-char (line-beginning-position))
		  (insert-string (get-begin-block-symbol mode-cfg))
		  (goto-char (line-end-position))
		  (insert-string (get-end-block-symbol mode-cfg)))
	      (progn
		(setq current-line-pos start-pos)
		(dotimes (i line-count)
		  (goto-char current-line-pos)
		  (goto-char (line-beginning-position))
		  (annotate-current-line mode-cfg)
		  (setq current-line-pos (+ 1 (line-end-position))))))
	    ))
	)
    (message "Done!")))

(defun annotate-selection ()
  (interactive)
  (let ((line-count (count-lines (region-beginning) (region-end))))
    (if (<= line-count 1)
	(annotate-region (line-beginning-position) (line-end-position) 1)
      (annotate-region (region-beginning) (region-end) line-count))))

(global-set-key (kbd "M-p") 'annotate-selection)
