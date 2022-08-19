(when (require 'company nil t)
  (setq company-format-margin-function 'company-text-icons-margin)
  (setq company-lighter-base "comp")
  (setq company-search-regexp-function 'company-search-flex-regexp)
  (setq company-selection-wrap-around t)
  (setq company-show-quick-access t)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-margin 2)
  (setq company-tooltip-minimum-width 32)
  (setq company-transformers '(company-sort-by-occurrence))

  (company-tng-mode)

  ;; dabbrev
  (setq company-dabbrev-char-regexp "\\sw\\|_\\|-")
  (setq company-dabbrev-downcase nil)
  (setq company-dabbrev-ignore-case t)
  ;; Enable mixing of major-modes like c and c++ modes
  (setq company-dabbrev-code-other-buffers 'code)

  ;; dabbrev code
  (setq company-dabbrev-code-everywhere t)

  ;; etags
  (setq company-etags-everywhere t)

  ;; gtags
  (setq company-gtags-insert-arguments nil)

  ;; In Windows company-gtags-executable is set with the full path to global executable - this is
  ;; great, but does not work. Set it to just "global" fix it.
  (when (eq system-type 'windows-nt)
    (setq company-gtags-executable "global"))

  ;; keymap
  (define-key prog-mode-map (kbd "<tab>") 'company-indent-or-complete-common)
  (define-key text-mode-map (kbd "<tab>") 'company-indent-or-complete-common)

  (with-eval-after-load "org"
    (define-key org-mode-map (kbd "<C-tab>") 'company-complete)
    ;; Workaround to avoid the redefinition of <tab>
    (define-key org-mode-map (kbd "<tab>") 'org-cycle))

  (with-eval-after-load "shell"
    (define-key shell-mode-map (kbd "<tab>") 'company-complete))

  (add-hook 'eshell-mode-hook
            (lambda () (define-key eshell-mode-map (kbd "<tab>") 'company-complete)))

  ;; company-active-map
  (define-key company-active-map (kbd "<escape>") 'company-abort)
  (define-key company-active-map (kbd "<return>") 'company-complete-selection)
  (define-key company-active-map (kbd "<next>") 'company-next-page)
  (define-key company-active-map (kbd "C-v") 'company-next-page)
  (define-key company-active-map (kbd "<prior>") 'company-previous-page)
  (define-key company-active-map (kbd "M-v") 'company-previous-page)

  ;; company-search-map
  (define-key company-search-map (kbd "<escape>") 'company-search-abort)

  (global-company-mode)

  (when (require 'company-flx nil t)
    (company-flx-mode +1))

  (when (require 'company-c-headers nil t)
    (add-to-list 'company-backends 'company-c-headers)))
