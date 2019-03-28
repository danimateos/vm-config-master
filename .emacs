
(tool-bar-mode -1)

;; packages
;; drawback: if you try to install a package with no internet connection, it will fail
;; and break emacs
(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

  (package-initialize)
  (when (not package-archive-contents)
    (package-refresh-contents))
  
  (defvar myPackages
    '(ensime
      ido
      smex
      undo-tree
      better-defaults
      elpy
      flycheck
      yaml-mode
      markdown-mode
      jekyll-modes
      exec-path-from-shell))
  
  (mapc #'(lambda (package)
	    (unless (package-installed-p package)
	      (package-install package)))
	myPackages)

  )

(require 'ensime)
(setq ensime-startup-notification nil)
(setq ensime-startup-snapshot-notification nil)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
;; If necessary, make sure "sbt" and "scala" are in the PATH environment
;; (setenv "PATH" (concat "/path/to/sbt/bin:" (getenv "PATH")))
;; (setenv "PATH" (concat "/path/to/scala/bin:" (getenv "PATH")))
;; You can also customize `ensime-inf-get-project-root' and `ensime-inf-get-repl-cmd-line'

;; interactively do things (ido)
(require 'ido)
(ido-mode t)

;; smex: ido for commands
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; undo-tree
(require 'undo-tree)
(global-set-key (kbd "s-/") 'undo-tree-visualize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tango-dark)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal)))))
(put 'scroll-left 'disabled nil)

;; Auto-activate Octave mode for .m files:

(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Turn on abbrevs, auto-fill and font-lock automatically
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; Play nice with input methods for tildes and otther dead keys
(require 'iso-transl)

;; Show column number
(setq column-number-mode t)

;; Better default behavior for emacs
(require 'better-defaults)

;; Python stuff: https://realpython.com/blog/python/emacs-the-best-python-editor/
(elpy-enable)

;; Better syntax checking for Python
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; use IPython as interpreter; use shell PATH for anaconda
(exec-path-from-shell-copy-env "PATH")
(elpy-use-ipython)
(setq python-shell-interpreter "ipython" python-shell-interpreter-args "--simple-prompt --pprint")

;; jekyll-modes

(add-to-list 'auto-mode-alist '("\\.md$" . jekyll-markdown-mode))
(add-to-list 'auto-mode-alist '("\\.html" . jekyll-html-mode))
