;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! flatbuffers-mode :mode "\\.fbs")

(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

(setq lsp-auto-guess-root nil)

(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
