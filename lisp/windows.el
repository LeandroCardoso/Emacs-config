(set-frame-font "Consolas 10" t t)

(setq backup-directory-alist '(("." . "c:/DBDProj/backup")))
(setq auto-save-file-name-transforms '((".*" "c:/DBDProj/auto-save/" t)))

(setenv "PATH" "c:\\Windows\\System32")

;; root directories are added in the beggining
(add-unix-root-dir "c:\\msys32\\mingw32")
(add-unix-root-dir "c:\\msys32")

;; proxy
(setq url-proxy-services '(("http" . "localhost:3128")
                           ("https" . "localhost:3128")))

;; this is more efficient
(setq magit-process-connection-type nil)

;; flycheck
;; launch external process is slow in Windows, so we don't want to use the new-line option
(setq flycheck-check-syntax-automatically '(save idle-change mode-enable))

;; spell
(setenv "DICPATH" "c:\\msys32\\local\\dicts")
(setenv "DICTIONARY" "en_US")

;; this is a very recommended setup
(setq w32-pipe-read-delay 0)

(setenv "GTAGSFORCECPP")

;; MS VS
(require 'find-file)
(add-to-list 'auto-mode-alist '("msbuild[0-9]*\\.log\\'" . compilation-mode))
(add-to-list 'cc-search-directories "C:\\Program Files\\Microsoft SDKs\\Windows\\v7.1A\\Include" t)
(add-to-list 'cc-search-directories "C:\\Program Files\\Microsoft Visual Studio 12.0\\VC\\include" t)
(add-to-list 'cc-search-directories "C:\\Program Files\\Microsoft Visual Studio 12.0\\VC\\include\\*" t)

(setenv "PATH"
  (concat
   "C:\\Users\\santosl4\\Documents\\bin;"
   "C:\\Users\\santosl4\\Documents\\script;"
   "C:\\Program Files\\Microsoft Visual Studio 12.0\\Common7\\Tools;"
   "C:\\Program Files\\Microsoft Visual Studio 12.0\\Common7\\IDE;"
   (getenv "PATH")))

(add-to-list 'grep-files-aliases '("proj" . "*.sln *.vcxproj *.vcxproj.filters *.msbuild") t)
(add-to-list 'grep-files-aliases
             '("chproj" .
               "*.h *.hpp *.hxx *.c *.cpp *.cxx *.sln *.vcxproj *.vcxproj.filters *.msbuild")
             t)

(add-to-list 'tags-table-list "c:/DBDProj/TAGS.MS-SDK")
(add-to-list 'tags-table-list "c:/DBDProj/TAGS.VC")


;; Hooks
(defun my-xml-hook ()
  (setq indent-tabs-mode (not (string-match-p "\\.vcxproj" (buffer-name))))
  (setq indent-tabs-mode (not (string-match-p "\\.msbuild" (buffer-name)))))

(add-hook 'nxml-mode-hook 'my-xml-hook)

;; Variables
(setq mydrive "F:/")


;; Functions

;; TODO use thing-at-point as default query string
(defun msdn-search (QUERY)
  "Query MSDN for the QUERY string parameter"
  (interactive "sQuery string: ")
  (browse-url
   (concat "https://duckduckgo.com/?q=!ducky+"
           QUERY
           "+site:msdn.microsoft.com")))

;; TODO use thing-at-point as default query string
(defun cppreference (QUERY)
  "Query MSDN for the QUERY string parameter"
  (interactive "sQuery string: ")
  (browse-url
   (concat "https://duckduckgo.com/?q=!cppr+"
           QUERY)))

(defun shell-bash ()
  "Run bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "bash"))
    (call-interactively 'shell)))

(defun xfs-start (&optional ARG)
  "Start the Diebold XFS windows service.
  nil or 0 : start
  1 : stop
  2 : restart"
  (interactive "P")
  (message
   (cond
    ((or (null ARG) (= ARG 0)) "Starting XFS")
    ((= ARG 1) "Stoping XFS")
    ((= ARG 2) "Restarting XFS")))
  (w32-service-start "Diebold XFS" ARG))


(defun xfs-stop()
  "Stop the Diebold XFS windows service."
  (interactive)
  (xfs-start 1))


(defun xfs-restart()
  "Restart the Diebold XFS windows service."
  (interactive)
  (xfs-start 2))


(defun ami-start (&optional ARG)
  "Start the Diebold XFS and Devices Service windows service.
  nil or 0 : start
  1 : stop
  2 : restart"
  (interactive "P")
  (message
   (cond
    ((or (null ARG) (= ARG 0)) "Starting AMI")
    ((= ARG 1) "Stoping AMI")
    ((= ARG 2) "Restarting AMI")))
  (w32-service-start "Diebold Devices Service" ARG))


(defun ami-stop()
  "Stop the Diebold XFS and Devices Service windows service."
  (interactive)
  (ami-start 1))


(defun ami-restart()
  "Restart the Diebold XFS and Devices Service windows service."
  (interactive)
  (ami-start 2))

;; TODO save in .dir-locals.el
;; add-dir-local-variable

(defun project-set-directory (ROOT_DIR BIN_DIR)
  "Set project directories"
  (setq proj_root ROOT_DIR)
  (set-variable 'proj_bin (concat ROOT_DIR BIN_DIR))
  (require 'find-file)
  (add-to-list 'cc-search-directories (concat ROOT_DIR "/*/*/*/*/*/*") t)
  (add-to-list 'tags-table-list (concat ROOT_DIR "/TAGS"))
  (setq company-clang-arguments (concat "-I. -I" ROOT_DIR "/*/*/*")))


(defun opteva-cc-set-project (DIR)
  "Set Opteva ClearCase project directories"
  (interactive "DOpteva project root source dir: ")
  (setq compile-command "build.cmd 10 Release Build")
  (project-set-directory DIR "/XFSOPT_SRC/Src/Src/bin/Release/"))


(defun opteva-tfs-set-project (DIR)
  "Set Opteava TFS project directories"
  (interactive "DOpteva project solution source dir: ")
  (setq compile-command
        (concat "build.cmd 10 Release Build " (convert-standard-filename DIR)))
  (project-set-directory DIR "bin/Release/"))


(defun odyssey-set-project (DIR)
  "Set Odyssey project directories"
  (interactive "DOdyssey project solution source dir: ")
  (setq compile-command
        (concat "build.cmd 12 Release Build " (convert-standard-filename DIR)))
  (project-set-directory DIR "/bin/Release/"))


(defun directory-backup (DIR)
  "Copy .dll and .exe files from DIR to DIR/backup
Don't overwrite files from previous backup"
  (setq BACKUP_DIR (concat DIR "\\backup"))
  (when (file-exists-p DIR)
    (unless (file-exists-p BACKUP_DIR)
      (make-directory BACKUP_DIR))
    (dolist (SRC_FILE (directory-files DIR t "dll$")) (ignore-errors (copy-file SRC_FILE BACKUP_DIR nil t)))
    (dolist (SRC_FILE (directory-files DIR t "exe$")) (ignore-errors (copy-file SRC_FILE BACKUP_DIR nil t)))))


(defun ami-backup ()
  "Backup AMI exe/dll files"
  (interactive)
  (directory-backup "C:\\Program Files\\Diebold\\AMI"))


(defun xfs-backup ()
  "Backup AMI exe/dll files"
  (interactive)
  (directory-backup "C:\\Program Files\\Diebold\\AgilisXFS\\bin"))


(defun directory-restore (DIR)
  "Copy .dll and .exe files from DIR/backup to DIR.
Delete .pbd files from DIR"
  (setq BACKUP_DIR (concat DIR "\\backup"))
  (when (file-exists-p BACKUP_DIR)
    (dolist (SRC_FILE (directory-files BACKUP_DIR t "dll$")) (with-demoted-errors (copy-file SRC_FILE DIR t t)))
    (dolist (SRC_FILE (directory-files BACKUP_DIR t "exe$")) (with-demoted-errors (copy-file SRC_FILE DIR t t)))
    (dolist (TARGET_FILE (directory-files DIR t "pdb$")) (with-demoted-errors (delete-file TARGET_FILE)))))


(defun ami-restore()
  "Restore AMI exe/dll files from previous backup"
  (interactive)
  (directory-restore "C:\\Program Files\\Diebold\\AMI"))


(defun xfs-restore()
  "Restore XFS exe/dll files from previous backup"
  (interactive)
  (directory-restore "C:\\Program Files\\Diebold\\AgilisXFS\\bin"))


(defun directory-install (DIR TARGET_DIR)
  "Copy files .dll and .exe files from DIR to TARGET_DIR if they exist in the TARGET_DIR
Copy .pdb files from DIR to TARGET_DIR if a .dll or .exe with the same base name was copied"
  (when (file-exists-p TARGET_DIR)
    (dolist (FILE (directory-files DIR nil "\\(dll\\|exe\\)$"))
      (when (file-exists-p (concat TARGET_DIR "\\" FILE))
        (message "Coping file %s" (concat DIR "\\" FILE))
        (with-demoted-errors (copy-file (concat DIR "\\" FILE) TARGET_DIR t t))
        (setq PDB_FILE (replace-regexp-in-string "\\(dll\\|exe\\)$" "pdb" FILE t))
        (when (file-exists-p (concat DIR "\\" PDB_FILE))
          (with-demoted-errors (copy-file (concat DIR "\\" PDB_FILE) TARGET_DIR t t))
          (message "Coping file %s" (concat DIR "\\" PDB_FILE)))))
    (message "Done")))


(defun ami-install ()
  "Copy files from Release binary directory to AMI installation directory"
  (interactive)
  (if (not (boundp 'proj_bin))
      (error "Project not set. Use project-set-dir")
    (if (w32-service-running "Diebold Devices Service")
        (progn
          (ami-stop)
          (directory-install proj_bin "C:\\Program Files\\Diebold\\AMI")
          (ami-start))
      (directory-install proj_bin "C:\\Program Files\\Diebold\\AMI"))))


(defun xfs-install ()
  "Copy files from Release binary directoy to XFS installation directory"
  (interactive)
  (if (not (boundp 'proj_bin))
      (error "Project not set. Use project-set-dir")
    (if (w32-service-running "Diebold XFS")
        (progn
          (xfs-stop)
          (directory-install proj_bin "C:\\Program Files\\Diebold\\AgilisXFS\\bin")
          (xfs-start))
      (directory-install proj_bin "C:\\Program Files\\Diebold\\AgilisXFS\\bin"))))


(defun project-copy-bin-to-drive ()
  "Copy binary files to pen-drive"
  (interactive)
  (if (or (not (boundp 'proj_bin)) (not mydrive))
      (error "Project not set. Use odyssey-set-project or opteva-set-project")
    (progn
      (when (file-exists-p mydrive)
        (when (file-exists-p (concat mydrive "/Release")) (delete-directory (concat mydrive "/Release") t))
        (copy-directory proj_bin mydrive)))))


(defun insert-tag-comment (&optional ARG)
  "Insert a comment in the form (TAG) using the TAG set by `set-tag-comment'.
`comment-indent' is used to the indent.
if ARG is provided then call interactively `set-tag-comment'."
  (interactive "*P")
  (when (or ARG (null (boundp 'tag-comment)))
    (call-interactively 'set-tag-comment))
  (comment-indent)
  (insert "(" tag-comment ")"))


(defun set-tag-comment (TAG)
  "Set the TAG comment to be used by `insert-tag-comment'.
TAG comment becomes buffer local."
  (interactive "sEnter TAG comment: ")
  (setq-local tag-comment TAG))


(defun delete-readme (DIRECTORY)
  "delete all Readme_XXX.html files in DIRECTORY and its subdirectories"
  (interactive "DRoot directory: ")
  (with-output-to-temp-buffer "*delete files*"
    (dolist (FILE (find-lisp-find-files DIRECTORY "^Readme_[A-Z0-9]*\\.html$"))
      (prin1 FILE)
      (terpri)
      (delete-file FILE t)
      )))


;; keybindings
(global-set-key (kbd "<f5>") 'xfs-install)
(global-set-key (kbd "C-c 1") 'insert-tag-comment)

;; Modes
(define-generic-mode
    'xfs-form-mode ;; name
  '("//") ;; comments list
  '( ;; keywords list
    "ACCESS"
    "ALIGNMENT"
    "BARCODE"
    "CASE"
    "CLASS"
    "COERCIVITY"
    "COLOR"
    "COMMENT"
    "COPYRIGHT"
    "CPI"
    "FOLLOWS"
    "FONT"
    "FOOTER"
    "FORMAT"
    "HEADER"
    "HORIZONTAL"
    "INDEX"
    "INITIALVALUE"
    "KEYS"
    "LANGUAGE"
    "LPI"
    "ORIENTATION"
    "OVERFLOW"
    "POINTSIZE"
    "POSITION"
    "POSITIONONX"
    "POSITIONONY"
    "PRINTAREA"
    "RESTRICTED"
    "RGBCOLOR"
    "SCALING"
    "SIDE"
    "SIZE"
    "SKEW"
    "STYLE"
    "TITLE"
    "TYPE"
    "UNIT"
    "USERPROMPT"
    "VERSION"
    "VERTICAL"
    )
  '(("BEGIN\\|END" . 'font-lock-type-face)
    ("XFSFORM\\|XFSSUBFORM\\|XFSFIELD" . 'font-lock-function-name-face))
  '("\\Form.*\.txt$") ;; auto mode list
  nil ;; function list
  )
