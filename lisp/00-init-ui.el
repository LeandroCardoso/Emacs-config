;; functions
(defun split-window-sensibly-horizontally (&optional window)
  "Split WINDOW in a way suitable for `display-buffer'.
WINDOW defaults to the currently selected window.

Replacement for `split-window-sensibly', but perfers
`split-width-threshold' over `split-height-threshold'."
  (let ((window (or window (selected-window))))
    (or (and (window-splittable-p window t)
	     ;; Split window vertically.
	     (with-selected-window window
	       (split-window-right)))
	(and (window-splittable-p window)
	     ;; Split window horizontally.
	     (with-selected-window window
	       (split-window-below)))
	(and (eq window (frame-root-window (window-frame window)))
	     (not (window-minibuffer-p window))
	     ;; If WINDOW is the only window on its frame and is not the
	     ;; minibuffer window, try to split it vertically disregarding
	     ;; the value of `split-height-threshold'.
	     (let ((split-height-threshold 0))
	       (when (window-splittable-p window)
		 (with-selected-window window
		   (split-window-below))))))))

;; No need to waste precious desktop space with useless GUI
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; Font
(let ((font (cond
             ((eq system-type 'gnu/linux) '("Source Code Pro" . "11"))
             ((eq system-type 'windows-nt) '("Consolas" . "10")))))
  (if (member (car font) (font-family-list))
      (set-frame-font (concat (car font) " " (cdr font)) t t)
    (message "Warning: Font %s does not exist" (car font))))


;; Theme
(when (require 'monokai-theme nil t)
  (setq monokai-use-variable-pitch nil)
  (load-theme 'monokai t)
  (set-face-attribute 'cursor nil :background (face-foreground 'mode-line-buffer-id))
  (set-face-attribute 'fringe nil :foreground "dark slate gray")) ;; dim gray is also a good option

;; faces.el - must be after the theme
(set-face-attribute 'bold-italic nil :inherit '(bold italic))
(set-face-attribute 'italic nil :underline t)

;; frame.el - some settings like cursor-type must be set after the theme
(setq initial-frame-alist '((fullscreen . maximized) (cursor-type . bar)))
(setq default-frame-alist initial-frame-alist)
(setq window-system-default-frame-alist '((x . ((alpha . 97)))))
;; disable cursor blink
(blink-cursor-mode -1)

;; fullscreen and scroll bars are bugged when a new frame is created. The following code workaround
;; these bugs.
(defun set-frame-settings (FRAME)
  (sleep-for 0.1) ; I need this sleep to fullscreen works properly in Windows
  (modify-frame-parameters FRAME '((vertical-scroll-bars . nil) (fullscreen . maximized))))

(setq after-make-frame-functions 'set-frame-settings)

;; window.el
(setq split-height-threshold nil)
(setq split-width-threshold 200)
(setq split-window-preferred-function 'split-window-sensibly-horizontally)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "C-x M-o") 'other-frame)
(global-set-key (kbd "C-c -") 'shrink-window) ;; default is backward-page
(global-set-key (kbd "C-c +") 'enlarge-window) ;; default is forward-page

;; scroll
(global-set-key (kbd "M-<up>") 'scroll-down-line)
(global-set-key (kbd "M-p") 'scroll-down-line)
(global-set-key (kbd "M-<down>") 'scroll-up-line)
(global-set-key (kbd "M-n") 'scroll-up-line)
