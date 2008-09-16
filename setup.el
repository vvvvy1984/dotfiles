(setq home-directory (getenv "HOME"))
(setq shared-profile-home (getenv "SHARED_PROFILE_HOME"))
(setq shared-profile-elisp (concat shared-profile-home "/emacs-lisp/"))

(if (string= (substring home-directory -1 nil) "/")
    (setq home-directory (substring home-directory nil -1)))

(if (string= (substring shared-profile-home -1 nil) "/")
    (setq shared-profile-home (substring shared-profile-home nil -1)))

(add-to-list 'load-path shared-profile-elisp)
(add-to-list 'load-path (concat shared-profile-elisp "python-mode/"))
(add-to-list 'load-path (concat shared-profile-elisp "git/"))
(add-to-list 'load-path (concat shared-profile-elisp "slime/"))
(add-to-list 'load-path (concat shared-profile-elisp "swank-clojure/"))
(add-to-list 'load-path (concat shared-profile-elisp "clojure-mode/"))

(setq swank-clojure-jar-path (getenv "CLOJURE_JAR"))

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

;; git stuff

(require 'git)
(add-to-list 'vc-handled-backends 'GIT)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(define-key ctl-x-map "g" 'git-status)

;; python-mode
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))

(autoload 'python-mode "python-mode" "Python editing mode." t)

;; ipython mode
(require 'comint)
(define-key comint-mode-map [(meta p)]
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(meta n)]
  'comint-next-matching-input-from-input)
(define-key comint-mode-map [(control meta n)]
   'comint-next-input)
(define-key comint-mode-map [(control meta p)]
   'comint-previous-input)

;; clojure stuff
(require 'clojure-auto)
(require 'swank-clojure-autoload)
(require 'slime)
(slime-setup)

;; TODO: make this take advantage of virtual env
(setq ipython-command (concat home-directory "/bin/ipython"))
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

;; show me the time
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; show me whitespace, allow to untabify
(require 'show-wspace)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-tabs)
(add-hook 'font-lock-mode-hook 'show-ws-highlight-trailing-whitespace)
(define-key ctl-x-map "t" 'untabify)
(setq-default indent-tabs-mode nil)
