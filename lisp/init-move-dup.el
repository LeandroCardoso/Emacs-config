(when (require 'move-dup nil t)
  (global-set-key (kbd "<M-down>") 'md-move-lines-down)
  (global-set-key (kbd "M-n") 'md-move-lines-down)
  (global-set-key (kbd "<M-up>") 'md-move-lines-up)
  (global-set-key (kbd "M-p") 'md-move-lines-up))
