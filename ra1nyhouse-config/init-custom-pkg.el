;; 使用默认主题 manoj-dark,对helm支持较好
;; 修改为wombat
(load-theme 'wombat t)

;; 使用helm,扩展M-x功能
;; (use-package helm
;;   :ensure t
;;   :demand
;;   :bind (("M-x" . helm-M-x)
;; 	 ("C-x C-f" . helm-find-files)
;; 	 ("C-x b" . helm-buffers-list))
;;   :config
;;   (require 'helm-config)
;;   ;; helm-themes不是主题，只是显示当前所有安装主题
;;   ;; 如有异常，删除emacs-custom.el文件
;;     (use-package helm-themes
;;     :ensure t
;;     :config (require 'helm-themes)
;;     )  
;;   )

;; ivy划分为ivy,swiper,counsel三个包，counsel依赖前两个
;; 测试了，功能和helm重复，速度更快，但是没有helm强大
;; swiper是isearch很好的替代品，推荐使用
;; counsel 是ivy模式的增强版

;; 使用swiper替换isearch
;; 设置ivy-mode开启，使用C-x k 时候很方便
(use-package counsel
  :ensure t
  :demand
  :bind (("C-s" . swiper)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 ("C-c g" . counsel-git)
	 ("C-c j" . counsel-git-grep)
	 )
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  )


;; python模式
(use-package elpy
  :ensure t
  :demand
  :bind (
	 :map elpy-mode-map
	 ("C-c C-k" . elpy-shell-kill)
	)
  :config (elpy-enable)
  )

;; 语法检测
(use-package flycheck
  :ensure t
  :config
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))
  )

;; 目录树
(use-package neotree
  :ensure t
  :bind ([f9] . neotree-toggle)
  )

;; 支持gist，需要配置
;; git config --global github.user <your-github-user-name> eg:ra1nyhouse
;; git config --global github.oauth-token <your-personal-access-token-with-gist-scope>
(use-package gist
  :ensure t
  :config (require 'gist)
  )

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

;; 多行编辑
(use-package multiple-cursors
  :ensure t
  :bind (([f1] . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this))
  )

;; 自动补全
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  )

;; snippet代码片段
(use-package yasnippet
  :ensure t
  :config
  (require 'yasnippet)
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/ra1nyhouse-snippets")
  (yas-global-mode 1)
 )

;; 将烦人的弹出提示框设置成popwin，使用C-g关闭
(use-package popwin
  :ensure t
  :config
  (require 'popwin)
  (popwin-mode 1)
  (push "*Warnings*" popwin:special-display-config)
  (push "*Flycheck error messages*" popwin:special-display-config)
 )

;; 自定义模式栏显示内容
(use-package diminish
  :ensure t
  :config
  (require 'diminish)
  (diminish 'ivy-mode)
  )

;; 必应字典支持
(use-package bing-dict
  :ensure t
  :bind (("C-c d" . bing-dict-brief))
  )

;; undotree 不好用，从粘贴板复制大数据时因为创建树结构会卡顿
;; (use-package undo-tree
;;   :ensure t
;;   :demand
;;   :config
;;   (require 'undo-tree)
;;   (global-undo-tree-mode)
;;   )

(use-package ace-window
  :ensure t
  :bind (("M-p" . ace-window))
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


(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1)
  ;; 设置间隔是1
  (custom-set-variables '(smooth-scroll-margin 1))
  )


(use-package magit
  :ensure t
  )

;; (use-package evil
;;   :ensure t
;;   :init
;;  ;; (setq evil-toggle-key "C-`")
;;   :config
;;  ;; (evil-mode 1)
;;  )

;; 一定放在最后
(provide 'init-custom-pkg)
