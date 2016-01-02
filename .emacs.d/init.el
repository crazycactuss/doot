;; -*- mode: emacs-lisp -*-
;; Simple .emacs configuration

;; ---------------------
;; -- Global Settings --
;; ---------------------
(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'cl) ;; common lisp
(require 'ido) ;; standard C-x C-b buffer stuff
(require 'ffap) ;; file finding autocomplete
(require 'uniquify) ;; unique buffers if identical filenames
(require 'ansi-color) ;; interpret ansi color escape sequences
(require 'recentf) ;; recent files menu
(require 'linum) ;; line numbers
(require 'smooth-scrolling) ;; scroll one line at a time
(require 'whitespace) ;; highlight whitespace using faces
(require 'column-marker) ;; highlight column
;; don't really need these next two because tmux
(require 'dired-x) ;; extra features for dired mode
(require 'compile) ;; compile file

(ido-mode t) ;; standard ido-mode setup
(menu-bar-mode -1) ;; turn off top menu bar (file, edit, etc)
(normal-erase-is-backspace-mode 0) ;; delete deletes left not right

;; NOTE: put lets you define a value of a member of a symbol's propery list.
;; To enable a symbol you set the 'disabled value to nil.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; NOTE: (setq <thing> ...) is equivalent to (set '<thing> ...). Symbols are
;; always quoted.
(setq column-number-mode t) ;; display column number on bottom info bar
(setq inhibit-startup-message t) ;; don't display emacs startup message
(setq save-abbrevs nil) ;; don't automatically save newly defined abbreviations
                        ;; upon emacs exit
(setq show-trailing-whitespace t) ;; highlight whitespace at end of lines when
                                  ;; point is not there

;; set whitespace style
(setq whitespace-style '(tabs spaces trailing lines-tail space-before-tab
			      newline indentation empty space-after-tab
			      space-mark tab-mark newline-mark))
(setq suggest-key-bindings t) ;; suggest key binding when command executed using
                              ;; M-x
(setq vc-follow-symlinks t) ;; follow symlinks w/o messages if target is
                            ;; version-controlled (b/c it's probably git, which
                            ;; doesn't matter
(global-linum-mode 1) ;; show line numbers
(recentf-mode 1) ;; turn on recentf menu
(setq recentf-max-menu-items 25)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit autoface-default :strike-through nil :underline nil
			 :slant normal :weight normal :height 120 :width normal
			 :family "monaco"))))
 '(column-marker-1 ((t (:background "red"))))
 '(diff-added ((t (:foreground "cyan"))))
 '(flymake-errline ((((class color) (background light)) (:background "Red"))))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background light))
			    (:foreground "red"))))
 '(fundamental-mode-default ((t (:inherit default))))
 '(highlight ((((class color) (min-colors 8))
	       (:background "white":foreground "magenta"))))
 '(isearch ((((class color) (min-colors 8))
	     (:background "yellow" :foreground "black"))))
 '(linum ((t (:foreground "black" :weight bold))))
 '(region ((((class color) (min-colors 8))
	    (:background "white" :foreground "magenta"))))
 '(secondary-selection ((((class color) (min-colors 8))
			 (:background "gray" :foreground "cyan"))))
 '(show-paren-match ((((class color) (background light))
		      (:background "black"))))
 '(vertical-border ((t nil)))
 )

;; ------------
;; -- Macros --
;; ------------
(load "defuns-config.el")
(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "M-=") 'align-equals)
(global-set-key (kbd "C-x C-m") 'execute-extended-command)
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-n") 'next5)
(global-set-key (kbd "M-p") 'prev5)
(global-set-key (kbd "C-v") 'scroll-up-and-recenter)
(global-set-key (kbd "M-v") 'scroll-down-and-recenter)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-i") 'back-window)
(global-set-key (kbd "M-d") 'delete-word)
(global-set-key (kbd "C-c w") 'whitespace-mode)
(global-set-key (kbd "C-c i") 'tf-toggle-show-trailing-whitespace)
(global-set-key (kbd "C-c o") 'eighty-column-mark)
(global-set-key (kbd "C-c p") 'column-mark-off)
(global-set-key (kbd "C-c j") 'tabify)
(global-set-key (kbd "C-c k") 'untabify)
(global-set-key (kbd "C-z") nil)

;; If having problems,
;; See: http://www.emacswiki.org/emacs/BackspaceKey
;; See: https://www.gnu.org/software/emacs/manual/html_node/efaq/Backspace-invokes-help.html
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key "\M-h" 'backward-delete-word)
(global-set-key (kbd "C-x ?") 'help-command) ;; "C-?" fails. Sends ASCII 127?

;; ------------
;; -- Modes  --
;; ------------

;; Octave mode
;; (autoload 'octave-mode "octave-mod" nil t)
;; (setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))
;; (add-hook 'octave-mode-hook
;; 	  (lambda ()
;; 	    (abbrev-mode 1)
;; 	    (auto-fill-mode 1)
;; 	    (if (eq window-system 'x)
;; 		(font-lock-mode 1))))

;; Web mode (i.e.: php w/ embedded html)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))

;; Rust emacs mode. Check out https://github.com/rust-lang/rust-mode and then
;;     change the load path to its location
(add-to-list 'load-path "/Users/kaiyang/rust-mode/")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;; Matlab mode
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

(defun my-matlab-mode-hook ()
  (setq matlab-function-indent t); if you want function bodies indented
  (setq fill-column 76); where auto-fill should wrap
  (font-lock-mode 1)
  (turn-on-auto-fill)
  ;; (if (not running-xemacs)
  (matlab-mode-hilit)
  ;;   )
  )
(setq matlab-mode-hook 'my-matlab-mode-hook)

(defun my-matlab-shell-mode-hook ()
  (setq matlab-function-indent t); if you want function bodies indented
  (setq fill-column 76); where auto-fill should wrap
  (font-lock-mode 1)
  )
(setq matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; OCaml mode
(add-to-list 'load-path "~/.emacs.d/lisp/tuareg-mode")
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)

(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))
