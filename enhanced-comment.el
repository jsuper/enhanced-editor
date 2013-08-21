;;Enhanced Annotation for Emacs User

(require 'mode-comment-cfg)

(defun comment-current-line (mode-cfg)
  (let ((comment-symbol (get-comment-symbol mode-cfg))
	(support-block-comment (get-support-block-comment mode-cfg)))
    (if comment-symbol
	(progn
	  (goto-char (line-beginning-position))
	  (insert-string comment-symbol))
      (progn
	(if support-block-comment
	    (progn
	      (goto-char (line-beginning-position))
	      (insert-string (get-begin-block-symbol mode-cfg))
	      (goto-char (line-end-position))
	      (insert-string (get-end-block-symbol mode-cfg))))
	(message "Cannot find avaiable annotation configuration")))))


(defun comment-region (start-pos end-pos line-count)
  (let ((mode-cfg (query-cfg-by-mode-name (format "%s" major-mode))))
    (message "Will annotate %d lines" line-count)
    (if (equal 1 line-count)
	(comment-current-line mode-cfg)
      (progn
	(if (get-support-block-comment mode-cfg)
	    (progn
	      (goto-char start-pos)
	      (goto-char (line-beginning-position))
	      (insert-string (get-begin-block-symbol mode-cfg))
	      (goto-char end-pos)
	      (goto-char (line-end-position))
	      (insert-string (get-end-block-symbol mode-cfg)))
	  (progn
	    (setq current-line-pos start-pos)
	    (dotimes (i line-count)
	      (goto-char current-line-pos)
	      (goto-char (line-beginning-position))
	      (comment-current-line mode-cfg)
	      (setq current-line-pos (+ 1 (line-end-position))))
	    ))
	))
    ))

(defun comment-selection ()
  (interactive)
  (let ((line-count (count-lines (region-beginning) (region-end))))
    (if (<= line-count 1)
	(progn
	  (goto-char (region-beginning))
	  (goto-char (line-beginning-position))
	  (comment-region (line-beginning-position) (line-end-position) 1))
      (comment-region (region-beginning) (region-end) line-count))))

(global-set-key (kbd "M-p") 'comment-selection)
