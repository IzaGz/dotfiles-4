(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|XXX\\|HACK\\|DEBUG\\)"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

(use-package company
  :diminish company-mode
  :config
    (setq company-idle-delay 0.2)
    (setq company-minimum-prefix-length 2)
    (add-hook 'after-init-hook 'global-company-mode)
    (defun complete-or-indent ()
      (interactive)
      (if (company-manual-begin)
          (company-complete-common)
          (indent-according-to-mode))))

(use-package web-beautify
  :commands (web-beautify-js web-beautify-css web-beautify-html))

(use-package flycheck
  :defer t)

(use-package magit
  :bind ("C-, g" . magit-status))

;; Line numbers for coding please
(setq on-console (null window-system))
(setq linum-format (if on-console "%4d " "%4d"))

(use-package string-inflection
  :bind ("C-, C-u" . string-inflection-cycle))

(use-package smartparens
  :defer t
  :diminish smartparens-mode
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)
  (add-hook 'enh-ruby-mode-hook #'smartparens-mode)
  (add-hook 'lisp-mode-hook #'smartparens-mode)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  (add-hook 'clojure-mode-hook #'smartparens-mode)
  (add-hook 'cider-repl-mode-hook #'smartparens-mode)
  (add-hook 'scheme-mode-hook #'smartparens-mode))

(require 'hideshow)
(diminish 'hs-minor-mode)

;;Alignment
(add-hook 'prog-mode-hook
  (lambda ()
    (linum-mode 1)
    (hs-minor-mode t)
    (global-set-key (kbd "C-, a =")
      (lambda () (interactive)
        (grass/align-to-equals (region-beginning) (region-end))))

    (global-set-key (kbd "C-, a :")
      (lambda () (interactive)
        (grass/align-to-colon (region-beginning) (region-end))))))

;; Show current function in modeline
(which-function-mode)

(set-default 'imenu-auto-rescan t)

(global-set-key (kbd "C-, i") 'imenu)

(use-package puppet-mode
  :defer t)

(use-package rust-mode
  :defer t)

(use-package python
  :defer t)

(provide 'grass-coding)
