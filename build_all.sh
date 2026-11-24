#!/usr/bin/env bash
# Rebuild every SOP and personal statement.
# School sources live in schools/<school>/tex/; each finished PDF is copied up
# to schools/<school>/ so that folder shows only the PDFs to upload.
# Usage (Git Bash, from the repo root):  ./build_all.sh
cd "$(dirname "$0")"

build() {  # build <dir> <file.tex>  -- prints one status line
  local dir=$1 b=${2%.tex}
  (
    cd "$dir" || exit 1
    texcount -1 -sum -merge -inc -out="$b.wc" "$b.tex" 2>/dev/null
    latexmk -pdf -interaction=nonstopmode -halt-on-error "$b.tex" >/dev/null 2>&1
    rc=$?
    pages=$(grep -o "([0-9]* pages" "$b.log" 2>/dev/null | tr -dc 0-9)
    [ "$(basename "$dir")" = tex ] && [ $rc -eq 0 ] && cp "$b.pdf" ../
    printf "%-55s %s pages=%-2s words=%s\n" "$dir/$b" "$([ $rc -eq 0 ] && echo ok || echo FAILED)" "$pages" "$(cat "$b.wc" 2>/dev/null)"
  )
}

build . Rhea_SOP.tex
build . Rhea_SOP_500.tex
build shared/ps_master Master_PS.tex
for f in schools/*/tex/*.tex; do
  build "$(dirname "$f")" "$(basename "$f")"
done
