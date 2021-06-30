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
   '(terraform-mode centaur-tabs go-mode which-key use-package undo-tree typescript-mode smooth-scrolling protobuf-mode org-journal org-cliplink neotree magit lsp-ui iedit hungry-delete hlinum form-feed flycheck expand-region exec-path-from-shell ensime elpy eldoc-eval ein dumb-jump doom-themes doom-modeline dockerfile-mode docker-compose-mode deft counsel-projectile company-lsp bazel-mode ace-window)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(highlight-indentation-face ((t (:background "gray25")))))
(put 'narrow-to-region 'disabled nil)
