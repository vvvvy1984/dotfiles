(set-language-environment "UTF-8")

(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'load-path "~/.emacs.d/")

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

;; espresso mode and mozrepl
;(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
;(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)
;(add-hook 'espresso-mode-hook 'espresso-custom-setup)
;(defun espresso-custom-setup ()
;  (moz-minor-mode 1))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; show column number
(setq column-number-mode t)

;; ido mode
(setq ido-enable-flex-matching t)
(ido-mode t)

;; paredit mode
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook (lambda () (paredit-mode +1)))

;; django html mode
(require 'django-html-mode)

;; CUDA stuff
(setq auto-mode-alist (append
                       '(("\\.cu$" . c++-mode))
                       auto-mode-alist))

;; puppet stuff
(autoload 'puppet-mode "puppet-mode" 
  "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))


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
(add-hook 'python-mode-hook     'my-tab-fix)
(add-hook 'sh-mode-hook         'my-tab-fix)
(add-hook 'emacs-lisp-mode-hook 'my-tab-fix)
(add-hook 'clojure-mode-hook    'my-tab-fix)

;; Org Mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; log4j mode
(autoload 'log4j-mode "log4j-mode" "Major mode for viewing log files." t)
(add-to-list 'auto-mode-alist '("\\.log\\'" . log4j-mode))

;; PML for PragProg
(add-to-list 'auto-mode-alist '("\\.pml$" . nxml-mode))

;; Textile mode
(require 'textile-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-mode))


;; color theme
(require 'color-theme)

(load-file "~/.emacs.d/color-theme-cosmin.el")

(eval-after-load "color-theme"
  (progn
    (setq color-theme-is-global nil)
    (when (window-system)
       ; needed for the first frame
      (color-theme-cosmin))))
 
(add-hook 'after-make-frame-functions
          '(lambda (f)
             (with-selected-frame f
               (if (window-system f)
                   (color-theme-cosmin)))))

(setq-default ispell-program-name "aspell")

(defvar idle-timer nil)

(defun real-auto-save (secs)
  (setq idle-timer (run-with-idle-timer secs t save-buffer)))

(defun cancel-auto-save ()
  (cancel-timer idle-timer))

;; Pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)

;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")


(require 'tramp)
(tramp-set-completion-function "ssh"
                               '((tramp-parse-sconfig "/etc/ssh_config")
                                 (tramp-parse-sconfig "~/.ssh/config")))
