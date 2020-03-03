;; --------------------
;; -- MELPA Settings --
;; --------------------
;; initialize MELPA
(require 'package)
(setq package-enable-at-startup nil)
;; specify MELPA repo
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; --------------------
;; --- Configuration --
;; --------------------
;; load configuration from config.org
(org-babel-load-file "~/.emacs.d/config.org")
