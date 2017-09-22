(bind-keys*
;; 下一个窗口
("<f12>" . other-window) ; 等价于C-x o

;; 使得C-2 等价于 C-@
;; ("C-2" . set-mark-command)

;; 放大窗口纵向, C-x + 恢复
("<f5>" . enlarge-window)
;; 放大窗口横向
("<f6>" . enlarge-window-horizontally)

("M-p" . backward-paragraph)
("M-n" . forward-paragraph)

;; 关闭回车自动缩进
("<f11>" . electric-indent-local-mode)

)

(provide 'cus-keybind)
