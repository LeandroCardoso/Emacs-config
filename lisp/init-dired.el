(with-eval-after-load "dired"
  (setq dired-dwim-target t)
  (setq dired-isearch-filenames 'dwim)

  ;; function adapted from `backup-buffer'
  (defun dired-do-backup (&optional arg)
    "Make a backup of the marked (or next ARG) files.
See `backup-buffer'."
    (interactive)
    (mapc (lambda (buffer-file-name)
            (let ((attributes (file-attributes buffer-file-name)))
              (when (and attributes (memq (aref (elt attributes 8) 0) '(?- ?l)))
                ;; If specified name is a symbolic link, chase it to the target.
                ;; This makes backups in the directory where the real file is.
                (let* ((real-file-name (file-chase-links buffer-file-name))
                       (backup-info (find-backup-file-name real-file-name)))
                  (when backup-info
                    (let* ((backupname (car backup-info))
                           (targets (cdr backup-info))
                           (old-versions
                            ;; If have old versions to maybe delete,
                            ;; ask the user to confirm now, before doing anything.
                            ;; But don't actually delete til later.
                            (and targets
                                 (booleanp delete-old-versions)
                                 (or delete-old-versions
                                     (y-or-n-p
                                      (format "Delete excess backup versions of %s? "
                                              real-file-name)))
                                 targets))
                           (modes (file-modes buffer-file-name))
                           (extended-attributes
                            (file-extended-attributes buffer-file-name))
                           (copy-when-priv-mismatch
                            backup-by-copying-when-privileged-mismatch)
                           (make-copy
                            (or file-precious-flag backup-by-copying
                                ;; Don't rename a suid or sgid file.
                                (and modes (< 0 (logand modes #o6000)))
                                (not (file-writable-p
                                      (file-name-directory real-file-name)))
                                (and backup-by-copying-when-linked
                                     (< 1 (file-nlinks real-file-name)))
                                (and (or backup-by-copying-when-mismatch
                                         (and (integerp copy-when-priv-mismatch)
                                              (let ((attr (file-attributes
                                                           real-file-name
                                                           'integer)))
                                                (<= (nth 2 attr)
                                                    copy-when-priv-mismatch))))
                                     (not (file-ownership-preserved-p real-file-name
                                                                      t)))))
                           setmodes)
                      (condition-case ()
                          (progn
                            ;; Actually make the backup file.
                            (if make-copy
                                (backup-buffer-copy real-file-name backupname
                                                    modes extended-attributes)
                              ;; rename-file should delete old backup.
                              (rename-file real-file-name backupname t)
                              (setq setmodes (list modes extended-attributes
                                                   backupname)))
                            (setq buffer-backed-up t)
                            ;; Now delete the old versions, if desired.
                            (dolist (old-version old-versions)
                              (delete-file old-version)))
                        (file-error nil))
                      setmodes))))))
          (dired-get-marked-files nil arg))
    (revert-buffer))


  (defun dired-eww-open-file ()
    "In Dired, render the file on this line using EWW"
    (interactive)
    (eww-open-file (dired-get-file-for-visit)))

  (make-interactive dired-move-to-filename)

  ;; local keys
  (define-key dired-mode-map (kbd "<M-return>") 'dired-up-directory)
  (define-key dired-mode-map (kbd "C-=") 'dired-compare-directories)
  (define-key dired-mode-map (kbd "M-m") 'dired-move-to-filename)
  (define-key dired-mode-map (kbd "<tab>") 'dired-next-line)
  (define-key dired-mode-map (kbd "<backtab>") 'dired-previous-line)
  (define-key dired-mode-map (kbd "K") 'dired-do-backup)
  (define-key dired-mode-map (kbd "E") 'dired-eww-open-file)

  (with-eval-after-load "wdired"
    (define-key wdired-mode-map (kbd "M-m") 'dired-move-to-filename)))

;; global keys
(global-set-key (kbd "C-x M-d") 'find-name-dired)

(autoload 'dired-jump "dired-x"
  "Jump to Dired buffer corresponding to current buffer." t)

(autoload 'dired-jump-other-window "dired-x"
  "Like \\[dired-jump] (dired-jump) but in other window." t)

(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-x 4 C-j") 'dired-jump-other-window)
