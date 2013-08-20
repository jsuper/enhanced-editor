;; Enhanced Annotation Configuration Data

(setq mode-annotation-cfg
      '(
	(:name "emacs-lisp-mode"
	       :support-block-annotation nil
	       :annotation-symbol ";")
	(:name "java-mode"
	       :support-block-annotation t
	       :annotation-symbol "//"
	       :begin-block-symbol "/*"
	       :end-block-symbol "*/")
	(:name "xml-mode"
	       :support-block-annotation t
	       :begin-block-symbol "<!--"
	       :end-block-symbol "-->")
	))

(defun --mode-name-selector (mode-name)
  #'(lambda (mode-cfg)
      (equal (getf mode-cfg :name) mode-name)))

(defun --query-mode-cfg (selector-fn)
  (remove-if-not selector-fn mode-annotation-cfg))

(defun query-cfg-by-mode-name (mode-name)
  (first (--query-mode-cfg (--mode-name-selector mode-name))))

(defun get-annotation-symbol (mode-cfg)
  (getf mode-cfg :annotation-symbol))

(defun get-suport-block-annotation (mode-cfg)
  (getf mode-cfg :support-block-annotation))

(defun get-begin-block-symbol (mode-cfg)
  (getf mode-cfg :begin-block-symbol))

(defun get-end-block-symbol (mode-cfg)
  (getf mode-cfg :end-block-symbol))

(provide 'mode-annotation-cfg)

