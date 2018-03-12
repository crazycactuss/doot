(defun next10()
  (interactive)
  (next-line 10))

(defun prev10()
  (interactive)
  (previous-line 10))

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

(setq show-column-marker 'nil)
(defun column-mark-toggle ()
  "Toggle marker for column 120"
  (interactive)
  (if show-column-marker
      (progn
        (message "column 120 marker OFF")
        (column-marker-1 -2))
    (progn
      (message "column 120 marker ON")
      (column-marker-1 120)))
  (setq show-column-marker (not show-column-marker)))

(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
