;;; tt-mode.el --- Major mode for editing Template Toolkit files  -*- lexical-binding: t; -*-

;; Copyright (C) 2002 Dave Cross, all rights reserved.

;; Author: Dave Cross <dave@dave.org.uk>
;;         Some enhancements by Steve Sanbeg
;; Version: 1.1.0
;; Keywords: languages
;; URL: https://github.com/davorg/tt-mode
;; Package-Requires: ((emacs "24.1"))

;; This file may be distributed under the same terms as GNU Emacs.

;;; Commentary:

;; This file adds syntax highlighting of Template Toolkit directives when
;; you are editing Template Toolkit files.
;;
;; Files with a .tt extension are automatically associated with this mode.
;; You can also activate it manually with M-x tt-mode.
;;
;; See https://github.com/davorg/tt-mode for more information.

;;; Code:

(require 'font-lock)

(defvar tt-keywords
  (concat "\\b\\(?:"
          (regexp-opt (list "GET" "CALL" "SET" "DEFAULT" "INSERT" "INCLUDE"
                            "BLOCK" "END" "PROCESS" "WRAPPER" "IF" "UNLESS"
                            "ELSIF" "ELSE" "SWITCH" "CASE" "FOR" "FOREACH"
                            "WHILE" "FILTER" "USE" "MACRO" "PERL" "RAWPERL"
                            "TRY" "THROW" "CATCH" "FINAL" "LAST" "RETURN"
                            "STOP" "CLEAR" "META" "TAGS"))
          "\\)\\b")
  "Regexp matching Template Toolkit keywords.")

(defvar tt-font-lock-keywords
  (list
   ;; Fontify [% ... %] expressions
   '("\\(\\[%[-+]?\\)\\(\\(.\\|\n\\)+?\\)\\([-+]?%\\]\\)"
     (1 font-lock-builtin-face t)
     (2 font-lock-variable-name-face t)
     (4 font-lock-builtin-face t))

   '("\\[% *\\([a-z_0-9]*\\) *%\\]"
     (1 font-lock-constant-face t))

   ;; Line comment - doesn't find multiple comments in a block yet.
   ;; Use (?:[^%]|%[^]]) to avoid crossing %] block boundaries (prevents
   ;; href="#" in HTML from being misidentified as a comment).
   '("\\[%\\(?:[^%]\\|%[^]]\\)*?\\(#.*?\\)\\(?:\n\\|%\\]\\)"
     (1 font-lock-comment-face t))

   ;; Block comment
   '("\\[%\\(#\\(.\\|\n\\)*?\\)%\\]"
     (1 font-lock-comment-face t))

   ;; Look for keywords within those expressions
   (list (concat
          "\\(\\[%[-+]?\\|;\\)\\(\\s-\\|\n\\)*\\("
          tt-keywords
          "\\)")
         3 font-lock-keyword-face t))
  "Font-lock keywords for `tt-mode'.")

;;;###autoload
(define-derived-mode tt-mode fundamental-mode "TT"
  "Major mode for editing Template Toolkit files."
  ;; Single-quoted strings highlight the same as double-quoted
  (modify-syntax-entry ?' "\"" tt-mode-syntax-table)
  (modify-syntax-entry ?% "." tt-mode-syntax-table)
  (setq font-lock-defaults '(tt-font-lock-keywords nil t)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.tt\\'" . tt-mode))

(provide 'tt-mode)

;;; tt-mode.el ends here
