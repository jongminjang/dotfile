;;; package --- summary:

(package-initialize)

(setq package-list '(auto-complete
                           flycheck
                           go-autocomplete
                           go-eldoc
                           go-mode
                           multiple-cursors
                           osx-clipboard
                           nyan-mode
                           org))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

;;(load-theme 'leuven)
(require 'prelude-helm-everywhere)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-initialize))

(defun my-go-mode-hook ()
  ; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go generate && go build -v && go test -v && go vet"))
  ; Go oracle
  (load-file "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el")
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(require 'go-autocomplete)
(require 'auto-complete-config)

(ac-config-default)
;(run-at-time nil (* 5 60) 'recentf-save-list)

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-word-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-undo-tree-mode)
(global-unset-key (kbd "C-z"))

(global-set-key (kbd "C-z C-z") 'my-suspend-frame)

(defun my-suspend-frame ()
  "In a GUI environment, do nothing; otherwise `suspend-frame'."
  (interactive)
  (if (display-graphic-p)
      (message "suspend-frame disabled for graphical displays.")
    (suspend-frame)))

;; multiple cursor
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(global-set-key (kbd "s-{") 'multi-term-prev)
(global-set-key (kbd "s-}") 'multi-term-next)

(package-install 'flycheck)
(global-flycheck-mode)

(prefer-coding-system 'utf-8)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

