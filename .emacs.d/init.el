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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("/Users/kaiyang/Dropbox/org/fitness.org" "/Users/kaiyang/Dropbox/org/journal.org" "/Users/kaiyang/Dropbox/org/interests.org" "/Users/kaiyang/Dropbox/org/stuff.org" "/Users/kaiyang/org/stuff.org" "/Users/kaiyang/org/journal.org" "/Users/kaiyang/org/tasks.org")))
 '(package-selected-packages
   (quote
    (ensime protobuf-mode typescript-mode bazel-mode docker-compose-mode dockerfile-mode use-package company-lsp lsp-ui lsp-mode git-gutter doom-themes doom-modeline))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
