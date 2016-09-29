
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil))))
 '(evil-ex-lazy-highlight ((t (:inherit lazy-highlight :background "#4d4d79"))))
 '(show-paren-match ((t (:background "selectedKnobColor")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-tags-on-save nil)
  '(package-selected-packages
     (quote
       (counsel-projectile yasnippet flycheck evil-magit terraform-mode origami drag-stuff company elixir-mode clojure-mode haskell-mode rbenv js2-mode org-bullets git-link peep-dired ivy-hydra flx-ido counsel evil-anzu keyfreq evil-search-highlight-persist evil-visualstar evil-surround evil-matchit evil-commentary evil ivy hydra general git-gutter zop-to-char zenburn-theme yaml-mode ws-butler which-key web-mode web-beautify volatile-highlights use-package undo-tree typescript-mode string-inflection spacemacs-theme spaceline smartparens simpleclip scss-mode rust-mode rspec-mode reveal-in-osx-finder rainbow-mode rainbow-delimiters puppet-mode projectile powershell pandoc-mode ox-reveal ox-pandoc org-mac-link nlinum move-text markdown-mode magit json-mode js2-refactor jade-mode inf-ruby ignoramus iedit ido-vertical-mode ibuffer-vc htmlize highlight-indentation hi2 helm-swoop helm-flycheck helm-ag haml-mode goto-chg git-timemachine git-gutter-fringe ghc flycheck-tip flycheck-elm flycheck-clojure expand-region exec-path-from-shell enh-ruby-mode elm-mode dired-single dired-ranger dired-rainbow dired-open dired-filter dired+ crux corral coffee-mode clojure-snippets clj-refactor chruby char-menu browse-kill-ring anzu alchemist ag ace-window)))
 '(safe-local-variable-values (quote ((org-image-actual-width . 600)))))