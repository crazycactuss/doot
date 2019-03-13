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
 '(package-selected-packages
   (quote
    (company-lsp flycheck lsp-ui ein lsp-mode git-gutter dumb-jump ace-window which-key use-package undo-tree smooth-scrolling neotree magit iedit hungry-delete hlinum expand-region doom-themes doom-modeline counsel-projectile avy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0)))))
