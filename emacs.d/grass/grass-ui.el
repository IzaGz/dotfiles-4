;; UI config

;; Faster
(setq font-lock-verbose nil)

;; no jerky scrolling
(setq scroll-conservatively 101)

;; Get rid of chrome
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No menu bar if we're in the console
(unless (display-graphic-p)
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;; No blinking cursor
(blink-cursor-mode -1)

;; No startup screen
(setq inhibit-startup-screen t)

;; No bell thanks
(setq ring-bell-function 'ignore)

; Text mode by default for scratch buffer
;(setq initial-major-mode 'text-mode)

;; Nice scrolling
(setq scroll-margin 4
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; Mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; Enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; A more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " - " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

(use-package ibuffer
  :commands ibuffer
  :config
  (progn
    (setq ibuffer-saved-filter-groups
          '(("Config" (or
                       (filename . ".dotfiles/")
                       (filename . ".emacs.d/")))
            ("Shell"  (or
                       (mode . eshell-mode)
                       (mode . shell-mode)))
            ("Dired"  (mode . dired-mode))
            ("Prose"  (or
                       (mode . tex-mode)
                       (mode . plain-tex-mode)
                       (mode . latex-mode)
                       (mode . rst-mode)
                       (mode . markdown-mode)))
            ("Org"    (mode . org-mode))
            ("Emacs"  (name . "^\\*.*\\*$")))
          ibuffer-show-empty-filter-groups nil
          ibuffer-expert nil)
    (setq ibuffer-default-sorting-mode 'filename/process)
    (global-set-key (kbd "C-, o") 'ibuffer)
    (global-set-key (kbd "C-x C-b") 'ibuffer)

    ; (use-package ibuffer-projectile
    ;   :ensure t
    ;   :init

      ; (add-hook 'ibuffer-hook
      ;   (lambda ()
      ;     (ibuffer-projectile-set-filter-groups)
      ;     (unless (eq ibuffer-sorting-mode 'alphabetic)
      ;       (ibuffer-do-sort-by-alphabetic)))))

      ; (progn
      ;   (defun grass/ibuffer-apply-filter-groups ()
      ;     "Combine my saved ibuffer filter groups with those generated
     ; by `ibuffer-vc-generate-filter-groups-by-vc-root'"
      ;     (interactive)
      ;     (setq ibuffer-filter-groups
      ;           (append (ibuffer-projectile-generate-filter-groups)
      ;                   ibuffer-saved-filter-groups))
      ;     (message "ibuffer-vc: groups set")
      ;     (let ((ibuf (get-buffer "*Ibuffer*")))
      ;       (when ibuf
      ;         (with-current-buffer ibuf
      ;           (pop-to-buffer ibuf)
      ;           (ibuffer-update nil t)))))

      ;   (add-hook 'ibuffer-hook 'grass/ibuffer-apply-filter-groups)))))
    (use-package ibuffer-vc
      :ensure t
      :commands ibuffer-vc-generate-filter-groups-by-vc-root
      :init
      (progn
        (defun grass/ibuffer-apply-filter-groups ()
          "Combine my saved ibuffer filter groups with those generated
     by `ibuffer-vc-generate-filter-groups-by-vc-root'"
          (interactive)
          (setq ibuffer-filter-groups
                (append (ibuffer-vc-generate-filter-groups-by-vc-root)
                        ibuffer-saved-filter-groups))
          (message "ibuffer-vc: groups set")
          (let ((ibuf (get-buffer "*Ibuffer*")))
            (when ibuf
              (with-current-buffer ibuf
                (pop-to-buffer ibuf)
                (ibuffer-update nil t)))))

        (add-hook 'ibuffer-hook 'grass/ibuffer-apply-filter-groups)
        ))))
      


(use-package smart-mode-line
  :ensure t
  :init
  (setq sml/no-confirm-load-theme t)
  (setq sml/shorten-modes nil)
  (setq sml/theme 'respectful)
  (sml/setup))

;; Ignore certain files
(use-package ignoramus
  :ensure t
  :init
  (ignoramus-setup))

(use-package default-text-scale
  :ensure t
  :init
  (global-set-key (kbd "C-M-=") 'default-text-scale-increase)
  (global-set-key (kbd "C-M--") 'default-text-scale-decrease))

(diminish 'abbrev-mode)

;; GUI Mode settings
(when (display-graphic-p)
  (use-package solarized
               :ensure solarized-theme
               :init (load-theme 'solarized-dark 'no-confirm)
               :config
               ;; Disable variable pitch fonts in Solarized theme
               (setq solarized-use-variable-pitch nil
                     ;; Don't add too much colours to the fringe
                     solarized-emphasize-indicators nil
                     ;; Keep font sizes the same
                     solarized-height-minus-1 1.0
                     solarized-height-plus-1 1.0
                     solarized-height-plus-2 1.0
                     solarized-height-plus-3 1.0
                     solarized-height-plus-4 1.0))
  ;; Highlight the current line
  (global-hl-line-mode +1))

(when (not (display-graphic-p))
  (use-package zenburn-theme
     :ensure t
     :init
     (load-theme 'zenburn 'no-confirm)))

;; Some terminal mapping hackery
(define-key input-decode-map "\e[1;," (kbd "C-,"))

(provide 'grass-ui)
