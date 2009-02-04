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

;; make comint act more like ipython shell
(require 'comint)
(define-key comint-mode-map [(meta p)]
  'comint-previous-matching-input-from-input)
(define-key comint-mode-map [(meta n)]
  'comint-next-matching-input-from-input)
(define-key comint-mode-map [(control meta n)]
   'comint-next-input)
(define-key comint-mode-map [(control meta p)]
   'comint-previous-input)


;; git stuff
(require 'git)
(add-to-list 'vc-handled-backends 'GIT)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

(define-key ctl-x-map "g" 'git-status)

;; ipython
(require 'ipython)

;; clojure stuff
(if (getenv "CLOJURE_JAR")
    (progn
      (add-to-list 'load-path (concat shared-profile-elisp "swank-clojure/"))
      (add-to-list 'load-path (concat shared-profile-elisp "clojure-mode/"))
      (setq swank-clojure-jar-path (getenv "CLOJURE_JAR"))
      (if (getenv "CLOJURE_CLASSPATH")
          (setq swank-clojure-extra-classpaths (list (getenv "CLOJURE_CLASSPATH"))))
      (if (getenv "CLOJURE_LIBRARY_PATH")
          (setq swank-clojure-library-paths (list (getenv "CLOJURE_LIBRARY_PATH"))))
      (if (getenv "CLOJURE_VM_ARGS")
          (setq swank-clojure-extra-vm-args (split-string (getenv "CLOJURE_VM_ARGS") " ")))
      (require 'clojure-auto)
      (require 'swank-clojure-autoload)
      (require 'slime)
      (slime-setup)))

;; paren mode
(show-paren-mode 1)

;; objective-c stuff

(setq auto-mode-alist
      (cons '("\\.m$" . objc-mode) auto-mode-alist))
(setq auto-mode-alist
      (cons '("\\.mm$" . objc-mode) auto-mode-alist))

(defun xcode-compile ()
  (interactive)
  (let ((df (directory-files "."))
        (has-proj-file nil)
        )
    (while (and df (not has-proj-file))
      (let ((fn (car df)))
        (if (> (length fn) 10)
            (if (string-equal (substring fn -10) ".xcodeproj")
                (setq has-proj-file t)
              )
          )
        )
      (setq df (cdr df))
      )
    (if has-proj-file
        (compile "xcodebuild -configuration Debug")
      (compile "make")
      )
    )
  )

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
(add-hook 'python-mode-hook 'show-ws-highlight-tabs)
(add-hook 'python-mode-hook 'show-ws-highlight-trailing-whitespace)
(define-key ctl-x-map "t" 'untabify)
(setq-default indent-tabs-mode nil)

;; tab indent or expand

(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding
point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (dabbrev-expand arg)
    (indent-according-to-mode)))
 
(defun my-tab-fix ()
  (local-set-key [tab] 'indent-or-expand))
 
;; add hooks for modes you want to use the tab completion for:
(add-hook 'python-mode-hook          'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)
