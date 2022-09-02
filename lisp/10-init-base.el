(setq frame-resize-pixelwise t)
(setq highlight-nonselected-windows t)
(setq ring-bell-function 'ignore)
(setq use-short-answers t)

;; help.el
(setq describe-bindings-outline t)

;; help-fns.el
(setq help-enable-symbol-autoload t)

;; minibuffer
(setq completions-detailed t)
(setq minibuffer-beginning-of-buffer-movement t)
(setq minibuffer-default-prompt-format " [%s]")
(setq minibuffer-eldef-shorten-default t)
(setq minibuffer-message-clear-timeout t)
(minibuffer-depth-indicate-mode)
;; ESC key toogle the minibuffer
(global-set-key (kbd "<escape>") 'execute-extended-command)
(define-key minibuffer-local-map (kbd "<escape>") 'keyboard-escape-quit)

;; mouse.el
(context-menu-mode)

;; novice.el
(setq disabled-command-function nil)

;; simple.el
(setq completion-show-help nil)
(setq eval-expression-print-length nil)
(setq goto-line-history-local t)
(setq next-error-message-highlight t)
(setq shift-select-mode nil)
(setq what-cursor-show-names t)

;; startup.el
(setq initial-scratch-message nil)
(setq inhibit-startup-screen t)

;; paragraphs.el
(setq sentence-end-double-space nil)

;; so-long
(global-so-long-mode)

;; key bindings
(global-set-key (kbd "C-M-<escape>") 'keyboard-quit)

;; iso-transl - This is required for dead keys work in linux
(require 'iso-transl)

;; Set coding system to utf-8
(set-language-environment "UTF-8")

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Force unix EOL in emacs-lisp files outside of unix
(modify-coding-system-alist 'file "\\.el\\'" 'prefer-utf-8-unix)

;; Hack to set the major mode automatically with new buffers not associated with a file
;; http://thread.gmane.org/gmane.emacs.devel/115520/focus=115794
(setq-default major-mode
              (lambda () (if buffer-file-name
                             (fundamental-mode)
                           (let ((buffer-file-name (buffer-name)))
                             (set-auto-mode)))))

(defmacro make-interactive (symbol)
  "Make the function named SYMBOL interactive"
  (advice-add symbol :before '(lambda (&rest r) "Make this function interactive." (interactive))))
