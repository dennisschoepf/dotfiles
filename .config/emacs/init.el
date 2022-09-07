

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                        ("org" . "https://orgmode.org/elpa/")
                        ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
(package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
(package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(global-auto-revert-mode 1)
(delete-selection-mode 1)
(savehist-mode 1)
(set-fringe-mode 10)
(recentf-mode 1)

(setq inhibit-startup-message t)
(setq-default indent-tabs-mode nil)
(setq display-line-numbers-type 'relative)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
;; Activate if using a dark theme
;; (add-to-list 'default-frame-alist '(ns-appearance . dark))

(setq mac-option-modifier nil)
(setq mac-command-modifier 'meta)
(setq mac-command-key-is-meta t)
;; (setq mac-right-option-modifier nil)

(global-set-key (kbd "s-W") 'delete-frame) ; ⌘-W = Close window
(global-set-key (kbd "s-}") 'tab-bar-switch-to-next-tab) ; ⌘-} = Next tab
(global-set-key (kbd "s-{") 'tab-bar-switch-to-prev-tab) ; ⌘-{ = Previous tab
(global-set-key (kbd "s-t") 'tab-bar-new-tab) ;⌘-t = New tab
(global-set-key (kbd "s-w") 'tab-bar-close-tab) ; ⌘-w = Close tab

(unless (< emacs-major-version 28)
(global-set-key (kbd "s-Z") 'undo-redo)) ; ⌘-Z = Redo

(set-face-attribute 'default nil :font "JetBrains Mono" :height 145)
(set-face-attribute 'fixed-pitch nil :font "JetBrains Mono" :height 145)
(set-face-attribute 'variable-pitch nil :font "IBM Plex Sans" :height 145 :weight 'regular)

(use-package doom-themes
:ensure t
:config
;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
    doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-ayu-light t)
(doom-themes-visual-bell-config)
(doom-themes-org-config))

(use-package all-the-icons
:ensure t)

(use-package doom-modeline
:ensure t
:init (doom-modeline-mode 1))

(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Enable vertico
(use-package vertico
:bind (:map vertico-map
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous)
        ("C-f" . vertico-exit)
        :map minibuffer-local-map
        ("M-h" . backward-kill-word))
:custom
(vertico-cycle t)
:init
(vertico-mode))

;; A few more useful configurations...
(use-package emacs
:init
;; Add prompt indicator to `completing-read-multiple'.
;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
(defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                    "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                    crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;; Do not allow the cursor in the minibuffer prompt
(setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Emacs 28: Hide commands in M-x which do not work in the current mode.
;; Vertico commands are hidden in normal buffers.
;; (setq read-extended-command-predicate
;;       #'command-completion-default-include-p)

;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t))

(use-package marginalia
:after vertico
:ensure t
:custom
(marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
:init
(marginalia-mode))

(use-package orderless
:ensure t
:custom
(completion-styles '(orderless basic))
(completion-category-overrides '((file (styles basic partial-completion)))))

(use-package embark
:ensure t
:bind
(("C-." . embark-act)         ;; pick some comfortable binding
("C-;" . embark-dwim)        ;; good alternative: M-.
("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
:init
;; Optionally replace the key help with a completing-read interface
(setq prefix-help-command #'embark-prefix-help-command)
:config
;; Hide the mode line of the Embark live/completions buffers
(add-to-list 'display-buffer-alist
            '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                nil
                (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
:ensure t
:after (embark consult)
:demand t
:hook
(embark-collect-mode . consult-preview-at-point-mode))

(use-package consult
:hook (completion-list-mode . consult-preview-at-point-mode)
:init
(setq register-preview-delay 0.5
    register-preview-function #'consult-register-format)
(advice-add #'register-preview :override #'consult-register-window)
(setq xref-show-xrefs-function #'consult-xref
    xref-show-definitions-function #'consult-xref)
:config
;; Optionally configure preview. The default value
;; is 'any, such that any key triggers the preview.
(setq consult-preview-key 'any)
;; (setq consult-preview-key (kbd "M-."))
;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
;; For some commands and buffer sources it is useful to configure the
;; :preview-key on a per-command basis using the `consult-customize' macro.
(consult-customize
consult-theme
:preview-key '(:debounce 0.2 any)
consult-ripgrep consult-git-grep consult-grep
consult-bookmark consult-recent-file consult-xref
consult--source-bookmark consult--source-recent-file
consult--source-project-recent-file
:preview-key (kbd "M-.")))

(use-package company
  :ensure t
  :pin melpa
  :custom
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 2)
  (company-selection-wrap-around t)
  (company-backends '((company-capf company-dabbrev-code)))
  :init
  (company-tng-configure-default)
  (add-hook 'after-init-hook 'global-company-mode))

(use-package rg)
(use-package ripgrep)
(use-package projectile
  :ensure t
  :custom
  (projectile-project-search-path '("~/Projects/"))
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("s-p" . projectile-command-map)))

(use-package diredfl
  :hook
  (dired-mode . diredfl-mode)
  :config
  (set-face-attribute 'diredfl-dir-name nil :bold t))

(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a :custom option
   '(("h" "~/"                          "Home")
     ("p" "~/Projects/"                 "Projects")
     ("n" "~/notes/"                    "Notes")
     ("d" "~/Downloads/"                "Downloads")))
  :config
  ;; (dirvish-peek-mode) ; Preview files in minibuffer
  (setq dirvish-mode-line-format
        '(:left (sort file-time " " file-size symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(all-the-icons file-size collapse subtree-state vc-state git-msg))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --time-style=long-iso --group-directories-first --no-group")
  :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish-fd)
   :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
   ("a"   . dirvish-quick-access)
   ("f"   . dirvish-file-info-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("h"   . dirvish-history-jump) ; remapped `describe-mode'
   ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
   ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
   ("TAB" . dirvish-subtree-toggle)
   ("M-f" . dirvish-history-go-forward)
   ("M-b" . dirvish-history-go-backward)
   ("M-l" . dirvish-ls-switches-menu)
   ("M-m" . dirvish-mark-menu)
   ("M-t" . dirvish-layout-toggle)
   ("M-s" . dirvish-setup-menu)
   ("M-e" . dirvish-emerge-menu)
   ("M-j" . dirvish-fd-jump)))

(use-package magit)

(use-package org
  :custom
  (org-directory "~/orgnzr")
  (org-agenda-files '("~/orgnzr" "~/notes"))
  (org-log-done t)
  (org-log-into-drawer t)
  (org-todo-keywords '((sequence "TODO" "NEXT" "WAITING" "PROJECT" "|" "DONE" "CANCELLED")))
  (org-capture-templates
  '(("j" "Journal"
      entry (file+datetree "~/notes/journal.org")
      "\n* %?\n\nEntered on %U\n"))))

(custom-set-faces
  '(org-document-title ((t (:inherit document-title :height 2.2))))
  '(org-level-1 ((t (:inherit outline-1 :height 1.6))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.4))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.2))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.1))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

(use-package org-superstar)
(setq org-superstar-remove-leading-stars t)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package olivetti)

(defun dnsc/writing-setup ()
    (olivetti-mode)
    (olivetti-set-width 90))

(add-hook 'text-mode-hook 'dnsc/writing-setup)



(use-package org-roam
  :custom
  (org-roam-directory "~/notes")
  :init
  (org-roam-db-autosync-mode))

(use-package websocket
  :after org-roam)

(use-package org-roam-ui
  :after org
  :config
  (setq org-roam-ui-sync-theme t
    org-roam-ui-follow t
    org-roam-ui-update-on-save t
    org-roam-ui-open-on-start t))

(use-package evil
:init
(setq evil-want-integration t)
(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump nil)
:config
(evil-mode 1)
(define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

;; Use visual line motions even outside of visual-line-mode buffers
(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line)

(evil-set-initial-state 'messages-buffer-mode 'normal)
(evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
:after evil
:config
(evil-collection-init))

(use-package which-key
:init (which-key-mode)
:diminish which-key-mode
:config
(setq which-key-idle-delay 1))

(use-package general
:config
(general-evil-define-key 'normal 'global
    :prefix "SPC"
    ;; Special bindings
    "." 'load-file
    "SPC" 'projectile-find-file
    ;; Find in project "SPC" '?
    ;; File Management
    "fs" 'save-buffer
    "fo" 'load-file
    "fr" 'consult-recent-file
    ;; Buffer Management
    "bd" 'kill-this-buffer
    "B" 'consult-buffer
    ;; Window Management
    "wd" 'delete-window 
    "wk" 'windmove-up
    "wh" 'windmove-left
    "wl" 'windmove-right
    "wj" 'windmove-down
    "wv" 'split-window-right
    "ws" 'split-window-below
    ;; Project Management
    "pp" 'projectile-switch-project
    "pa" 'projectile-add-known-project
    "pd" 'projectile-remove-known-project
    "po" 'projectile-dired
    "pr" 'projectile-replace
    "ps" 'projectile-ripgrep
    ;; Search
    "sf" 'consult-line
    "ss" 'consult-ripgrep
    ;; Notes
    "rc" 'org-roam-capture
    "rn" 'org-roam-node-find
    "ri" 'org-roam-node-insert
    "rb" 'org-roam-buffer
    "rd" 'org-capture-goto-target
    ;; Tasks
    "oa" 'org-agenda
    "oc" 'org-capture
    ;; Git
    "gg" 'magit-status))
