;; 修改为wombat
;; (load-theme 'wombat t)

;; 修改主题和状态栏，文件在ra1nyhouse-download里
;; (setq molokai-theme-kit t)
;; (load-theme 'molokai t)
;; (require 'house-new-mode-line)

;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn t)
;;   )

;; (use-package material-theme
;;   :ensure t
;;   :config
;;   (load-theme 'material t)
;;   )

(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t)
  (custom-set-faces
    '(linum ((t (:inherit default :background "#232526" :foreground "#8F908A" :underline nil))))
   '(mode-line ((t (:inherit default :background "#404045" :foreground "#F5F5F5" :box (:line-width 1 :color "#474747" :style unspecified))))))
   )

;; 棕红色背景，在图形界面表现好，在命令行表现一般
;; (use-package birds-of-paradise-plus-theme
;;   :ensure t
;;   :config
;;   (require 'birds-of-paradise-plus-theme)
;;   ;;(load-theme 'birds-of-paradise-plus t)
;;   )

;; 使用helm,扩展M-x功能
(use-package helm
  :ensure t
  :demand
  :bind (
	 ("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-buffers-list)
	 ("C-c j" . helm-imenu)
	 ;; :map helm-buffer-map
	 ;; ("C-k" . helm-buffer-run-kill-buffers)
	 )
  :config
  (require 'helm-config)
  (require 'helm-mode) ;; 不引入的话直接执行c-x c-f会报错
  (require 'helm-buffers)
  (bind-keys :map helm-buffer-map ("C-k" . helm-buffer-run-kill-buffers))
  (setq helm-autoresize-max-height 38)
  (setq helm-autoresize-min-height 18)
  (helm-autoresize-mode 1)
  )

(use-package helm-swoop
  :ensure t
  ;; :demand
  :bind (
	 ("C-s" . helm-swoop)
	 )
  )

(use-package helm-projectile
  :ensure t
  ;; :demand
  :bind (
  	 ("C-c p" . helm-projectile)
  	 )
  :config
  (helm-projectile-on)
  ;; (bind-key "C-c p" 'helm-projectile)
  )
;; helm-themes不是主题，只是显示当前所有安装主题
;; 如有异常，删除emacs-custom.el文件
;; (use-package helm-themes
;;     :ensure t
;;     )

;; (use-package helm-ag
;;   :ensure t  
;;  )

;; ivy划分为ivy,swiper,counsel三个包，counsel依赖前两个
;; 测试了，功能和helm重复，速度更快，但是没有helm强大
;; swiper是isearch很好的替代品，推荐使用
;; counsel 是ivy模式的增强版

;; 使用swiper替换isearch
;; 设置ivy-mode开启，使用C-x k 时候很方便
;; (use-package counsel
;;   :ensure t
;;   :demand
;;   :bind (("C-s" . swiper)
;; 	 ("M-x" . counsel-M-x)
;; 	 ("C-x C-f" . counsel-find-file)
;; 	 ("C-c g" . counsel-git)
;; 	 ("C-c j" . counsel-git-grep)
;; 	 )
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq enable-recursive-minibuffers t)
;;   )


;; 语法检测,比 elpy 的 flymake 好用很多，能自动提示函数参数
;; (use-package flycheck
;;   :ensure t
;;   :config
;;   (when (require 'flycheck nil t)
;;     (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;     (add-hook 'elpy-mode-hook 'flycheck-mode))
;;   )

;; python模式
;; (use-package elpy
;;   :ensure t
;;   ;; :demand
;;   :bind (
;; 	 :map elpy-mode-map
;; 	 ("C-c C-k" . elpy-shell-kill)
;; 	)
;;   :config
;;   (elpy-enable)
;;   (custom-set-variables '(elpy-rpc-backend "jedi"))
;;   :pin elpy
;;   )

;; *****************改进

;; 要放在 elpy 之前
(use-package flycheck
  :ensure t
  :config
  )

(use-package elpy
  :ensure t
  :demand
  :config
  (elpy-enable)
  (bind-key "C-c C-k" 'elpy-shell-kill elpy-mode-map)
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  (custom-set-variables '(elpy-rpc-backend "jedi"))
)


;; snippet代码片段,被 elpy 依赖
(use-package yasnippet
  :ensure t
  :config
  (require 'yasnippet)
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/ra1nyhouse-snippets")
  ;; (yas-global-mode 1)
 )


;; 自动补全
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  )


;; 目录树
(use-package neotree
  :ensure t
  :bind ([f9] . neotree-toggle)
  )

;; 支持gist，需要配置
;; git config --global github.user <your-github-user-name> eg:ra1nyhouse
;; git config --global github.oauth-token <your-personal-access-token-with-gist-scope>

;; (use-package gist
;;   :ensure t
;;   :config (require 'gist)
;;   )

;; 彩虹括号
(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )

;; markdown
;; 命令行需要安装Multimarkdown软件,osx: brew install multimarkdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; 使用github api生成html，如果本地没装multimarkdown可以使用
;; (use-package gh-md
;;   :ensure t
;;   :commands (gh-md-render-region gh-md-render-buffer)
;;   )

;; 多行编辑 有cua mark支持，多行编辑需求不大
;; (use-package multiple-cursors
;;   :ensure t
;;   :bind (([f1] . mc/mark-next-like-this)
;; 	 ("C-<" . mc/mark-previous-like-this))
;;   )

;; 将烦人的弹出提示框设置成popwin，使用C-g关闭
(use-package popwin
  :ensure t
  :config
  (popwin-mode 1)
  (push "*Warnings*" popwin:special-display-config)
  (push "*Flycheck error messages*" popwin:special-display-config)
 )

;; 自定义模式栏显示内容
;; (use-package diminish
;;   :ensure t
;;   :config
;;   (require 'diminish)
;;   (diminish 'ivy-mode)
;;   )


;; undotree 不好用，从粘贴板复制大数据时因为创建树结构会卡顿
;; (use-package undo-tree
;;   :ensure t
;;   :demand
;;   :config
;;   (require 'undo-tree)
;;   (global-undo-tree-mode)
;;   )

(use-package ace-jump-mode
  :ensure t
  :bind(("C-c SPC" . ace-jump-mode))
  )

(use-package cuda-mode
  :ensure t
  )

;;实现与系统剪切板互通，需要安装xsel软件，目前在linux下可用
;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(unless window-system
  (when (getenv "DISPLAY")
    ;; 获取平台名字"Linux" or "Darwin"
    (defvar my-platform (shell-command-to-string "uname"))
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
	(insert text)
	;; I prefer using the "clipboard" selection (the one the
	;; typically is used by c-c/c-v) before the primary selection
	;; (that uses mouse-select/middle-button-click)
	(if (equal my-platform "Linux\n")
	    ;; linux 平台
	    (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")
	    ;; mac平台
	    (call-process-region (point-min) (point-max) "pbcopy" nil 0 nil "")
	  )
       ))
      
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let (
	    (xsel-output
	     (if (equal my-platform "Linux\n")
		 ;; Linux
		 (shell-command-to-string "xsel --clipboard --output")
	         ;; mac
	         (shell-command-to-string "pbpaste")
	       )
	     )
	    )
	(unless (string= (car kill-ring) xsel-output)
	  xsel-output )))
    ;; Attach callbacks to hooks
    ;; 关联钩子，使得kill-new kill-append函数执行时执行下面两个函数
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ;; Idea from
    ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
    ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
     ))


;; (use-package magit
;;   :ensure t
;;   )

(use-package tabbar
  :ensure t
  :demand
  ;;:bind
  ;;(
   ;; ("C-t" . tabbar-forward-tab)
   ;;("C-S-tab" . tabbar-backward-tab)
   ;;)
  :config
  (tabbar-mode 1)
      (set-face-attribute
     'tabbar-default nil
     :family "Ricty Diminished"
     :background "black"
     :foreground "gray32"
     :height 0.8)
    (set-face-attribute
     'tabbar-unselected nil
     :background "black"
     :foreground "grey80"
     :box nil)
    (set-face-attribute
     'tabbar-modified nil
     :background "#eeee00"
     :foreground "#000000"
     :box nil)
    (set-face-attribute
     'tabbar-selected nil
     :background "#90f050"
     :foreground "gray10"
     :bold 0
     :height 1.2
     :box nil)
    (set-face-attribute
     'tabbar-button nil
     :box nil)
    (set-face-attribute
     'tabbar-separator nil
     :height 0.9)
  )

;; 括号补全
(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (add-hook 'python-mode-hook #'smartparens-mode)
  (add-hook 'lisp-mode-hook #'smartparens-mode)
  )

(use-package winum
  :ensure t
  :init
  (setq winum-keymap
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "C-`") 'winum-select-window-by-number)
      (define-key map (kbd "C-²") 'winum-select-window-by-number)
      (define-key map (kbd "M-0") 'winum-select-window-0-or-10)
      (define-key map (kbd "M-1") 'winum-select-window-1)
      (define-key map (kbd "M-2") 'winum-select-window-2)
      (define-key map (kbd "M-3") 'winum-select-window-3)
      (define-key map (kbd "M-4") 'winum-select-window-4)
      (define-key map (kbd "M-5") 'winum-select-window-5)
      (define-key map (kbd "M-6") 'winum-select-window-6)
      (define-key map (kbd "M-7") 'winum-select-window-7)
      (define-key map (kbd "M-8") 'winum-select-window-8)
      map))
  :config
  (require 'winum)
  (winum-mode)
  )

(use-package goto-chg
  :ensure t
  :bind
  (("C-c /" . goto-last-change))
  )

;; 一定放在最后
(provide 'init-custom-pkg)
