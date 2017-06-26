(with-eval-after-load "magit"
  ;; settings
  (setq magit-completing-read-function 'magit-ido-completing-read)

  ;; Windows specific settings
  (when (eq system-type 'windows-nt)
    (setq w32-pipe-read-delay 0)
    (setq magit-process-connection-type nil)
    (setq magit-refresh-status-buffer nil)
    (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
    (remove-hook 'server-switch-hook 'magit-commit-diff)))

;; unset compose-mail keys to use it with magit
(global-unset-key (kbd "C-x m"))   ;; compose-mail
(global-unset-key (kbd "C-x 4 m")) ;; compose-mail-other-window
(global-unset-key (kbd "C-x 5 m")) ;; compose-mail-other-frame

;; keymap
(defvar magit-global-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map "m" 'magit-dispatch-popup)
    (define-key map "f" 'magit-file-popup)
    (define-key map "s" 'magit-status)
    (define-key map "i" 'magit-init)
    (define-key map "c" 'magit-clone)
    map)
  "Keymap for global magit commands")

(defalias 'magit-global-keymap magit-global-keymap)
(global-set-key (kbd "C-x m") 'magit-global-keymap)
