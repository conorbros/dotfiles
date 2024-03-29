;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Conor"
      user-mail-address "conorbros@protonmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
(setq doom-font (font-spec :family "Hack" :size 18 )
      doom-variable-pitch-font (font-spec :family "Hack" :size 18)) ; inherits `doom-font''s :size

      ;;doom-unicode-font (font-spec :family "Hack" :size 16)
      ;;doom-big-font (font-spec :family "Hack" :size 19))
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-ayu-mirage)

;; (defun synchronize-theme ()
;;   (let* ((light-theme 'doom-gruvbox)
;;           (dark-theme 'doom-ayu-mirage)
;;          (start-time-light-theme 6)
;;           (end-time-light-theme 9)
;;          (hour (string-to-number (substring (current-time-string) 11 13)))
;;           (next-theme (if (member hour (number-sequence start-time-light-theme end-time-light-theme))
;;                           light-theme dark-theme)))
;;      (when (not (equal doom-theme next-theme))
;;        (setq doom-theme next-theme)
;;        (load-theme next-theme))))

;; (run-with-timer 0 900 'synchronize-theme)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type t)
;; (setq display-line-numbers-type 'relative)
(setq-default display-line-numbers 'relative)

(defun baal-display-lines-relative ()
  "If `display-line-numbers' is non-nil, switch to relative."
 (when display-line-numbers
    (setq-local display-line-numbers 'relative)))

(defun baal-display-lines-absolute ()
  "If `display-line-numbers' is non-nil, switch to absolute."
  (when display-line-numbers
    (setq-local display-line-numbers t)))

(add-hook 'evil-insert-state-entry-hook #'baal-display-lines-absolute)
(add-hook 'evil-normal-state-entry-hook #'baal-display-lines-relative)

(setq-default display-line-numbers nil)

(defun enable-display-line-numbers ()
  (setq-local display-line-numbers 'relative))

(add-hook 'prog-mode-hook #'enable-display-line-numbers)

(require 'treemacs-all-the-icons)
(setq doom-themes-treemacs-theme "all-the-icons")


(require 'toml-mode)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


(setq racer-rust-src-path
      (let* ((sysroot (string-trim
                       (shell-command-to-string "rustc --print sysroot")))
             (lib-path (concat sysroot "/lib/rustlib/src/rust/library"))
              (src-path (concat sysroot "/lib/rustlib/src/rust/src")))
        (or (when (file-exists-p lib-path) lib-path)
            (when (file-exists-p src-path) src-path))))
