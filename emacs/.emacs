(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-clang-arguments (quote ("-std=c++17")))
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "585942bb24cab2d4b2f74977ac3ba6ddbd888e3776b9d2f993c5704aa8bb4739" "8f97d5ec8a774485296e366fdde6ff5589cf9e319a584b845b6f7fa788c9fa9a" "2b9dc43b786e36f68a9fd4b36dd050509a0e32fe3b0a803310661edb7402b8b6" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" default)))
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   (quote
    (ranger gruvbox-theme company-lua dired+ company-irony company yasnippet auto-complete)))
 '(pdf-view-midnight-colors (quote ("#fdf4c1" . "#1d2021")))
 '(save-place-mode t nil (saveplace))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "MS  " :slant normal :weight bold :height 113 :width normal)))))
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(add-hook 'after-init-hook 'global-company-mode)
; start auto-complete with emacs
;(require 'auto-complete)
; do default config for auto-complete
;(require 'auto-complete-config)
;(ac-config-default)
; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq w32-pipe-read-delay 0)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony 'company-lua))

;; Configure backups
(setq backup-directory-alist '(("." . "~/.saves")))
(setq backup-by-copying t)

;; Configure IBuffers
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
          (quote (("default"
                   ("dired" (mode . dired-mode))
                   ("C++" (mode . c++-mode))
                   ("erc" (mode . erc-mode))
		   ("Lua" (mode . lua-mode))
                   ("planner" (or
                               (name . "^\\*Calendar\\*$")
                               (name . "^diary$")
                               (mode . muse-mode)))
                   ("emacs" (or
                             (name . "^\\*scratch\\*$")
                             (name . "^\\*Messages\\*$")))
                   ("gnus" (or
                            (mode . message-mode)
                            (mode . bbdb-mode)
                            (mode . mail-mode)
                            (mode . gnus-group-mode)
                            (mode . gnus-summary-mode)
                            (mode . gnus-article-mode)
                            (name . "^\\.bbdb$")
                            (name . "^\\.newsrc-dribble")))))))

    (add-hook 'ibuffer-mode-hook
              (lambda ()
                (ibuffer-switch-to-saved-filter-groups "default")))
(setq ibuffer-show-empty-filter-groups nil)

;; Stop C-z from hangin emacs
(global-unset-key (kbd "C-z"))

;; Turn off beeping
(setq ring-bell-function 'ignore)

;; Load Gruvbox colour theme
(load-theme 'gruvbox t)

;; Setup Ranger Filemanager
(setq ranger-override-dired 'ranger)
(setq ranger-show-hidden t)
(ranger-override-dired-mode t)
