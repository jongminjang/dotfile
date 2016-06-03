;;; package --- summary:

(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(setq package-list '(auto-complete
                           flycheck
                           go-autocomplete
                           go-eldoc
                           go-mode
                           multiple-cursors
                           osx-clipboard
                           org))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(load-theme 'leuven)

;; initial window
;;(setq initial-frame-alist
;;      '(
;;        (width . 160) ; character
;;        (height . 50) ; lines
;;        ))

;; default/sebsequent window
;;(setq default-frame-alist
;;      '(
;;        (width . 100) ; character
;;        (height . 52) ; lines
;;        ))

;;(require 'package)
;;(package-initialize)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(indent-tabs-mode nil)
 '(nyan-animate-nyancat t)
 '(nyan-bar-length 20)
 '(nyan-mode t)
 '(nyan-wavy-trail t)
 '(osx-clipboard-mode t)
 '(package-archives
   (quote
    (("melpa" . "https://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(recentf-mode t)
 '(save-interprogram-paste-before-kill t)
 '(show-paren-mode t)
 '(standard-indent 4)
 '(tab-width 4)
 '(tool-bar-mode t)
 '(yank-pop-change-selection t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
