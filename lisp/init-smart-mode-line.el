(when (require 'smart-mode-line nil t)
  (require 'rich-minority nil t)
  
  (setq sml/theme nil)
  (setq sml/col-number-format "%c")
  (setq sml/name-width '(20 . 50))
  (setq sml/no-confirm-load-theme t)
  ;; (setq sml/pos-minor-modes-separator "]")
  ;; (setq sml/pre-modes-separator " [")
  (setq sml/shorten-mode-string "")
  (setq sml/show-file-name nil)
  (setq sml/vc-mode-show-backend t)
  (set-face-attribute 'sml/filename nil :inherit '(sml/global mode-line-buffer-id) :weight 'bold)
  ;; TODO (require 'project)
  (add-to-list 'sml/replacer-regexp-list '(".*" (lambda (str)
                                                  (if (project-name)
                                                      (concat ":" (project-name) ":")
                                                    (match-string 0 str)))) t)

  (setq rm-whitelist (mapconcat 'identity '("company-.*") "\\|"))
  
  (smart-mode-line-enable))
