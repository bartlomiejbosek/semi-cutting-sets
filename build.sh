#!/bin/bash

RELPATH="$(dirname "$0")"
STARTPATH="$(pwd)"
OWNPATH="$(cd "$RELPATH"; pwd)"

cd ${OWNPATH}

# latexpand "${OWNPATH}/main.tex" > "${OWNPATH}/main-all.tex"

# Przechodzimy przez wszystkie pliki z rozszerzeniem .tex w bieżącym katalogu
for plik in *.tex; do
    # Sprawdzamy, czy plik istnieje (zabezpieczenie w przypadku braku plików .tex)
    if [ -e "$plik" ]; then
        # Usuwamy rozszerzenie .tex z nazwy i dodajemy .txt
        nowa_nazwa="${plik%.tex}.txt"
        
        # Kopiujemy oryginalny plik do nowego
        cp "$plik" "$nowa_nazwa"
        
        # Opcjonalnie wyświetlamy informację o postępie
        echo "Skopiowano: $plik -> $nowa_nazwa"
    fi
done

echo "Zakończono kopiowanie!"

mkdir -p "${OWNPATH}/input"

cp -v "${OWNPATH}/main-pl.txt" "${OWNPATH}/input/main-pl.txt"
# cp -v "${OWNPATH}/dvorak.txt" "${OWNPATH}/input/dvorak.txt"
# cp -v "${OWNPATH}/lemma-restore-by-sampling-explicite.txt" "${OWNPATH}/input/lemma-restore-by-sampling-explicite.txt"


pdflatex main-pl.tex
pdflatex main-pl.tex

cp -v "${OWNPATH}/main-pl.pdf" "${OWNPATH}/input/main-pl.pdf"

rm *.aux *.out *.toc
