#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 programme.rgrd"
    exit 1
fi

PROGRAM="$1"

if [ ! -f "$PROGRAM" ]; then
    echo "Erreur : programme introuvable : $PROGRAM"
    exit 1
fi

passed=0
total=13

for i in $(seq -w 1 13); do
    # Récupérer les fichiers de test
    IN="tests/${i}.in"
    OUT="tests/${i}.out"

    if [ ! -f "$IN" ] || [ ! -f "$OUT" ]; then
        echo "$i - ERREUR : fichier de test manquant"
        continue
    fi

    # Lire les deux entiers du fichier .in
    read -r a < "$IN"
    read -r b < <(sed -n '2p' "$IN")

    # Exécuter le programme et récupérer sa sortie
    result=$(printf '%s\n%s\n' "$a" "$b" | python regards/regards.py "$PROGRAM")

    # Récupérer le résultat du programme (dernier entier présent)
    actual=$(printf '%s\n' "$result" | grep -Eo -- '-?[0-9]+' | tail -n 1)

    expected=$(cat "$OUT" | tr -d '[:space:]')

    # Comparer le résultat du fichier .out au résultat du programme
    if [ "$actual" = "$expected" ]; then
        echo "$i - OK   : $a, $b -> $actual"
        passed=$((passed + 1))
    else
        echo "$i - FAIL : $a, $b -> attendu $expected, obtenu $actual"
    fi
done

echo
echo "$passed/$total tests réussis"