;; 设置国内镜像
(when (>= emacs-major-version 24)
  (require 'package)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa" . "http://elpa.emacs-china.org/melpa/")))
  (setq package-enable-at-startup nil)
  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
)

;; 安装use-pachage包
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; 烦人的custom-file放在别的地方，如果报错，自行创建emacs-custom文件
(setq custom-file "~/.emacs.d/emacs-custom.el")
;; 如果存在，则读入
(if (file-exists-p custom-file)
  (load custom-file))

;; 自定义配置写在ra1nyhouse-config目录中，用require引入
(add-to-list 'load-path (expand-file-name "ra1nyhouse-config" user-emacs-directory))

(require 'init-sysconfig)
(require 'init-custom-pkg)
(require 'cus-keybind)
