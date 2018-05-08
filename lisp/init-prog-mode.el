(with-eval-after-load 'prog-mode
  (defun font-lock-todo-setup ()
    (font-lock-add-keywords
     nil
     '(("\\<\\(FIXME\\|TODO\\|BUG\\)\\>" 1 font-lock-warning-face t))))

  (add-hook 'prog-mode-hook #'font-lock-todo-setup))


;; functions

(defun smart-semicolon ()
  "Go to end of line, delete trailing whitespace and insert a \";\" unless
one already exists at point."
  (interactive "*")
  (move-end-of-line nil)
  (delete-trailing-whitespace)
  (unless (char-equal (preceding-char) (string-to-char ";"))
    (insert ";")))

(defun electric-semicolon ()
  "Insert a \";\" unless one already exists at point, in this case forward one char."
  (interactive "*")
  (if (char-equal (following-char) (string-to-char ";"))
      (forward-char)
    (insert ";")))

;; key bindings

(define-key prog-mode-map (kbd ";") 'electric-semicolon)
(define-key prog-mode-map (kbd "C-;") 'smart-semicolon)
