
;; Follow symlinks by default
(setq vc-follow-symlinks t)

;; Selections and other actions
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

(use-package saveplace
  :config
  ;; Saveplace remembers your location in a file when saving files
  (setq save-place-file (expand-file-name "saveplace" grass/savefile-dir))
  ;; activate it for all buffers
  (setq-default save-place t)
  ;; Savehist keeps track of some history
  (setq savehist-additional-variables
    ;; search entries
    '(search ring regexp-search-ring)
    ;; save every minute
    savehist-autosave-interval 60
    ;; keep the home clean
    savehist-file (expand-file-name "savehist" grass/savefile-dir))
  :init
  (savehist-mode t))


(use-package recentf
  :defer t
  :init
  ;; lazy load recentf
  (add-hook 'find-file-hook (lambda () (unless recentf-mode
                                         (recentf-mode)
                                         (recentf-track-opened-file))))
  :config
  (add-to-list 'recentf-exclude "\\ido.hist\\'")
  (add-to-list 'recentf-exclude "/TAGS")
  (add-to-list 'recentf-exclude "/.autosaves/")
  (add-to-list 'recentf-exclude "emacs.d/elpa/")
  (add-to-list 'recentf-exclude "COMMIT_EDITMSG\\'")
  (setq recentf-save-file (expand-file-name "recentf" grass/savefile-dir))
  (setq recentf-max-saved-items 100))

;; Don't make tab indent a line
(setq tab-always-indent nil)

;; Subtle highlighting of matching parens (global-mode)
(show-paren-mode +1)
(setq show-paren-style 'parenthesis)


(add-to-list 'recentf-exclude "\\ido.hist\\'")
(add-to-list 'recentf-exclude "/TAGS")
(add-to-list 'recentf-exclude "/.autosaves/")
(add-to-list 'recentf-exclude "/emacs.d/elpa/")


(require 'highlight)

;; UI highlight search and other actions
(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t))

;; Use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings)

;; flyspell-mode does spell-checking on the fly as you type
(require 'flyspell)
(setq-default ispell-program-name "aspell")
(setq-default ispell-dictionary "english")
(setq-default ispell-extra-args '("--lang=en_AU --sug-mode=ultra"))

(global-set-key (kbd "C-, S n") 'flyspell-goto-next-error)

;; 80 char wide paragraphs please
(setq-default fill-column 80)

;; Autofill where possible but only in comments when coding
;; http://stackoverflow.com/questions/4477357/how-to-turn-on-emacs-auto-fill-mode-only-for-code-comments
(setq comment-auto-fill-only-comments t)
;; (auto-fill-mode 1)

;; Base 10 for inserting quoted chars please
(setq read-quoted-char-radix 10)

;; Dashes
(defun grass/insert-en-dash
  "Insert an en dash"
  (interactive)
  (insert "–"))

(defun grass/insert-em-dash
  "Insert an en dash"
  (interactive)
  (insert "—"))

;; Dashes
(global-set-key (kbd "C-, -") 'grass/insert-en-dash)
(global-set-key (kbd "C-, =") 'grass/insert-em-dash)

;; Auto save on focus lost
(defun grass/auto-save-all()
  "Save all modified buffers that point to files."
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (set-buffer buf)
      (if (and (buffer-file-name) (buffer-modified-p))
          (basic-save-buffer)))))

(add-hook 'auto-save-hook 'grass/auto-save-all)
(add-hook 'mouse-leave-buffer-hook 'grass/auto-save-all)
(add-hook 'focus-out-hook 'grass/auto-save-all)

;; abbrev mode for common typos
(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
(diminish 'abbrev-mode)
(setq-default abbrev-mode t)


;; Reuse the same buffer for dired windows
(use-package dired-single
  :config
  (defun my-dired-init ()
    "Bunch of stuff to run for dired, either immediately or when it's loaded."
    (define-key dired-mode-map [return] 'dired-single-buffer)
    (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
    (define-key dired-mode-map "U"
      (function
       (lambda nil (interactive) (dired-single-buffer ".."))))
    (define-key dired-mode-map "^"
      (function
       (lambda nil (interactive) (dired-single-buffer "..")))))

  ;; if dired's already loaded, then the keymap will be bound
  (if (boundp 'dired-mode-map)
      ;; we're good to go; just add our bindings
      (my-dired-init)
    ;; it's not loaded yet, so add our bindings to the load-hook
    (add-hook 'dired-load-hook 'my-dired-init))
  (put 'dired-find-alternate-file 'disabled nil))

;; Up in dired
(add-hook 'dired-mode-hook
  (lambda ()
    (dired-hide-details-mode t)))

;; Make files with the same name have unique buffer names
(setq uniquify-buffer-name-style 'forward)

;; Some key bindings
(global-set-key (kbd "<home>") 'move-beginning-of-line)
(global-set-key (kbd "<end>") 'move-end-of-line)

(use-package move-text
  :bind (("<C-S-up>" . move-text-up)
         ("<C-S-down>" . move-text-down)))

(global-set-key (kbd "C-, u") 'browse-url)
(global-set-key (kbd "C-, f") 'grass/indent-region-or-buffer)

;; Quick switch buffers
(global-set-key (kbd "C-, C-,") 'grass/switch-to-previous-buffer)

;; Search and replace

(defun grass/replace-string (from-string to-string &optional delimited start end)
  "This is a modified version of `replace-string'. This modified version defaults to operating on the entire buffer instead of working only from POINT to the end of the buffer."
  (interactive
   (let ((common
      (query-replace-read-args
       (concat "Replace"
           (if current-prefix-arg " word" "")
           (if (and transient-mark-mode mark-active) " in region" ""))
       nil)))
     (list (nth 0 common) (nth 1 common) (nth 2 common)
       (if (and transient-mark-mode mark-active)
           (region-beginning)
         (buffer-end -1))
       (if (and transient-mark-mode mark-active)
           (region-end)
         (buffer-end 1)))))
  (perform-replace from-string to-string nil nil delimited nil nil start end))

(defun grass/replace-regexp (regexp to-string &optional delimited start end)
  "This is a modified version of `replace-regexp'. This modified version defaults to operating on the entire buffer instead of working only from POINT to the end of the buffer."
  (interactive
   (let ((common
      (query-replace-read-args
       (concat "Replace"
           (if current-prefix-arg " word" "")
           " regexp"
           (if (and transient-mark-mode mark-active) " in region" ""))
       t)))
     (list (nth 0 common) (nth 1 common) (nth 2 common)
       (if (and transient-mark-mode mark-active)
           (region-beginning)
         (buffer-end -1))
       (if (and transient-mark-mode mark-active)
           (region-end)
         (buffer-end 1)))))
  (perform-replace regexp to-string nil t delimited nil nil start end))

(defun grass/query-replace-regexp (regexp to-string &optional delimited start end)
  "This is a modified version of `query-replace-regexp'. This modified version defaults to operating on the entire buffer instead of working only from POINT to the end of the buffer."
  (interactive
   (let ((common
      (query-replace-read-args
       (concat "Replace"
           (if current-prefix-arg " word" "")
           " regexp"
           (if (and transient-mark-mode mark-active) " in region" ""))
       t)))
     (list (nth 0 common) (nth 1 common) (nth 2 common)
       (if (and transient-mark-mode mark-active)
           (region-beginning)
         (buffer-end -1))
       (if (and transient-mark-mode mark-active)
           (region-end)
         (buffer-end 1)))))
  (perform-replace regexp to-string t t delimited nil nil start end))

(defun grass/query-replace-string (from-string to-string &optional delimited start end)
  "This is a modified version of `query-replace-string'. This modified version defaults to operating on the entire buffer instead of working only from POINT to the end of the buffer."
  (interactive
   (let ((common
      (query-replace-read-args
       (concat "Replace"
           (if current-prefix-arg " word" "")
           (if (and transient-mark-mode mark-active) " in region" ""))
       nil)))
     (list (nth 0 common) (nth 1 common) (nth 2 common)
       (if (and transient-mark-mode mark-active)
           (region-beginning)
         (buffer-end -1))
       (if (and transient-mark-mode mark-active)
           (region-end)
         (buffer-end 1)))))
  (perform-replace from-string to-string t nil delimited nil nil start end))

(global-set-key (kbd "C-, s r") 'grass/replace-string)
(global-set-key (kbd "C-, s R") 'grass/replace-regexp)
(global-set-key (kbd "C-, s q") 'grass/query-replace-string)
(global-set-key (kbd "C-, s Q") 'grass/query-replace-regexp)
(global-set-key (kbd "C-, s f") 'isearch-forward-regexp)
(global-set-key (kbd "C-, s b") 'isearch-reverse-regexp)

;; Enable some stuff
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-defun  'disabled nil)
(put 'narrow-to-page   'disabled nil)
(put 'narrow-to-region 'disabled nil)

;;
;; Make windows sticky http://stackoverflow.com/a/5182111
;;
(defadvice pop-to-buffer (before cancel-other-window first)
  (ad-set-arg 1 nil))

(ad-activate 'pop-to-buffer)

;; Don't combine tag tables thanks
(setq tags-add-tables nil)

;; Toggle window dedication
(defun toggle-window-dedicated ()
  "Toggle whether the current active window is dedicated or not"
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window
                                 (not (window-dedicated-p window))))
       "Window '%s' is dedicated"
     "Window '%s' is normal")
   (current-buffer)))

(global-set-key (kbd "C-, q") 'toggle-window-dedicated)

(use-package expand-region
  :bind (("C-+" . er/contract-region)
         ("C-=" . er/expand-region)))

(use-package ag
  :bind (("C-, s a" . ag-project))
  :commands ag-project)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  ;; Persistent undo sometimes borks. Disable for now
  ;; (setq undo-tree-auto-save-history t)
  ;; (setq undo-tree-history-directory-alist `((".*" . ,grass/undo-dir)))
  ;; (defadvice undo-tree-make-history-save-file-name
  ;;   (after undo-tree activate)
  ;;   (setq ad-return-value (concat ad-return-value ".gz")))
  (global-undo-tree-mode))

(provide 'grass-editor)
