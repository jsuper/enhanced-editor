;;Enhanced Annotation for Emacs User

(require 'enhanced-comment-cfg)
(require 'enhanced-common-function)

(defun comment-current-line (mode-cfg)
  "comment current line"
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
	(message "Cannot find avaiable comment configuration")))))


(defun comment-region (start-pos end-pos line-count)
  "comment selection region, this will include the line which current cursor in"
  (let ((mode-cfg (query-cfg-by-mode-name (format "%s" major-mode))))
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
  "interactive method for key-binding or interactive call"
  (interactive)
  (if (region-active-p)
      (let ((line-count (count-lines (region-beginning) (region-end))))
	(if (<= line-count 1)
	    (progn
	      (goto-char (region-beginning))
	      (goto-char (line-beginning-position))
	      (comment-region (line-beginning-position) (line-end-position) 1))
	  (comment-region (region-beginning) (region-end) line-count)))
    (comment-region (line-beginning-position) (line-end-position) 1)))

(defun uncomment-current-line (comment-cfg)
  "Uncomment current line in buffer"
  (let ((comment-symbol (get-comment-symbol comment-cfg))
	(support-block-comment (get-support-block-comment comment-cfg)))
    (if comment-symbol
	(progn 
	  (goto-char (line-beginning-position))
	  (delete-string-forward comment-symbol (line-end-position) 1))
      (if support-block-comment
	  (let ((begin-symbol (get-begin-block-symbol comment-cfg))
		(end-symbol (get-end-block-symbol comment-cfg)))
	    (goto-char (line-beginning-position))
	    (delete-string-forward begin-symbol (line-end-position) 1)
	    (goto-char (line-end-position))
	    (delete-string-backward end-symbol (line-beginning-position) 1)
	    )
	(message "not found avaiable commentary configuration for current major mode"))
	))
  )

(defun uncomment-region (start-pos end-pos line-count)

  "Uncomment selection area in current buffer"

  (let ((mode-cfg (query-cfg-by-mode-name (format "%s" major-mode))))
    (if (equal 1 line-count)
	(uncomment-current-line mode-cfg)
      (let ((comment-symbol (get-comment-symbol mode-cfg))
	    (support-block-comment (get-support-block-comment mode-cfg)))
	(if support-block-comment
	    (let ((begin-symbol (get-begin-block-symbol mode-cfg))
		  (end-symbol (get-end-block-symbol mode-cfg)))
	      (goto-char start-pos) ;;goto the region start position
	      (delete-string-forward begin-symbol (line-end-position) 1)
	      (goto-char end-pos)
	      (delete-string-backward end-symbol start-pos 1))
	  (progn
	    (goto-char start-pos)
	    (setq symbol-len (length comment-symbol))
	    (dotimes (i line-count)
	      (goto-char (line-beginning-position))
	      (delete-string-forward comment-symbol (line-end-position) 1)
	      (goto-char (+ 1 (line-end-position)))))
	  )))))

(defun uncomment-selection ()
  "interactive uncomment method for interactive call or key-binding"
  (interactive)
  (if (region-active-p)
      (let ((line-count (count-lines (region-beginning) (region-end)))
	    (start-pos (region-beginning))
	    (end-pos (region-end)))
	(goto-char (region-beginning))
	(setq start-pos (line-beginning-position))
	(goto-char end-pos)
	(setq end-pos (line-end-position))
	(if (<= line-count 1)
	    (progn
	      (goto-char (region-beginning))
	      (uncomment-region start-pos end-pos 1))
	  (uncomment-region start-pos end-pos line-count)))
    (uncomment-region (line-beginning-position) (line-end-position) 1)
    ))

(provide 'enhanced-comment)
