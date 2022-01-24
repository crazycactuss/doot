;; --------------------
;; -- MELPA Settings --
;; --------------------
;; specify MELPA repo
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

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
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(highlight-indentation-face ((t (:background "gray25"))))
 '(org-document-title ((t (:foreground "#c678dd" :weight bold :height 2.0))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :extend nil :height 1.25))))
 '(org-level-3 ((t (:inherit outline-3 :extend nil :height 1.1)))))
