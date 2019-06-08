(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
            '("marmalade" . "https://marmalade-repo.org/packages/") t)

(defvar my-packages '(auctex solarized-theme ido-ubiquitous idle-highlight-mode paredit better-defaults))

(package-initialize)
  (dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

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
