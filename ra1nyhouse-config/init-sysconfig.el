;; turn on highlight matching brackets when cursor is on one
(show-paren-mode 1)

(setq make-backup-files nil) ; stop creating backup~ files
;; (setq auto-save-default nil) ; stop creating #autosave# files

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

(provide 'init-sysconfig)
