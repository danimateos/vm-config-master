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
    '(ido
      undo-tree))
  
  (mapc #'(lambda (package)
	    (unless (package-installed-p package)
	      (package-install package)))
	myPackages)

  )


;; interactively do things (ido)
(require 'ido)
(ido-mode t)

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

