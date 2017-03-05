;; turn on highlight matching brackets when cursor is on one
(show-paren-mode 1)

;; 当文件修改时，不备份，不产生~文件~
(setq make-backup-files nil)

;; 自动保存文件，但是直接保持到当前文件，不产生#文件#
(setq auto-save-default t)
(setq auto-save-visited-file-name t)

;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))

;; enable line numbers globally
(global-linum-mode t)
(setq linum-format "%4d| ")

;; 切换到上一个buffer
;; (global-set-key (kbd "<f11>") 'previous-buffer)

;; 切换到下一个buffer
;; (global-set-key (kbd "<f12>") 'next-buffer)

;; 下一个窗口
(global-set-key (kbd "<f12>") 'other-window) ; 等价于C-x o

;; 使得C-2 等价于 C-@
(global-set-key (kbd "C-2") 'set-mark-command)

(provide 'init-sysconfig)
