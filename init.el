(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;;(add-to-list 'package-archives
   ;;         '("marmalade" . "https://marmalade-repo.org/packages/") t)

(defvar my-packages '(auctex solarized-theme ido-completing-read+ idle-highlight-mode paredit better-defaults use-package  exec-path-from-shell))

(package-initialize)
  (dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; set a default font
;;(when (member "DejaVu Sans Mono" (font-family-list))
   ;;(set-face-attribute 'default nil :font "DejaVu Sans Mono"))
(when (member "Source Code Pro" (font-family-list))
  (set-face-attribute 'default nil :font "Source Code Pro"))

(set-face-attribute 'default nil :height 208)
(setq ring-bell-function 'ignore)
(setq dired-listing-switches "-lt")
(setq large-file-warning-threshold nil)
;;(require 'mouse)
;;(xterm-mouse-mode t)
;;(mouse-wheel-mode t)
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; scroll one line at a time
;;(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;;(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;;(setq scroll-step 1) ;; scroll smoothly

; AucTeX

(setq gc-cons-threshold 20000000)

(defun send-to-osx-grammarly-push ()
  "Save region to a tempfile and run Grammarly on it."
  (interactive)
  (kill-region (region-beginning) (region-end))
  (call-process-shell-command "osascript ~/.emacs.d/emacs-grammarly/scripts/push.scpt"))

(defun send-to-osx-grammarly-pull()
  "Save region to a tempfile and run Grammarly on it."
  (interactive)
  (call-process-shell-command "osascript ~/.emacs.d/emacs-grammarly/scripts/pull.scpt")
  (yank)
  )

;;(latex-preview-pane-enable)

;; AucTeX settings
(setq TeX-PDF-mode t)
(setq auctex-latexmk-inherit-TeX-PDF-mode t)
(turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(reftex-isearch-minor-mode)

(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)

  ;;(add-hook 'LaTeX-mode-hook
  ;;          (lambda ()
  ;;            (push
  ;;             '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
  ;;               :help "Run latexmk on file")
  ;;             TeX-command-list)))
  ;;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;;elpy
;;(elpy-enable)
;;
;;;; Use IPython for REPL
;;(setq python-shell-interpreter "jupyter"
;;      python-shell-interpreter-args "console --simple-prompt"
;;      python-shell-prompt-detect-failure-warning nil)
;;(add-to-list 'python-shell-completion-native-disabled-interpreters
;;             "jupyter")

;;(setq TeX-auto-save t)
;;(setq TeX-parse-self t)
;;(setq-default TeX-master nil)
;;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)


;;
(add-hook 'TeX-mode-hook
	  (lambda () (TeX-fold-mode 1))); Automatically activate TeX-fold-mode.
;;(add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
(eval-after-load "preview"
  '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t)
  )
;;(add-hook 'latex-mode-hook #'xenops-mode)
;;(add-hook 'LaTeX-mode-hook #'xenops-mode)

;;(use-package preview-auto)
;;(setq preview-locating-previews-message nil)
;;(setq preview-protect-point t)
;;(setq preview-leave-open-previews-visible t)
;;(setq preview-LaTeX-command-replacements '(preview-LaTeX-disable-pdfoutput))
;;(add-to-list 'preview-auto--extra-environments "tikzpicture")

;;(use-package preview-auto
;;  :after latex
;;  :config
;;  (setq preview-protect-point t)
;;  (setq preview-locating-previews-message nil)
;;  (setq preview-leave-open-previews-visible t)
;;  :custom
;;  (preview-auto-interval 0.1)
;;  (preview-LaTeX-command-replacements
;;   '(preview-LaTeX-disable-pdfoutput)))  

(require 'auctex-latexmk)
    (auctex-latexmk-setup)

(use-package auctex-cont-latexmk
  :after latex
  :bind
  (:map LaTeX-mode-map
 	("C-c k" . auctex-cont-latexmk-toggle)))

;;(require 'recentf)
;;(recentf-mode t)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-virtual-buffers t)
(ido-mode 1)

(global-auto-revert-mode t)
(global-font-lock-mode 1)

;;(desktop-save-mode 1)
;;(eyebrowse-mode t) 

;;(use-package persp-mode
;;  :ensure t
;;  )
;;
;;(with-eval-after-load "persp-mode-autoloads"
;;      (setq wg-morph-on nil) ;; switch off animation
;;      (setq persp-autokill-buffer-on-remove 'kill-weak)
;;      (add-hook 'window-setup-hook #'(lambda () (persp-mode 1))))
;;
;;;; eshell
;;(persp-def-buffer-save/load
;; :mode 'eshell-mode :tag-symbol 'def-eshell-buffer
;; :save-vars '(major-mode default-directory))
;;
;;(persp-def-buffer-save/load
;; :mode 'shell-mode
;; :mode-restore-function #'(lambda (_mode) (shell)) ; or #'identity if you do not want to start shell process
;; :tag-symbol 'def-shell
;; :save-vars '(major-mode default-directory))


(exec-path-from-shell-initialize)
(exec-path-from-shell-copy-env "HISTFILE")

(defun turn-on-comint-history (history-file)
          (setq comint-input-ring-file-name history-file)
          (comint-read-input-ring 'silent))

(add-hook 'shell-mode-hook
          (lambda ()
            (turn-on-comint-history (getenv "HISTFILE"))))

;;(add-hook 'kill-buffer-hook #'comint-write-input-ring)
;;(add-hook 'kill-emacs-hook
;;          (lambda ()
;;            (--each (buffer-list)
;;		    (with-current-buffer it (comint-write-input-ring)))))

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





(defun vterm-here ()
  "Opens up a new shell in the directory associated with the
current buffer's file. The vterm is renamed to match that
directory to make multiple vterm windows easier."
  (interactive)
  (let* ((parent (if (buffer-file-name)
                     (file-name-directory (buffer-file-name))
                   default-directory))
         (height (/ (window-total-height) 3))
         (name   (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (vterm)
    (rename-buffer (concat "*vterm: " name "*"))))

(global-set-key (kbd "C-c SPC") 'vterm-here)


(use-package pdf-tools
      :ensure t
      :config
      (custom-set-variables
        '(pdf-tools-handle-upgrades nil)) ; Use brew upgrade pdf-tools instead.
     (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo"))
;;(pdf-tools-install)
(pdf-loader-install)
(setq-default pdf-view-display-size 'fit-page)

;;(psession-mode 1)
;;(psession-savehist-mode 1)
;;(psession-autosave-mode 1)

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line

(setenv "PATH" (concat "/usr/local/smlnj/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/local/smlnj/bin" exec-path))

(when (fboundp 'eww)
  (defun xah-rename-eww-buffer ()
    "Rename `eww-mode' buffer so sites open in new page.
URL `http://xahlee.info/emacs/emacs/emacs_eww_web_browser.html'
Version 2017-11-10"
    (let (($title (plist-get eww-data :title)))
      (when (eq major-mode 'eww-mode )
        (if $title
            (rename-buffer (concat "eww " $title ) t)
          (rename-buffer "eww" t)))))

  (add-hook 'eww-after-render-hook 'xah-rename-eww-buffer))
(defun ediff-window-display-p () nil)
;;(require-theme 'modus-themes)

;; All customizations here
;;(setq modus-themes-bold-constructs t
  ;;    modus-themes-italic-constructs t)

;; Maybe define some palette overrides, such as by using our presets
;;(setq modus-themes-common-palette-overrides
;;      modus-themes-preset-overrides-intense)

;; Load the theme of choice (built-in themes are always "safe" so they
;; do not need the `no-require' argument of `load-theme').
(load-theme 'modus-vivendi)

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package python
  :bind (:map python-ts-mode-map
              ("<f5>" . recompile)
              ("<f6>" . eglot-format))
  :hook ((python-ts-mode . eglot-ensure)
         (python-ts-mode . company-mode))
  :mode (("\\.py\\'" . python-ts-mode)))

;;(require 'ein)
;;(require 'ein-notebook)
;;(require 'ein-subpackages)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 1))

(use-package eglot
  :bind (:map eglot-mode-map
              ("C-c d" . eldoc)
              ("C-c a" . eglot-code-actions)
              ("C-c f" . flymake-show-buffer-diagnostics)
              ("C-c r" . eglot-rename)))

(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))
(defun my-sml-mode-hook () "Local defaults for SML mode"
       (setq sml-indent-level 2)        ; conserve on horizontal space
       (setq words-include-escape t)    ; \ loses word break status
       (setq indent-tabs-mode nil))     ; never ever indent with tabs
(add-hook 'sml-mode-hook 'my-sml-mode-hook)

;;(setq code-cells-convert-ipynb-style '(("pandoc" "--to" "ipynb" "--from" "org")
  ;;                                     ("pandoc" "--to" "org" "--from" "ipynb")
    ;;                                   (lambda () #'org-mode)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
;;   (julia . t)
   (python . t)
   (jupyter . t)))

(require 'real-auto-save)
(add-hook 'prog-mode-hook 'real-auto-save-mode)
(setq real-auto-save-interval 1) ;; in seconds

(auto-save-visited-mode 1)
(setq auto-save-visited-interval 1)


;;(require 'tempo)
;;(setq tempo-interactive t)
;;
;;(defvar tempo-tags nil
;;  "Tempo tags for C++ mode")
;;
;;(tempo-use-tag-list 'tempo-tags)



;;(defun my-tempo-c-cpp-bindings ()
;;  ;;(local-set-key (read-kbd-macro "<f8>") 'tempo-forward-mark)
;;  (local-set-key (read-kbd-macro "C-<return>")   'tempo-complete-tag)
;;  (local-set-key (read-kbd-macro "<f5>")   'tempo-complete-tag)
;;  (tempo-use-tag-list 'tempo-tags))

;;(add-hook 'c-mode-hook   '(lambda () (my-tempo-c-cpp-bindings)))
;;(add-hook 'c++-mode-hook '(lambda () (my-tempo-c-cpp-bindings)))

;; the following macros allow to set point using the ~ character in tempo templates

;;(defvar tempo-initial-pos nil
;;  "Initial position in template after expansion")
;;(defadvice tempo-insert( around tempo-insert-pos act )
;;  "Define initial position."
;;  (if (eq element '~)
;;      (setq tempo-initial-pos (point-marker))
;;    ad-do-it))
;;(defadvice tempo-insert-template( around tempo-insert-template-pos act )
;;  "Set initial position when defined. ChristophConrad"
;;  (setq tempo-initial-pos nil)
;;  ad-do-it
;;  (if tempo-initial-pos
;;      (progn
;;        (put template 'no-self-insert t)
;;        (goto-char tempo-initial-pos))
;;    (put template 'no-self-insert nil)))


;;(use-package tempel
;;  ;; Require trigger prefix before template name when completing.
;;  ;; :custom
;;  ;; (tempel-trigger-prefix "<")
;;
;;  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
;;         ("M-*" . tempel-insert))
;;
;;  :init
;;
;;  ;; Setup completion at point
;;  (defun tempel-setup-capf ()
;;    ;; Add the Tempel Capf to `completion-at-point-functions'.
;;    ;; `tempel-expand' only triggers on exact matches. Alternatively use
;;    ;; `tempel-complete' if you want to see all matches, but then you
;;    ;; should also configure `tempel-trigger-prefix', such that Tempel
;;    ;; does not trigger too often when you don't expect it. NOTE: We add
;;    ;; `tempel-expand' *before* the main programming mode Capf, such
;;    ;; that it will be tried first.
;;    (setq-local completion-at-point-functions
;;                (cons #'tempel-expand
;;                      completion-at-point-functions)))
;;
;;  (add-hook 'conf-mode-hook 'tempel-setup-capf)
;;  (add-hook 'prog-mode-hook 'tempel-setup-capf)
;;  (add-hook 'text-mode-hook 'tempel-setup-capf)
;;
;;  ;; Optionally make the Tempel templates available to Abbrev,
;;  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
;;  ;; (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
;;  ;; (global-tempel-abbrev-mode)
;;)
;;
;;;; Optional: Add tempel-collection.
;;;; The package is young and doesn't have comprehensive coverage.
;;;;(use-package tempel-collection)
;;
;;;; Optional: Use the Corfu completion UI
;;(use-package corfu
;;  :init
;;  (global-corfu-mode))

;;(abstract "\\begin{abstract}\n" r> n> "\\end{abstract}")


(add-to-list 'load-path "~/.emacs.d/lisp")
(autoload 'tempo-define-snippet "tempo-snippets")
;;
;; Then use `tempo-define-snippet' instead of `tempo-define-template'.  The
;; arguments can remain the same.  Insertion works like for any tempo-template
;; with `tempo-template-your-template-name'.
;;
;; You can replace all templates by snippets with the following line.
;; Use with care!
;;(defalias 'tempo-define-template 'tempo-define-snippet)
;;
;; When adding lisp forms in your templates that use `tempo-lookup-named', make
;; sure they don't have side-effects, because they will be evaluated every time
;; the variables change.
;;
;;
;; Here are two examples:
;;
 (tempo-define-snippet "java-class"
   '("class " (p "Class: " class) " {\n\n"
     > "public " (s class) "(" p ") {\n" > p n
     "}" > n n "}" > n))

 (tempo-define-snippet "java-get-set"
   '("private " (p "Type: " type) " _" (p "Name: " var) ";\n\n"
     > "public " (s type) " get" (upcase-initials (tempo-lookup-named 'var))
     "() {\n"
     > "return _" (s var)  ";\n" "}" > n n
     > "public set" (upcase-initials (tempo-lookup-named 'var))
     "(" (s type) " value) {\n"
     > "_" (s var) " = value;\n" "}" > n))

  (tempo-define-snippet "c-for-it"
    '(> "for (" (p "Type: " type) "::iterator " (p "Iterator: " it) " = "
        (p "Container: " container) ".begin();" n>
        (s it) " != " (s container) ".end(); ++" (s it) ") {" > n> r n "}" >)
    "fori"
    "Insert a C++ for loop iterating over an STL container."
    nil)


(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ;; personal snippets
        ))

(yas-global-mode 1)
