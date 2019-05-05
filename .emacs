
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-tags-on-save t)
 '(line-number-display-limit-width 10000)
 '(package-selected-packages (quote (markdown-preview-mode ghc hindent haskell-mode))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(tool-bar-mode 0)
(menu-bar-mode 0)
(setq-default tab-width 4)
(column-number-mode)

;(setq frame-title-format "%b")
;(global-unset-key [insert]) ; stop stupid overwrite mode
;(setq default-major-mode 'text-mode)
;(setq-default whitespace-line-column 90)
;(setq whitespace-style '(tabs))
;(global-whitespace-mode)

(defun shuffle-up () (interactive) (scroll-down 1) (previous-line 1))
(defun shuffle-down () (interactive) (scroll-up 1) (next-line 1))
(defun switch-to-buffer-no-confirm () (interactive) (switch-to-buffer nil))
(defun down6 () (interactive) (next-line 6))
(defun up6 () (interactive) (previous-line 6))
(defun kill-buffer-no-confirm () (interactive) (kill-buffer nil))
(defun insert-current-time () (interactive) (insert (current-time-string)))
(defun revert-buffer-no-question () (interactive) (revert-buffer t t))

(defun fresh-shell ()
  (interactive)
  (let ((buffer (get-buffer "*shell*")))
    (if buffer
	(save-excursion
	  (set-buffer buffer)
	  (rename-uniquely)))
    (shell)))

(global-set-key [M-down] 'down6)
(global-set-key [M-up] 'up6)
;(global-set-key [f1] 'delete-other-windows) ; C-x 1
;(global-set-key [f2] 'split-window-vertically) ; C-x 2
(global-set-key [f3] 'shuffle-up)
(global-set-key [f4] 'shuffle-down)
(global-set-key [f5] 'shell)
(global-set-key [C-f5] 'fresh-shell)
;(global-set-key [f6] 'comment-paragraph)
;(global-set-key [f7] 'switch-between-ml-mli)
(global-set-key [f8] 'revert-buffer-no-question)
(global-set-key [f9] 'make-frame)
;(global-set-key [f10] 'delete-frame)
(global-set-key [f11] 'bury-buffer)
(global-set-key [f12] 'switch-to-buffer-no-confirm)
(global-set-key "\C-xk" 'kill-buffer-no-confirm)
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer)
(global-set-key "\C-x\C-g" 'goto-line) ; standard is: M-g M-g OR M-g g
;(global-set-key "\C-xp" 'other-frame)
(global-set-key [C-tab] 'comint-dynamic-complete-filename)
;(global-set-key "\M-`" 'line-up-on)
;(global-set-key [?\C-%] 'query-replace-regexp)

(setq meta-n-map (make-sparse-keymap))
(global-set-key [?\M-n] meta-n-map)
(define-key meta-n-map [?\M-t]  'insert-current-time)

;;----------------------------------------------------------------------
;; Fri Apr 12 09:22:02 2019
;; haskell...

(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(add-hook 'haskell-mode-hook #'hindent-mode)

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f6] 'haskell-navigate-imports))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f7] 'haskell-mode-stylish-buffer))


(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
  (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)))

;(eval-after-load 'haskell-cabal '(progn
;  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
;  (define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile)))


;(autoload 'ghc-init "ghc" nil t)
;(autoload 'ghc-debug "ghc" nil t)
;(add-hook 'haskell-mode-hook (lambda () (ghc-init)))


(add-to-list 'auto-mode-alist '("\\.daml\\'" . haskell-mode))

(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(global-unset-key [insert]) ; stop stupid overwrite mode