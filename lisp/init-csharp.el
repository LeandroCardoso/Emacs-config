;; csharp
(with-eval-after-load "csharp-mode"
  (define-key csharp-mode-map (kbd "C-c C-o") 'omnisharp-mode)

  ;; omnisharp
  (with-eval-after-load "omnisharp"
    (setq omnisharp-imenu-support t)
    (setq omnisharp-server-executable-path (concat user-emacs-directory "omnisharp/OmniSharp.exe"))

    ;; omnisharp + company
    (with-eval-after-load "company"
      (add-to-list 'company-backends 'company-omnisharp))

    (defun omnisharp-setup-hook ()
      ;; keymap
      (define-key omnisharp-mode-map (kbd "M-.") 'omnisharp-find-implementations)
      (define-key omnisharp-mode-map (kbd "C-x 4 .") 'omnisharp-go-to-definition-other-window))

    (add-hook 'omnisharp-mode-hook #'omnisharp-setup-hook)))
