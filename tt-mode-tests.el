;;; tt-mode-tests.el --- ERT tests for tt-mode  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Dave Cross, all rights reserved.

;; This file may be distributed under the same terms as GNU Emacs.

;;; Commentary:

;; ERT (Emacs Lisp Regression Testing) tests for tt-mode.
;; Run with: emacs --batch -l tt-mode-tests.el -f ert-run-tests-batch-and-exit

;;; Code:

(require 'ert)
(require 'tt-mode)

(ert-deftest tt-mode-test-activates ()
  "Test that `tt-mode' can be activated and sets `major-mode'."
  (with-temp-buffer
    (tt-mode)
    (should (eq major-mode 'tt-mode))))

(ert-deftest tt-mode-test-mode-name ()
  "Test that `tt-mode' sets `mode-name' to \"TT\"."
  (with-temp-buffer
    (tt-mode)
    (should (equal mode-name "TT"))))

(ert-deftest tt-mode-test-font-lock-defaults ()
  "Test that `font-lock-defaults' is set correctly."
  (with-temp-buffer
    (tt-mode)
    (should (equal (car font-lock-defaults) 'tt-font-lock-keywords))))

(ert-deftest tt-mode-test-hook-runs ()
  "Test that `tt-mode-hook' is run when the mode is activated."
  (let* ((hook-ran nil)
         (test-hook (lambda () (setq hook-ran t))))
    (add-hook 'tt-mode-hook test-hook)
    (unwind-protect
        (with-temp-buffer
          (tt-mode)
          (should hook-ran))
      (remove-hook 'tt-mode-hook test-hook))))

(ert-deftest tt-mode-test-auto-mode-alist ()
  "Test that `.tt' files are associated with `tt-mode'."
  (should (rassq 'tt-mode auto-mode-alist)))

(ert-deftest tt-mode-test-syntax-table-single-quote ()
  "Test that single quotes are treated as string delimiters."
  (with-temp-buffer
    (tt-mode)
    ;; Single quote should have string syntax (class 7 = string quote)
    (should (= (char-syntax ?') ?\"))))

(ert-deftest tt-mode-test-keywords-not-empty ()
  "Test that the TT keywords regexp is non-empty."
  (should (stringp tt-keywords))
  (should (> (length tt-keywords) 0)))

(ert-deftest tt-mode-test-font-lock-keywords-not-empty ()
  "Test that `tt-font-lock-keywords' contains entries."
  (should (listp tt-font-lock-keywords))
  (should (> (length tt-font-lock-keywords) 0)))

(defun tt-mode-test--face-at-string (content search-string)
  "Return the face at the start of SEARCH-STRING within CONTENT in tt-mode."
  (with-temp-buffer
    (insert content)
    (tt-mode)
    (font-lock-ensure)
    (goto-char (point-min))
    (search-forward search-string)
    (get-text-property (match-beginning 0) 'face)))

(ert-deftest tt-mode-test-href-hash-not-comment ()
  "Test that href=\"#\" in HTML is not highlighted as a comment.
Regression test: the line comment regex must not span across TT block
boundaries (i.e. across %]) and incorrectly match # in HTML attributes."
  (let ((face (tt-mode-test--face-at-string
               "[% IF condition %]\n<a href=\"#\">link</a>\n"
               "#")))
    (should-not (eq face 'font-lock-comment-face))))

(ert-deftest tt-mode-test-line-comment-in-directive ()
  "Test that a # comment inside a TT directive is highlighted as a comment."
  (let ((face (tt-mode-test--face-at-string
               "[% x = 1 # this is a comment\n%]"
               "# this is a comment")))
    (should (eq face 'font-lock-comment-face))))

;;; tt-mode-tests.el ends here
