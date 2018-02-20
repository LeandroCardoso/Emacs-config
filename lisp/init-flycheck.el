(when (require 'flycheck nil t)
  (setq flycheck-check-syntax-automatically '(save idle-change mode-enabled))
  (setq flycheck-completing-read-function 'ido-completing-read)
  (setq flycheck-idle-change-delay 3)
  (setq flycheck-mode-line-prefix nil)
  ;; TODO customize flycheck-mode-line. See flycheck-mode-line-status-text
  )
