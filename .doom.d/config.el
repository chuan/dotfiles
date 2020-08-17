;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package flatbuffers-mode
  :defer t
  :mode ("\\.fbs\\'" . flatbuffers-mode))

(use-package bison-mode
  :defer t
  :mode (("\\.yy?\\'" . bison-mode)
          ("\\.ll?\\'" . bison-mode))
  :config
  (setq bison-rule-separator-column 0)
  (setq bison-rule-enumeration-column 2))

(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

(setq lsp-auto-guess-root nil)

(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
