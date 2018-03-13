(when (require 'diminish nil t)
  (defun set-diminish ()
    (diminish 'abbrev-mode)
    (diminish 'auto-highlight-symbol-mode)
    (diminish 'auto-revert-mode)
    (diminish 'hi-lock-mode)
    (diminish 'highlight-parentheses-mode)
    (diminish 'subword-mode)
    (diminish 'superword-mode)
    (diminish 'yas-minor-mode))

  (add-hook 'after-init-hook 'set-diminish))
