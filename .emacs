
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-indentation-layout-offset 4)
 '(haskell-indentation-left-offset 4)
 '(haskell-indentation-starter-offset 4)
 '(haskell-indentation-where-post-offset 4)
 '(haskell-indentation-where-pre-offset 4)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote ghci))
 '(haskell-tags-on-save nil)
 '(hindent-extra-args (quote ("--indent-size" "4")))
 '(hindent-style "")
 '(line-number-display-limit-width 10000)
 '(package-selected-packages (quote (eglot hindent markdown-preview-mode haskell-mode))))

(tool-bar-mode 0)
(menu-bar-mode 0)
(setq-default tab-width 4)
(column-number-mode)
(setq-default indent-tabs-mode nil)

(setq frame-title-format "%b")
(global-unset-key [insert]) ; stop stupid overwrite mode
(setq default-major-mode 'text-mode)
;(setq-default whitespace-line-column 90)
(setq whitespace-style '(face tabs trailing))
(global-whitespace-mode)

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
(global-set-key [f2] 'split-window-vertically) ; C-x 2
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
(global-set-key "\C-xp" 'other-frame)
(global-set-key [C-tab] 'comint-dynamic-complete-filename)
;(global-set-key "\M-`" 'line-up-on)
(global-set-key [?\C-%] 'query-replace-regexp)

(setq meta-n-map (make-sparse-keymap))
(global-set-key [?\M-n] meta-n-map)
(define-key meta-n-map [?\M-t]  'insert-current-time)

(add-to-list 'auto-mode-alist '("\\.daml\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'package)
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(let ((my-stack-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-stack-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-stack-path))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f7] 'haskell-mode-stylish-buffer))

(load-file "~/github/ghcid/plugins/emacs/ghcid.el")
;(global-set-key [f10] 'ghcid)
(global-set-key [insert] 'next-error)


(setq ghc-report-errors nil)

(global-unset-key [f10])


;; Tue Nov 12 21:24:52 2019
(require 'eglot)
(add-to-list 'eglot-server-programs '(haskell-mode . ("ghcide" "--lsp")))
; NOT TRIED YET....
;(add-hook 'foo-mode-hook 'eglot-ensure)

(define-key eglot-mode-map (kbd "C-c h") 'eglot-help-at-point)
;;(define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions) ;; list is on M-.

