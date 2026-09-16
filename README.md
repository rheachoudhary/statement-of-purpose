# Statement of Purpose — Rhea Choudhary

LaTeX source for my Economics PhD statement of purpose.

## Files
- `main.tex` — the statement of purpose.
- `bib.bib` — references. Academic works are complete; government / grey-literature
  entries are marked `TODO` and need verifying before submission.

## Building
```bash
pdflatex main
bibtex main
pdflatex main
pdflatex main
```
(or `latexmk -pdf main.tex`)

## Format
Uses run-in bold section headings, indented justified paragraphs, and inline
author-year citations. The target school appears in one place — the `\school`
macro at the top of `main.tex` — and is used in both the header and the conclusion.
