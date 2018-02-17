(when (require 'diminish nil t)
  (defun set-diminish ()
    (diminish 'abbrev-mode)
    (diminish 'auto-revert-mode)
    (diminish 'company-mode)
    (diminish 'subword-mode)
    (diminish 'superword-mode)
    (diminish 'yas-minor-mode))

  (add-hook 'after-init-hook 'set-diminish)
  )
