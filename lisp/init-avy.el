(when (require 'avy nil t)
  (setq avy-all-windows nil)
  (global-set-key (kbd "C-M-;") 'avy-goto-word-or-subword-1)
  (global-set-key (kbd "<C-dead-acute>") 'avy-goto-word-or-subword-1)
  )
