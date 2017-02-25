;; 主题
;(use-package spacemacs-theme
;  :ensure t
;  :config (load-theme 'spacemacs-dark t)
;  )

(use-package monokai-theme
  :ensure t
  :config (load-theme 'monokai t)
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

(provide 'init-custom-pkg)


