;; Inspired by: https://github.com/keith/evil-tmux-navigator/blob/master/navigate.el

(defun tmux-navigate (direction)
  (let
    ((cmd (concat "windmove-" direction)))
      (condition-case nil
          (funcall (read cmd))
        (error
          (tmux-command direction)))))

(defun tmux-command (direction)
  (shell-command-to-string
    (concat "tmux select-pane -"
      (tmux-direction direction))))

(defun tmux-direction (direction)
  (upcase
    (substring direction 0 1)))
