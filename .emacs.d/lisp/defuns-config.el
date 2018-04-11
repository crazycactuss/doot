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

(fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
