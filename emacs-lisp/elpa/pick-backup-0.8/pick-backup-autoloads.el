;;; pick-backup-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (pick-backup-and-view pick-backup-and-revert pick-backup-and-diff
;;;;;;  pick-backup-and-ediff) "pick-backup" "pick-backup.el" (19593
;;;;;;  45377))
;;; Generated autoloads from pick-backup.el

(autoload 'pick-backup-and-ediff "pick-backup" "\
Diff FILE with one of its backups.

\(fn FILE)" t nil)

(autoload 'pick-backup-and-diff "pick-backup" "\
Run Ediff on FILE and one of its backups.

\(fn FILE SWITCHES)" t nil)

(autoload 'pick-backup-and-revert "pick-backup" "\
Replace FILE with one of its backups.

\(fn)" t nil)

(autoload 'pick-backup-and-view "pick-backup" "\
View one of FILE's backups.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("pick-backup-pkg.el") (19593 45377 668596))

;;;***

(provide 'pick-backup-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; pick-backup-autoloads.el ends here
