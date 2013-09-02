;; key-binding for enhanced editor
(require 'enhanced-comment)
(setq enhanced-comment-mode-list '("emacs-lisp-mode"
				   "lisp-interaction-mode"
				   "java-mode"
				   "nxml-mode"))

(defun enhanced-comment-key-binding ()
  (local-unset-key (kbd "C-/"))
  (local-unset-key (kbd "C-\\"))
  (local-set-key (kbd "C-/") 'comment-selection)
  (local-set-key (kbd "C-\\") 'uncomment-selection))

(defun enhanced-comment-key-setup ()
  (dolist (mode-name enhanced-comment-mode-list)
    (add-hook (intern (format "%s-hook" mode-name)) 
	      'enhanced-comment-key-binding)))

(defun enhanced-editor-setup ()
  (interactive)
  (enhanced-comment-key-setup))

;;ensure initial
(enhanced-editor-setup)
(provide 'enhanced-editor-setup)
