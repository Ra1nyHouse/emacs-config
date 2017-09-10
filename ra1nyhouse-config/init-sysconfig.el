;; turn on highlight matching brackets when cursor is on one
(show-paren-mode 1)

;; 当文件修改时，不备份，不产生~文件~
(setq make-backup-files nil)

;; 自动保存文件，但是直接保持到当前文件，不产生#文件#
(setq auto-save-default t)
(setq auto-save-visited-file-name t)

;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))

;; 显示行号最好不要全局都激活
;; (global-linum-mode t)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'js-mode-hook 'linum-mode)
(add-hook 'css-mode-hook 'linum-mode)
(add-hook 'html-mode-hook 'linum-mode)
(add-hook 'nxml-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'linum-mode)
(setq linum-format "%4d|")

;; 切换到上一个buffer
;; (global-set-key (kbd "<f11>") 'previous-buffer)

;; 切换到下一个buffer
;; (global-set-key (kbd "<f12>") 'next-buffer)

;; 下一个窗口
(global-set-key (kbd "<f12>") 'other-window) ; 等价于C-x o

;; 使得C-2 等价于 C-@
(global-set-key (kbd "C-2") 'set-mark-command)

;; 放大窗口纵向, C-x + 恢复
(global-set-key (kbd "<f5>") 'enlarge-window)
;; 放大窗口横向
(global-set-key (kbd "<f6>") 'enlarge-window-horizontally)

;; 激活linux x11 剪切板
(setq x-select-enable-clipboard t)

;; 加强版矩形编辑 实际上的多行编辑
(cua-selection-mode t)
(global-set-key (kbd "C-c RET") 'cua-set-rectangle-mark)

(provide 'init-sysconfig)
