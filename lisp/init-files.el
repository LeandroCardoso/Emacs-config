(defun directory-list (path)
  "Find all directories in PATH."
  (when (file-directory-p path)
    (process-lines find-program (expand-file-name path) "-type" "d")))

(defun copy-file-or-buffer-name-as-kill (&optional arg)
  "If the current buffer is a file visited buffer, copy the file
name of the current buffer to the kill ring. With parameter ARG,
copy the full file name path of the current buffer.

If the current buffer is not a file visited buffer, copy the
current buffer name to the kill ring."
  (interactive "P")
  (let ((name (if buffer-file-name
                  (if arg
                      buffer-file-name
                    (file-name-nondirectory buffer-file-name))
                (buffer-name))))
  (kill-new name)
  (message "%s name %s" (if buffer-file-name "File" "Buffer") name)))

(defun copy-file-or-buffer-name-directory-as-kill (&optional arg)
  "If the current buffer is a file visited buffer, copy the
directory component of the current file to the kill ring.

If the current buffer is not a file visited buffer, copy the
current default directory of the current buffer to the kill ring.

With parameter ARG, convert the directory to absolute, and
canonicalize it."
  (interactive "P")
  (let* ((dir (if buffer-file-name
                  (file-name-directory buffer-file-name)
                default-directory))
         (dir-exp (if arg
                      (expand-file-name dir)
                    dir)))
    (kill-new dir-exp)
    (message "Directory %s" dir-exp)))

(defun rename-buffer-and-file ()
  "Rename the current buffer and the file name when it is
visiting a file."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (let ((new-name (read-string "Rename buffer: " (buffer-name))))
          (rename-buffer new-name))
      (let ((new-name (read-file-name "Rename file: " nil nil nil (file-name-nondirectory filename))))
        (if (vc-backend filename)
            (vc-rename-file filename new-name)
          (rename-file filename new-name 1)
          (set-visited-file-name new-name t t))))))

(defun make-backup-buffer ()
  "Make a backup of the disk file visited by the current buffer.
See `backup-buffer'."
  (interactive)
  (if (not (buffer-file-name))
      (message "Buffer %s is not visiting a file" (buffer-name))
    (let ((make-backup-files t)
          (backup-inhibited nil)
          (buffer-backed-up nil))
      (backup-buffer)
      (when buffer-backed-up
        (message "Created backup for buffer %s" (file-name-nondirectory buffer-file-name))))))

;; auto-save
(unless (file-directory-p (concat user-emacs-directory "auto-save"))
  (mkdir (concat user-emacs-directory "auto-save")))
(setq auto-save-file-name-transforms `((".*" ,(concat user-emacs-directory "auto-save/\\1") t)))

;; backup
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq make-backup-files nil)
(setq version-control t)

;; save
(setq save-some-buffers-default-predicate 'save-some-buffers-root)

;; misc
(setq confirm-kill-emacs 'y-or-n-p)
(setq confirm-kill-processes nil)

;; key bindings
(global-set-key (kbd "C-x x w") 'copy-file-or-buffer-name-as-kill)
(global-set-key (kbd "C-x x W") 'copy-file-or-buffer-name-directory-as-kill)
(global-set-key (kbd "C-x x k") 'make-backup-buffer)
(global-set-key (kbd "C-x x r") 'rename-buffer-and-file) ; replace rename-buffer
(global-set-key (kbd "C-x x G") 'revert-buffer-with-fine-grain)
