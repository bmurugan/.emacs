(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
            '("marmalade" . "https://marmalade-repo.org/packages/") t)

;;(defvar my-packages '(ido-ubiquitous idle-highlight-mode paredit better-defaults))
    
;;(package-initialize)
;;(dolist (p my-packages)
;;  (when (not (package-installed-p p))
;;    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/elpa/emacs-application-framework")
(require 'eaf)

;; set a default font
(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
;;
(add-hook 'TeX-mode-hook
      (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defun xxtest ()
  "test"
  (interactive)
  (let (myline)
    (setq myline (thing-at-point 'line) )
    (setq matched (string-match "{\\([^}]+\\)}" myline))
    (start-process "inks" nil "inkscape"  (concat (file-name-directory buffer-file-name)  "images/" (match-string 1 myline)))
    ;;(message "got this %s" (concat (file-name-directory buffer-file-name) "images/" (match-string 1 myline)))
    ;;(message "got this: %s" myline)
    ) )
;;  \includegraphics[width=1\textwidth]{SoC-steps.pdf}
;; make latexmk available via C-c C-c
;;(add-hook 'LaTeX-mode-hook (lambda ()
;;  (push
;;    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;;      :help "Run latexmk on file")
;;    TeX-command-list)))
;;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;;(require 'recentf)
;;
;;;; get rid of `find-file-read-only' and replace it with something
;;;; more useful.
;;(global-set-key (kbd "C-x C-r") 'ido-recentf-open)
;;
;;;; enable recent files mode.
;;(recentf-mode t)
;;
;;; 50 files ought to be enough.
;;(setq recentf-max-saved-items 50)
;;
;;(defun ido-recentf-open ()
;;  "Use `ido-completing-read' to \\[find-file] a recent file"
;;  (interactive)
;;  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
;;      (message "Opening file...")
;;    (message "Aborting")))
;;

(desktop-save-mode 1)
;;--no-desktop

;;(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean
;;(setq-default save-place t)                   ;; activate it for all buffers
;;(require 'saveplace)                          ;; get the package


;;(setq ido-enable-flex-matching t)
;;(setq ido-everywhere t)
;;(ido-mode 1)
;;(require 'find-dired)
;;(setq find-ls-option '("-print0 | xargs -0 ls -ld" . "-ld"))
;;
;;(require 'eshell)
;;(require 'em-smart)
;;(setq eshell-where-to-jump 'begin)
;;(setq eshell-review-quick-commands nil)
;;(setq eshell-smart-space-goes-to-end t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(fset 'float-includegraphics
   [?\C-s ?^ ?\\ ?s ?- ?* ?\\ ?\\ ?i ?n ?c ?l ?u ?d ?e ?g ?r ?a ?p ?h return ?\C-a ?\\ ?b ?e ?g ?i ?n ?\{ ?f ?i ?g ?u ?r ?e ?\} ?\[ ?h ?t ?b ?p ?! ?\] return tab ?\\ ?c ?e ?n ?t ?e ?r ?i ?n ?g return tab ?\C-e return ?\\ ?e ?n ?d ?\{ ?f ?i ?g ?u ?r ?e ?\} tab return ?\C-k backspace return up ?\C-e ?\C-x ?\C-s])

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   '(solarized-theme px paredit latex-preview-pane ido-ubiquitous idle-highlight-mode idle-highlight better-defaults auctex))
 '(safe-local-variable-values '((TeX-master . t))))
