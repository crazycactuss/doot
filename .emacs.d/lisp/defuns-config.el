;; --------------------
;; -- Global defuns ---
;; --------------------
(defun next5()
  (interactive)
  (next-line 5))

(defun prev5()
  (interactive)
  (previous-line 5))

(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With argument, do this that many times.
http://www.emacswiki.org/emacs/BackwardDeleteWord
"
  (interactive "p")
  (delete-word (- arg)))

(defun back-window ()
  (interactive)
  (other-window -1))

(defun whitespace-cleanup-all ()
  (interactive)
  (setq indent-tab-mode nil)
  (whitespace-cleanup))

(defun whitespace-clean-and-compile ()
  "Cleans up whitespace and compiles. The compile-command is a
varies with the active mode."
  (interactive)
  (whitespace-cleanup-all)
  (compile compile-command))

(defvar real-keyboard-keys
  '(("M-<up>"        . "\M-[1;3A")
    ("M-<down>"      . "\M-[1;3B")
    ("M-<right>"     . "\M-[1;3C")
    ("M-<left>"      . "\M-[1;3D")
    ("C-<return>"    . "\C-j")
    ("C-<delete>"    . "\M-[3;5~")
    ("C-<up>"        . "\M-[1;5A")
    ("C-<down>"      . "\M-[1;5B")
    ("C-<right>"     . "\M-[1;5C")
    ("C-<left>"      . "\M-[1;5D"))
  "An assoc list of pretty key strings
and their terminal equivalents.")

(defun key (desc)
  (or (and window-system (read-kbd-macro desc))
      (or (cdr (assoc desc real-keyboard-keys))
	  (read-kbd-macro desc))))

(defun tf-toggle-show-trailing-whitespace ()
  "Toggle show-trailing-whitespace between t and nil"
  (interactive)
    (setq show-trailing-whitespace (not show-trailing-whitespace)))

(defun scroll-up-and-recenter ()
  "Scroll up and recenter"
  (interactive)
  (scroll-up-command)
  (recenter))

(defun scroll-down-and-recenter ()
  "Scroll down and recenter"
  (interactive)
  (scroll-down-command)
  (recenter))

(setq show-eighty-column-marker 'nil)
(defun eighty-column-mark-toggle ()
  "Toggle marker for column 80"
  (interactive)
  (if show-eighty-column-marker
      (progn
	(message "column 80 marker OFF")
	(column-marker-1 -2))
    (progn
      (message "column 80 marker ON")
      (column-marker-1 80)))
  (setq show-eighty-column-marker (not show-eighty-column-marker)))
;; (defun eighty-column-mark ()
;;   "Turn on marker for column 80"
;;   (interactive)
;;   (message "column 80 marker ON")
;;   (column-marker-1 80))

;; (defun column-mark-off ()
;;   "Turn off column markers"
;;   (interactive)
;;   (message "column markers OFF")
;;   (column-marker-1 -2))

(defun lint-on ()
  "Turn google lint on"
  (interactive)
  (message "google lint ON")
  (my:flymake-google-init)
  (google-set-c-style)
  (google-make-newline-indent))
