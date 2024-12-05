(when (require 'which-key nil t)
  (setq which-key-idle-secondary-delay 0)
  (setq which-key-max-description-length 50)
  (setq which-key-sort-order 'which-key-local-then-key-order)
  (define-key help-map (kbd "M-x") 'which-key-show-top-level)
  (define-key help-map (kbd "M-X") 'which-key-show-major-mode)
  (which-key-mode))
