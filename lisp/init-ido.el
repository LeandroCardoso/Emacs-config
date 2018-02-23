(ido-mode t)
(ido-everywhere t)

(when (require 'ido-completing-read+ nil t)
  (ido-ubiquitous-mode t))

(when (require 'flx-ido nil t)
  (flx-ido-mode t)
  ;; disable ido faces to see flx highlights.
  (setq ido-use-faces nil)
  ;; decrease the value of flx-ido-threshold to speed it up
  (setq flx-ido-threshold 1000))

(when (require 'crm-custom nil t)
  (crm-custom-mode t))

(setq ido-auto-merge-work-directories-length -1)
(setq ido-create-new-buffer 'always)
(setq ido-decorations
      '(" { " " }" " | " " | +" "" "" " [No match]" "" " [Not readable]" " [Too big]" " [Confirm]" " [" "]"))
(setq ido-default-buffer-method 'selected-window)
(setq ido-enable-flex-matching t)
(setq ido-show-dot-for-dired t)
(setq ido-use-filename-at-point 'guess)
(setq ido-use-url-at-point t)

;; Enable ido in dired commands
(put 'dired-do-copy   'ido nil)
(put 'dired-do-rename 'ido nil)
