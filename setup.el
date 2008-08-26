(setq home-directory (getenv "HOME"))
(setq shared-profile-home (getenv "SHARED_PROFILE_HOME"))

(if (string= (substring home-directory -1 nil) "/")
    (setq home-directory (substring home-directory nil -1)))

(if (string= (substring shared-profile-home -1 nil) "/")
    (setq shared-profile-home (substring shared-profile-home nil -1)))

(add-to-list 'load-path (concat shared-profile-home "/emacs-lisp/"))
(add-to-list 'load-path (concat shared-profile-home "/emacs-lisp/python-mode/"))
(setq ipython-command (concat home-directory "/bin/ipython"))

;; Put autosave files (ie #foo#) in one place
(defvar autosave-dir
 (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

(defun auto-save-file-name-p (filename)
  (string-match "^#.*#$" (file-name-nondirectory filename)))

(defun make-auto-save-file-name ()
  (concat autosave-dir
   (if buffer-file-name
      (concat "#" (file-name-nondirectory buffer-file-name) "#")
    (expand-file-name
     (concat "#%" (buffer-name) "#")))))

;; Put backup files (ie foo~) in one place too. (The backup-directory-alist
;; list contains regexp=>directory mappings; filenames matching a regexp are
;; backed up in the corresponding directory. Emacs will mkdir it if necessary.)
(defvar backup-dir (concat "/tmp/emacs_backups/" (user-login-name) "/"))

(make-directory backup-dir t)

(setq backup-directory-alist (list (cons "." backup-dir)))

;; python-mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
				   interpreter-mode-alist))

(autoload 'python-mode "python-mode" "Python editing mode." t)

;; ipython mode
(require 'python-mode)
(require 'ipython)

;; css mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))

;; js2 mode
(autoload 'js2-mode "js2")
(setq auto-mode-alist (cons '("\\.js$" . js2-mode) auto-mode-alist))

(put 'upcase-region 'disabled nil)

;; show column number
(setq column-number-mode t)

;; ido mode
(setq ido-enable-flex-matching t)
(ido-mode t)

;; django html mode
(require 'django-html-mode)

;; CUDA stuff
(setq auto-mode-alist (append 
		       '(("\\.cu$" . c++-mode))
		       auto-mode-alist))
