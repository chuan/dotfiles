;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)


(package! flatbuffers-mode
  :recipe (:host github :repo "Asalle/flatbuffers-mode"))

(package! bison-mode
  :recipe (:host github :repo "Wilfred/bison-mode"))

(package! tree-sitter)
(package! tree-sitter-langs)
