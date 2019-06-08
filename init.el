(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(add-to-list 'package-archives
            '("marmalade" . "https://marmalade-repo.org/packages/") t)

(defvar my-packages '(auctex solarized-theme ido-completing-read+ idle-highlight-mode paredit better-defaults))

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


(defun eshell-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The eshell is renamed to match that
directory to make multiple eshell windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))

    (insert (concat "ls"))
    (eshell-send-input)))

(global-set-key (kbd "C-x SPC") 'eshell-here)

(defun eshell/x ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))
