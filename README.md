# tt-mode

[![Static Badge](https://img.shields.io/badge/github-repo-blue?logo=github)](https://github.com/davorg/tt-mode)
[![MELPA](https://melpa.org/packages/tt-mode-badge.svg)](https://melpa.org/#/tt-mode)
[![License: GPL](https://img.shields.io/badge/License-GPL-blue.svg)](https://www.gnu.org/copyleft/gpl.html)

An Emacs major mode for editing [Template Toolkit](http://tt2.org/) files.

## Features

- Syntax highlighting for Template Toolkit directives (`[% ... %]`)
- Highlights TT keywords (`IF`, `FOREACH`, `INCLUDE`, `BLOCK`, etc.)
- Highlights variable names, constants, and comments within TT tags
- Automatically activates for files with a `.tt` extension

## Installation

### Via MELPA (recommended)

`tt-mode` is available on [MELPA](https://melpa.org/#/tt-mode). If you have
MELPA configured as a package source, you can install it with:

```
M-x package-install RET tt-mode RET
```

### Manual installation

1. Download `tt-mode.el` from the
   [GitHub repository](https://github.com/davorg/tt-mode/).
2. Place it somewhere on your Emacs `load-path`.
3. Add the following to your `.emacs` or `init.el`:

```elisp
(autoload 'tt-mode "tt-mode")
(add-to-list 'auto-mode-alist '("\\.tt\\'" . tt-mode))
```

## Usage

Once installed, `tt-mode` will be activated automatically when you open a
file with a `.tt` extension. You can also activate it manually with:

```
M-x tt-mode
```

### What gets highlighted

| Element | Face |
|---------|------|
| `[%` and `%]` delimiters | `font-lock-builtin-face` |
| Content inside TT tags | `font-lock-variable-name-face` |
| TT keywords (`IF`, `FOREACH`, etc.) | `font-lock-keyword-face` |
| Simple variable expressions | `font-lock-constant-face` |
| Comments (`[%# ... %]` and inline `#`) | `font-lock-comment-face` |

## Contributing

This started as an afternoon of Emacs Lisp hacking in 2002. There are,
no doubt, many improvements that can be made. Contributions are very
welcome!

To contribute:

1. Fork the [GitHub repository](https://github.com/davorg/tt-mode/)
2. Make your changes
3. Submit a pull request

If you have suggestions but don't want to write code, please
[open an issue](https://github.com/davorg/tt-mode/issues).

## License

This code is made available under the
[GPL](http://www.gnu.org/copyleft/gpl.html). Usual caveats apply.
