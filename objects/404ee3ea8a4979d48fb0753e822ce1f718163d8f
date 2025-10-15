In order to:

- tangle the `letgut.cls` and `letgut-banner.sty` files,
- build the documentations `letgut-code.pdf` and `letgut-banner-code.pdf` of the
  codes,

from the Org Mode source files `letgut.org` and `letgut-banner.org`:

- it is necessary to have a reasonably recent version of Emacs,
- it is then sufficient to run (in a directory containing the `build-letgut.el` file
  to be found in the current directory):
  - for the `letgut` class:

        emacs -Q letgut.org --batch -l build-letgut.el -f org-babel-tangle --kill
        emacs -Q letgut.org --batch -l build-letgut.el -f org-latex-export-to-pdf --kill

  - for the `letgut-banner` package:

        emacs -Q letgut-banner.org --batch -l build-letgut.el -f org-babel-tangle --kill
        emacs -Q letgut-banner.org --batch -l build-letgut.el -f org-latex-export-to-pdf --kill

This creates the files `letgut.cls`, `letgut-banner.sty`, `letgut-code.tex` and
`letgut-banner-code.tex`.

One can then build the PDF files `letgut-code.pdf` and `letgut-banner-code.pdf`
by running `latexmk` on each of the corresponding `.tex` files in a directory
containing the following files to be found in the `.../doc/lualatex/letgut`
directory: `latexmkrc`, `letgut.bib`, `letgut-code.pdf`, `letgut-code.tex`,
`letgut.pdf`, `letgut.tex`, `listings-conf.tex`, `localconf.tex`, `README.md`,
`xindex-letgut.lua`.

Likewise, the user documentation `letgut.pdf` is built by running `latexmk` on
the corresponding `.tex` file (which doesn't derive from an Org Mode file).
