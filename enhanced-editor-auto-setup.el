
;; key-binding for enhanced editor

(require 'enhanced-comment)

(global-unset-key (kbd "C-/"))
(global-unset-key (kbd "C-\\"))

(global-set-key (kbd "C-/") 'comment-selection)
(global-set-key (kbd "C-\\") 'uncomment-selection)



(provide 'enhanced-auto-setup)
