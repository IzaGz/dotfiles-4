(require 'js2-mode)

(add-to-list 'auto-mode-alist '("\\.js\\'"    . js2-mode))
(add-to-list 'auto-mode-alist '("\\.pac\\'"   . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(add-hook 'js2-mode-hook
  (lambda ()
     (setq mode-name "JS2")
     (setq js2-global-externs '("require" "module" "jest" "jasmine"
                                "it" "expect" "describe" "beforeEach"))
     (js2-imenu-extras-mode +1)))


(require 'coffee-mode)

(provide 'grass-js)