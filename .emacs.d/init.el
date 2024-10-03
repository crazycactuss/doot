;; --------------------
;; -- MELPA Settings --
;; --------------------
;; specify MELPA repo
(require 'package)
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
 '(org-journal-find-file-fn #'find-file nil nil "Customized with use-package org-journal")
 '(package-selected-packages
   '(magit solaire-mode org-bullets yaml-mode which-key use-package undo-tree smooth-scrolling pkg-info php-mode org-journal neotree markdown-mode lua-mode hungry-delete hlinum form-feed flycheck expand-region exec-path-from-shell doom-themes doom-modeline deft counsel-projectile column-enforce-mode centaur-tabs auto-package-update all-the-icons ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "#282c34" :foreground "#bbc2cf" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "nil" :family "Fira Code Retina"))))
 '(fixed-pitch ((t (:family "Fira Code Retina"))))
 '(org-document-title ((t (:foreground "#c678dd" :weight bold :height 2.25))))
 '(org-done ((t (:strike-through nil :weight bold :height 120))))
 '(org-headline-done ((t (:foreground "#5B6268" :height 120))))
 '(org-headline-todo ((t (:foreground "Pink2" :height 120))))
 '(org-level-1 ((t (:height 2.0 :weight normal :slant normal :extend nil :inherit outline-1))))
 '(org-level-2 ((t (:height 1.75 :weight normal :slant normal :extend nil :inherit outline-2))))
 '(org-level-3 ((t (:height 1.5 :weight normal :slant normal :extend nil :inherit outline-3))))
 '(org-level-4 ((t (:height 1.25 :weight normal :slant normal :extend nil :inherit outline-4))))
 '(org-level-5 ((t (:height 1.1 :weight normal :slant normal :extend nil :inherit outline-5))))
 '(org-todo ((t (:foreground "#98be65" :weight bold :height 120)))))
