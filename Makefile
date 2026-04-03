EMACS ?= emacs

.PHONY: all byte-compile test clean

all: test

byte-compile:
	$(EMACS) --batch -f batch-byte-compile tt-mode.el

test: byte-compile
	$(EMACS) --batch -L . -l tt-mode-tests.el -f ert-run-tests-batch-and-exit

clean:
	rm -f *.elc
