
;; Interactive list refinement
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (helm-mode 1))
  :config
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-M-x-fuzzy-match t))

(use-package helm-projectile
  :ensure t)

(use-package helm-ag
  :ensure t)

;; Force helm to always open from bottom
;; disable popwin-mode in an active Helm session It should be disabled
;; otherwise it will conflict with other window opened by Helm persistent
;; action, such as *Help* window.
(use-package popwin
  :ensure t
  :config
  (progn
    (popwin-mode 1)
    (push '("^\*helm.+\*$" :regexp t :height 25) popwin:special-display-config)
    (push '("^\*ag.+\*$" :regexp t :height 25) popwin:special-display-config)
    (add-hook 'helm-after-initialize-hook (lambda ()
                                            (popwin:display-buffer helm-buffer t)
                                            (popwin-mode -1)))

    ;; Restore popwin-mode after a Helm session finishes.
    (add-hook 'helm-cleanup-hook (lambda () (popwin-mode 1)))))

(provide 'grass-helm)
