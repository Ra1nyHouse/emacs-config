;; 主题
(use-package material-theme
  :ensure t
  :config (load-theme 'material t)
  )

;; 扩展M-x功能
(use-package helm
  :ensure t
  :bind ("M-x" . helm-M-x)
  :config (require 'helm-config)
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
  :config
    (require 'neotree)
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  )

;; 提供备选项
(use-package ido
  :ensure t
  :config
    (require 'ido)
    (ido-mode t)
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


(provide 'init-custom-pkg)


