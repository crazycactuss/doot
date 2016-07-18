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
(require 'hlinum)
(hlinum-activate) ;; highlight current linum
(require 'smooth-scrolling) ;; scroll one line at a time
(require 'whitespace) ;; highlight whitespace using faces
(require 'column-marker) ;; highlight column
;; don't really need these next two because tmux
(require 'dired-x) ;; extra features for dired mode
(require 'compile) ;; compile file

(require 'package) ;; MELPA package manager

(ido-mode t) ;; standard ido-mode setup
(menu-bar-mode -1) ;; turn off top menu bar (file, edit, etc)
(normal-erase-is-backspace-mode 0) ;; delete deletes left not right

(show-paren-mode 1) ;; show matching parentheses
(require 'paren)
(set-face-background 'show-paren-match (face-background 'default))
(set-face-foreground 'show-paren-match "#def")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)

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
(setq whitespace-style '(face tabs spaces trailing lines-tail space-before-tab
			      newline indentation empty space-after-tab))
(setq suggest-key-bindings t) ;; suggest key binding when command executed using
                              ;; M-x
(setq vc-follow-symlinks t) ;; follow symlinks w/o messages if target is
                            ;; version-controlled (b/c it's probably git, which
                            ;; doesn't matter
(global-linum-mode 1) ;; show line numbers
(recentf-mode 1) ;; turn on recentf menu
(setq recentf-max-menu-items 25)

;; For reference on dired:
;; See: http://www.gnu.org/software/emacs/manual/html_node/emacs/Dired.html#Dired
(setq dired-isearch-filenames 'dwim) ;; in dired mode, if point is on a filename
                                     ;; then search searches only filenames

;; ---------------------
;; --- CEDET Settings --
;; ---------------------
;; COMMENT/UNCOMMENT the following if you wish to use this instead of irony-mode.
;; irony-mode should be faster since it uses the clang library.)

;; ;; turn on Semantic for CEDET
;; (semantic-mode 1)
;; ;; define func that adds semantic as suggestion backend to auto-complete
;; (defun my:add-semantic-to-autocomplete()
;;   (add-to-list 'ac-sources 'ac-source-semantic))
;; (add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
;; ;; turn on ede mode
;; (global-ede-mode 1)
;; ;; turn on auto reparsing open buffers in semantic during idle emacs
;; (global-semantic-idle-scheduler-mode 1)
;;
;; ;; *************** EDIT PROJECTS FOR CEDET AUTOCOMPLETE HERE ***************
;; (ede-cpp-root-project "my project" :file "~/.emacs.d/test/src/main.cpp"
;;     		         :include-path '("/../my_inc"))
;; ;; can use system-include-path for setting up system header file locations

;; ---------------------
;; --- MELPA Settings --
;; ---------------------
;; initialize MELPA
;; ***** ALL requires for MELPA packages must come after package-initialize
(add-to-list 'package-archives ;; MELPA configuration
	     '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

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
;; -- MELPA  --
;; ------------
;; USING MELPA:
;; To install a package, use {M-x package-install RET <package> RET} or in the
;; *Packages* buffer (activated by {M-x package-list-packages RET}) press i
;; (install) by the package you want to install and press x (execute). To
;; uninstall press d (delete) by the desired package and press x.

;; Some packages are from the "C/C++ Development Environment for Emacs" article
;; See: http://tuhdo.github.io/c-ide.html#sec-2

;; ---------------------
;; -- COMPANY Settings -
;; ---------------------

;; COMMENT/UNCOMMENT the following if you installed and what to use company-mode
;; (as opposed to auto-complete)

;; Turn on company (complete any) mode for all files. May want to change to a
;; hook for a select number of modes (e.g.: c/c++)
(add-hook 'after-init-hook 'global-company-mode)
;; Don't turn on too quickly, like when writing comments. Note that 0.5 sec is
;; the default. 0 or 0.1 will activate very quickly to emulate auto-complete.
(setq company-idle-delay 0.3)
;; Don't put a lower bound on the number of characters. Activate as frequently
;; as possible. Note that it won't activate if the preceding part of the line is
;; all whitespace (if set to 0). Set to 1 so that when writing comments it won't
;; activate before words in the middle of a sentence.
(setq company-minimum-prefix-length 1)

;; Try to get company to complete with TAB key (when appropriate)
;; (global-set-key (kbd "TAB") 'company-complete-common)
;; (defun complete-or-indent ()
;;   (interactive)
;;   (if (company-manual-begin)
;;       (company-complete-common)
;;     (indent-according-to-mode)))
;; (global-set-key (kbd "TAB") 'complete-or-indent)

(global-set-key (kbd "C-c d") 'company-show-doc-buffer)
(global-set-key (kbd "M-RET") 'company-complete-common)

;; **** NOTE: Might want a frontend that inline expands and doesn't show tooltip
;; until navigating is done, like auto-complete. Tried adding
;; company-preview-frontend to company-frontends, but tooltip still appears and
;; looks ugly.
;; See: http://www.emacswiki.org/emacs/CompanyMode

;; END COMPANY

;; Many of these packages are from the video series "Emacs as a C/C++ editor/IDE
;; by user "b yuksel" on youtube.
;; See: https://www.youtube.com/watch?v=HTUE03LnaXA

;; ----------------------------
;; -- auto-complete Settings --
;; ----------------------------

;; COMMENT/UNCOMMENT the following if you installed and what to use auto-complete
;; (as opposed to company-mode)

;; (require 'auto-complete) ;; GNU auto-complete
;; (require 'auto-complete-config) ;; default auto-complete config
;; (ac-config-default)

;; COMMENT/UNCOMMENT the following if you installed and want to use
;; auto-complete-c-headers

;; ;; define func that initializes auto-complete-c-headers and is called for c/c++
;; ;; hooks
;; (defun my:ac-c-header-init ()
;;   (require 'auto-complete-c-headers)
;;   (add-to-list 'ac-sources 'ac-source-c-headers)
;;   (add-to-list 'achead:include-directories '"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1"))
;; ;; call func from c/c++ mode hooks
;; (add-hook 'c++-mode-hook 'my:ac-c-header-init)
;; (add-hook 'c-mode-hook 'my:ac-c-header-init)

;; -------------------
;; -- MISC Settings --
;; -------------------

;; COMMENT/UNCOMMENT the following if you installed and want to use yasnippet

;; (require 'yasnippet)
;; (yas-global-mode 1) ;; turn yasnippet on for all buffers

;; flymake: Highlights in red lines that don't adhere to google style & tells
;; you the error in the echo buffer
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (if (eq system-type 'gnu/linux)
      (custom-set-variables
       '(flymake-google-cpplint-command "/usr/local/bin/cpplint")))
  (if (eq system-type 'darwin)
      (custom-set-variables
       '(flymake-google-cpplint-command "/Users/kaiyang/anaconda/bin/cpplint")))
  (flymake-google-cpplint-load))

;; COMMENT/UNCOMMENT the following if you want lint to be auto-on for all c/c++
;; files

;; (add-hook 'c-mode-hook 'my:flymake-google-init)
;; (add-hook 'c++-mode-hook 'my:flymake-google-init)

;; additional google style stuff (e.g.: indentation)
(require 'google-c-style)

;; COMMENT/UNCOMMENT the following if you want lint to be auto-on for all c/c++
;; files

;; (add-hook 'c-mode-common-hook 'google-set-c-style)
;; (add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; --------------------
;; -- COLOR Settings --
;; --------------------

;; (require 'color-theme)
;; (setq color-theme-is-global t)
;; (color-theme-initialize)

;; (color-theme-solarized) ;; solarized color scheme
;; (setq solarized-termcolors 256) ;; set 256 instead 16 colors (only mac)
;; (set-frame-parameter nil 'background-mode 'light)
;; (set-terminal-parameter nil 'background-mode 'light)
;; (enable-theme 'solarized))

;; emacs Solarized theme FOR LINUX ONLY
;; Need to clone repository: emacs-color-theme-solarized
;; when starting emacs, we get errors about being unable to load colors
;; we can fix this by setting the termcolors to 256, but this messses up
;; the actual colors
(if (eq system-type 'gnu/linux)
    (progn
      (add-to-list 'custom-theme-load-path "~/emacs-color-theme-solarized")
      (load-theme 'solarized t)
      (set-frame-parameter nil 'background-mode 'dark)
      (set-terminal-parameter nil 'background-mode 'dark)
      (enable-theme 'solarized)))

;; NOTE: ON MAC: need osx-terminal.app-colors-solarized color palette for
;;               terminal preferences
;;  ALSO change: menlo regular 12 font w/ 1.01 line spacing
;;               use bold fonts/allow blinking text ON
;;               option key as meta ON

;; change linum color to make line numbers more readable
(set-face-attribute 'linum nil :foreground "#586e75")
 
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
;; (global-set-key (kbd "C-c o") 'eighty-column-mark)
;; (global-set-key (kbd "C-c p") 'column-mark-off)
(global-set-key (kbd "C-c o") 'eighty-column-mark-toggle)
(global-set-key (kbd "C-c j") 'tabify)
(global-set-key (kbd "C-c k") 'untabify)
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "C-c e") 'iedit-mode)
(global-set-key (kbd "C-c g") 'lint-on)
(global-set-key (kbd "C-c r") 'revert-buffer)
;; view mode lets you view a file by screenfuls without editing them.
;; SPC scrolls forward. DEL scrolls backwards. s searchs
(global-set-key (kbd "C-c v") 'view-mode)
(global-set-key (kbd "C-x p") 'package-list-packages)

;; If having problems,
;; See: http://www.emacswiki.org/emacs/BackspaceKey
;; See: https://www.gnu.org/software/emacs/manual/html_node/efaq/Backspace-invokes-help.html
(global-set-key (kbd "C-h") 'backward-delete-char)
(global-set-key (kbd "M-h") 'backward-delete-word)
(global-set-key (kbd "C-x ?") 'help-command) ;; "C-?" fails. Sends ASCII 127?

;; ------------
;; -- Modes  --
;; ------------

;; Octave mode (no longer relevant since matlab)
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

;; OCaml mode
(add-to-list 'load-path "~/.emacs.d/lisp/tuareg-mode")
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)

(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

;; Org mode
(require 'org)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-ct" 'org-todo)
(define-key global-map "\C-cs" 'org-schedule)
(if (eq system-type 'darwin)
    (setq org-agenda-files (list "/Users/kaiyang/Google Drive/org/stuff.org")))
(setq org-log-done t)

;; -----------------
;; -- IRONY Mode  --
;; -----------------

;; COMMENT/UNCOMMENT the following to enable irony-mode (installed via melpa)
;; the melpa version is compatible with company-irony

;; irony mode (c/c++/obj-c autocompletion)
;; See: https://github.com/Sarcasm/irony-mode
;; FOR MAC: You need to first install llvm for libclang and cmake, which are
;;     used for irony-server. Use `brew install llvm --with-clang` and
;;     `brew install cmake`. When you first start irony-mode you need to build
;;     and install irony-server using {M-x irony-install-server RET}. It will
;;     give you a cmake command to execute. Before executing it, you need to
;;     provide the path llvm was installed in by adding the flags:
;;     -DCMAKE_PREFIX_PATH=/usr/local/opt/llvm -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON
;;     After compiling, you need to then set the runtime path for irony-server:
;;     `install_name_tool -change @rpath/libclang.dylib /usr/local/opt/llvm/lib/libclang.dylib ~/.emacs.d/irony/bin/irony-server`
;; See: https://github.com/Sarcasm/irony-mode/issues/167
;; FOR DEBIAN: Install libclang-3.4-dev
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Configure company-irony
(eval-after-load 'company
    '(add-to-list 'company-backends 'company-irony))
;; **** NOTE: Write a .clang_complete in project root directory with include
;; compiler flags to reference other files.

;; END company irony-mode setup

;; COMMENT/UNCOMMENT the following for irony config with the old alpha version
;; this is for compatibility with auto-complete

;; ;; **** IMPORTANT!!!!
;; ;; CHANGES: removed irony installed via MELPA (this led to requiring removing
;; ;; company-irony too since irony didn't exist anymore. Instead, I downloaded
;; ;; irony-mode v0.0.1-alpha, which is identical to the version in yuksel's
;; ;; video series. This version still had irony-enable and the auto-complete
;; ;; plugin built-in. I followed his video directly, with the only differences
;; ;; being instead of explicitly setting LD_LIBRARY path I used install_name_tool.
;; ;; I also used the aforementioned cmake flags to locate llvm, which I installed
;; ;; via brew (instructions detailed in modern version of irony-mode). Also,
;; ;; doxygen was installed via brew instead of port (small difference).
;; ;; **** NOTE: When using this version of irony-mode, you must use {C-c C-b}
;; ;; and press {l} to choose to load a .clang_complete that describes compilation
;; ;; include directories (from gcc include flags)
;; ;; **** NOTE: When you access a file in a newly opened project for this emacs
;; ;; session, you may receive the following error:
;; ;;     Type `C-c C-b' to configure project
;; ;; Just ignore the message. It's a legacy of the old irony-mode-develop code. If
;; ;; it bothers you, do the following:
;; ;;     To see what are the flags sent to the irony-server process you can call
;; ;;     M-: (kill-new (mapconcat 'identity (irony-get-libclang-flags) " ")) RET.
;; ;;     Use C-y in the scratch buffer to paste.
;; ;; and make sure the outputted flags match those in your .clang_complete

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/irony-mode/elisp"))
;; (require 'irony)
;; (irony-enable 'ac) ;; enable ac plugin
;; (defun my:irony-enable()
;;   (when (member major-mode irony-known-modes)
;;     (irony-mode 1)
;;     (irony-cdb-load-clang-complete)))
;; (add-hook 'c++-mode-hook 'my:irony-enable)
;; (add-hook 'c-mode-hook 'my:irony-enable)

;; ;; configure irony for auto-complete (dependency ac-irony.el)
;; ;; **** NOTE: irony-mode documentation says to install ac-irony via MELPA, but
;; ;; it doesn't exist in the package database. ac-irony didn't exist in yuksel's
;; ;; video series, and it hasn't been updated in two years. Maybe deprecated?
;; ;; Instead, I downloaded ac-irony.el directly from its github.
;; ;; See: https://github.com/Sarcasm/ac-irony
;; ;; **** RESULT: ac-irony isn't really maintained anymore. Author favors company
;; ;; so you should use company-irony. HOWEVER, the code is complete enough. Refer
;; ;; below for usage.
;; ;; See: https://github.com/Sarcasm/ac-irony/issues/1
;; ;; See: https://github.com/Sarcasm/ac-irony#status
;; ;; For a comparison of auto-complete and company,
;; ;; See: https://github.com/company-mode/company-mode/issues/68
;; (require 'ac-irony)

;; ;; (defun my-ac-irony-setup ()
;; ;;   ;; be cautious, if yas is not enabled before (auto-complete-mode 1), overlays
;; ;;   ;; *may* persist after an expansion.
;; ;;   (yas-minor-mode 1)
;; ;;   (auto-complete-mode 1)
;; ;;   (add-to-list 'ac-sources 'ac-source-irony)
;; ;;   (define-key irony-mode-map (kbd "TAB") 'ac-complete-irony-async))

;; ;; **** NOTE: ac-irony github suggested the previous setup function, but I think
;; ;; all we need is to add ac-source-irony to ac-sources. ac-complete-irony-async
;; ;; starts completion manually. This is useful for if you don't have any prefix
;; ;; at all to complete with (e.g.: a method). Company will be able to detect
;; ;; member accesses automatically (while not activating if it's the beginning
;; ;; of a line). However, I like the inline expansion of auto-complete better and
;; ;; not showing the tooltip until needed.
;; ;; **** NOTE: auto-complete is a little weird though. Depending on if you call
;; ;; ac-complete-irony-async, it might not show documentation as auto-complete
;; ;; normally would.

;; (defun my-ac-irony-setup ()
;;   (add-to-list 'ac-sources 'ac-source-irony)
;;   (define-key irony-mode-map (kbd "M-RET") 'ac-complete-irony-async))
;; (add-hook 'irony-mode-hook 'my-ac-irony-setup)

;; END auto-complete irony-mode setup

;; --------------------------------
;; -- MAC-SPECIFIC CONFIGURATION --
;; --------------------------------

(if (eq system-type 'darwin)
    (progn
      ;; Rust emacs mode. Check out https://github.com/rust-lang/rust-mode and then
      ;;     change the load path to its location
      (add-to-list 'load-path "/Users/kaiyang/rust-mode/")
      (autoload 'rust-mode "rust-mode" nil t)
      (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
      (require 'opencl-mode)
      (add-to-list 'auto-mode-alist '("\\.cl\\'" . opencl-mode))

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
      )
)
