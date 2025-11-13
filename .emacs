
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-indentation-layout-offset 2)
 '(haskell-indentation-left-offset 2)
 '(haskell-indentation-starter-offset 2)
 '(haskell-indentation-where-post-offset 2)
 '(haskell-indentation-where-pre-offset 2)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'ghci)
 '(haskell-tags-on-save nil)
 '(hindent-extra-args '("--indent-size" "4"))
 '(hindent-style "")
 '(line-number-display-limit-width 10000)
 '(max-mini-window-height 2)
 '(package-selected-packages
   '(tuareg zig-mode go-mode rust-mode scala-mode hindent markdown-preview-mode haskell-mode)))

(tool-bar-mode 0)
(menu-bar-mode 0)
(setq-default tab-width 4)
(column-number-mode)
(setq-default indent-tabs-mode nil)

(setq frame-title-format "%b")

;(global-unset-key [insert]) ; stop stupid overwrite mode
(global-set-key [insert] 'overwrite-mode)

(setq default-major-mode 'text-mode)
;(setq-default whitespace-line-column 90)
(setq whitespace-style '(face trailing)) ; golang uses tabs!
(setq whitespace-style '(face tabs)) ; dont care about trailing WH
(setq whitespace-style '(face)) ; dont care about tabs or trailing
(setq whitespace-style '(face tabs trailing)) ; Care!
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

(defun switch-between-ml-mli ()
  (interactive)
  (let* ((name (buffer-file-name))
         (other
          (if (string-match "\\(.*\\.ml\\)i$" name)
              (match-string 1 name)
            (concat name "i"))))
    (if (file-exists-p other)
        (find-file other))))

(global-set-key [f7] 'switch-between-ml-mli)

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
(require 'comint)
(global-set-key [C-tab] 'comint-dynamic-complete-filename)
;(global-set-key "\M-`" 'line-up-on)
(global-set-key [?\C-%] 'query-replace-regexp)

(setq meta-n-map (make-sparse-keymap))
(global-set-key [?\M-n] meta-n-map)
(define-key meta-n-map [?\M-t]  'insert-current-time)

(add-to-list 'auto-mode-alist '("\\.daml\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.f\\'" . text-mode))
(add-to-list 'auto-mode-alist '("\\.fun\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.bob\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.ml6\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.pl\\'" . prolog-mode))

(require 'package)
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(let ((my-stack-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-stack-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-stack-path))

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f7] 'haskell-mode-stylish-buffer))


; Mon Nov 15 18:49:12 2021 -- cant get this as I like
;(add-hook 'asm-mode-hook (lambda () (define-key asm-mode-map (kbd ";") 'self-insert-comand)))

;; (add-hook 'asm-mode-hook (lambda ()
;;                            (modify-syntax-entry ?. "w")
;;                            (set-variable 'comment-column 0)
;;                            (set-variable 'tab-always-indent t nil)))

; Wed Feb  8 19:32:48 2023 -- another attempt at making asm mode nicer
(add-hook 'asm-mode-hook
          (lambda ()
            (modify-syntax-entry ?. "w") ; treat the dot (of labels) as a word char
            (set-variable 'tab-always-indent t)
            (local-unset-key ";")))
(fset 'unindent
   [?\C-a ?\C-  ?\M-x ?i ?s ?e tab ?- ?f ?o tab ?- ?r ?e tab return ?\[ ?^ ?  tab ?\] return escape left ?\C-w ?\C-w])
(global-set-key [M-tab] 'unindent)


;(load-file "~/code/ghcid/plugins/emacs/ghcid.el")
;(global-set-key [f10] 'ghcid)
;(global-set-key [insert] 'next-error)


(setq ghc-report-errors nil)

(global-unset-key [f10])

(global-set-key [f6] 'markdown-preview-mode)


;(require 'eglot)
;(add-to-list 'eglot-server-programs '(haskell-mode . ("ghcide" "--lsp")))
;(add-hook 'haskell-mode-hook 'eglot-ensure)
;(add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))

;(define-key eglot-mode-map (kbd "C-c h") 'eglot-help-at-point)
;(define-key eglot-mode-map (kbd "<M-return>") 'xref-find-definitions) ;; also on M-.

(fset 'fix-imports
   [?\M-h ?\M-x ?s ?o ?r ?t tab ?l ?i tab return])


;(global-set-key [f6] 'comment-paragraph)
(global-set-key [f6] 'comment-or-uncomment-region)

(global-set-key [f6] 'fix-imports)

;;----------------------------------------------------------------------
;; Tue Aug 29 19:43:28 2023


;;;;;;
; $Id: line-up.el,v 1.2 1994/08/25 16:23:56 james Exp $
;
; $Log: line-up.el,v $
; Revision 1.2  1994/08/25  16:23:56  james
; fixed looping when hit end of file.
;
; Revision 1.1  1994/08/23  11:05:14  nic
; Initial revision
;;;;;;


;; Originally from James.

;; The definition of line-up-on has changed to take the character at the
;; current point, instead of requesting one from the user

;;------------------------------------------------------------
;; line-up-on char pos
;; if line doesnt contain char then STOP else
;;   consider first occurence on line,
;;     min = furthest back it can go over white space
;;     moveTo = max (min,pos)
;;     shuffle char to moveTo (deleting or inserting spaces)
;;   proceed to next line.


(defun end-line-point ()
  (save-excursion
    (end-of-line)
    (point)))

(defun beginning-line-point ()
  (save-excursion
    (beginning-of-line)
    (point)))

(defun position-in-line (str occ)
  (save-excursion
    (untabify (beginning-line-point) (end-line-point))
    (beginning-of-line)
    (let ((pos (search-forward str (end-line-point) t occ)))
      (if pos
      (1+ (- pos (length str)))
    nil))))

(defun line-up-str-pos (str occ col)
  (let ((cpos (position-in-line str occ))
    (rpos (+ (beginning-line-point) col)))
    (if (eq cpos nil)
    nil
      (if (< cpos rpos)
      (progn
        (goto-char (- cpos 1))
        (while (< (point) (- rpos 1))
          (insert " "))
        t)
    (progn
      (goto-char (- cpos 2))
      (while (and (> (point) (- rpos 2))
              (looking-at " "))
        (forward-char 1)
        (backward-delete-char-untabify 1)
        (backward-char 1))
      t)))))



(defun num-searches-until-reach (str orig-point)
  (let ((this-occ-point (search-forward str orig-point t)))
    (if (>= this-occ-point orig-point)
    1
      (progn
    (goto-char this-occ-point)
    (+ 1 (num-searches-until-reach str orig-point))))))


(defun occurrence-in-line (char pos)
  (save-excursion
    (beginning-of-line)
    (num-searches-until-reach char pos)))



(defun string-after (n)
  (buffer-substring (point) (+ n (point))))

(defun empty-line ()
  (equal 0 (- (end-line-point) (beginning-line-point))))

(defun line-up-on (n)
  "Line up further lines on length-n string found at point."
  (interactive "p")
  (save-excursion
    (let* ((str (string-after n))
       (occ (occurrence-in-line str (+ n (point))))
       (pos (position-in-line str occ)))
      (let ((mes (format "Lining up on occurence %d of `%s' ..." occ str)))
    (message "%s" mes)
    (let ((col (- pos (beginning-line-point))))
      (while (and (or (empty-line)
              (line-up-str-pos str occ col))
              (equal 0 (progn (end-of-line)
                      (forward-line 1))))))
    (message "%s done" mes)))))

(global-set-key "\M-'" 'line-up-on)


;; Fri Oct 20 13:02:34 2023
(add-hook 'go-mode-hook (lambda () (local-set-var whitespace-style '(face trailing))))


(defvar incrementing-number 0)

(defun insert-incrementing-number ()
  (interactive)
  (insert (number-to-string incrementing-number))
  (setq incrementing-number (+ incrementing-number 1)))

(defun reset-incrementing-number ()
  (interactive)
  (setq incrementing-number 0))

(defun increment-number-at-point ()
  (interactive)
  (let ((pos (point)))
    (forward-word 1)
    (forward-word -1)
    (if (looking-at "[0-9]+")
	(let* ((from (match-beginning 0))
	       (to (match-end 0))
	       (n (string-to-number (buffer-substring from to))))
	  (kill-region from to)
	  (insert (number-to-string (+ 1 n)))
	  (goto-char pos)))))
