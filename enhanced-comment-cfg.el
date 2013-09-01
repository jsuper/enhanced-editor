;; Enhanced Annotation Configuration Data

(setq mode-comment-cfg
      '(
	(:name "emacs-lisp-mode"
	       :support-block-comment nil
	       :comment-symbol ";")
	(:name "lisp-interaction-mode"
	       :support-block-comment nil
	       :comment-symbol ";"
	       )
	(:name "java-mode"
	       :support-block-comment t
	       :comment-symbol "//"
	       :begin-block-symbol "/*"
	       :end-block-symbol "*/")
	(:name "nxml-mode"
	       :support-block-comment t
	       :begin-block-symbol "<!--"
	       :end-block-symbol "-->")
	))

(defun --mode-name-selector (mode-name)
  #'(lambda (mode-cfg)
      (equal (getf mode-cfg :name) mode-name)))

(defun --query-mode-cfg (selector-fn)
  (remove-if-not selector-fn mode-comment-cfg))

(defun query-cfg-by-mode-name (mode-name)
  (first (--query-mode-cfg (--mode-name-selector mode-name))))

(defun get-comment-symbol (mode-cfg)
  (getf mode-cfg :comment-symbol))

(defun get-support-block-comment (mode-cfg)
  (getf mode-cfg :support-block-comment))

(defun get-begin-block-symbol (mode-cfg)
  (getf mode-cfg :begin-block-symbol))

(defun get-end-block-symbol (mode-cfg)
  (getf mode-cfg :end-block-symbol))

(provide 'enhanced-comment-cfg)
