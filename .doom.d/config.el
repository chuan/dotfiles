;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Fonts
(setq doom-font (font-spec :family "monospace" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 14))

;; Persist Emacs’ initial frame position, dimensions and/or full-screen state across sessions
(when-let (dims (doom-store-get 'last-frame-size))
  (cl-destructuring-bind ((left . top) width height fullscreen) dims
    (setq initial-frame-alist
          (append initial-frame-alist
                  `((left . ,left)
                    (top . ,top)
                    (width . ,width)
                    (height . ,height)
                    (fullscreen . ,fullscreen))))))

(defun save-frame-dimensions ()
  (doom-store-put 'last-frame-size
                  (list (frame-position)
                        (frame-width)
                        (frame-height)
                        (frame-parameter nil 'fullscreen))))

(add-hook 'kill-emacs-hook #'save-frame-dimensions)

;; FlatBuffers
(use-package flatbuffers-mode
  :defer t
  :mode ("\\.fbs\\'" . flatbuffers-mode))

;; YACC
(use-package bison-mode
  :defer t
  :mode (("\\.yy?\\'" . bison-mode)
          ("\\.ll?\\'" . bison-mode))
  :config
  (setq bison-rule-separator-column 0)
  (setq bison-rule-enumeration-column 2))

;; PlantUML
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")

;; LSP
(setq lsp-auto-guess-root nil)
(setq lsp-keymap-prefix "s-l")
