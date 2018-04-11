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

(global-set-key
            (kbd "C-M-h")
            (lambda ()
              (interactive)
              (tmux-navigate "left")))
(global-set-key
            (kbd "C-M-j")
            (lambda ()
              (interactive)
              (tmux-navigate "down")))
(global-set-key
            (kbd "C-M-k")
            (lambda ()
              (interactive)
              (tmux-navigate "up")))
(global-set-key
            (kbd "C-M-l")
            (lambda ()
              (interactive)
              (tmux-navigate "right")))
