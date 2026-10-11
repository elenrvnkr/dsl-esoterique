# CALCULATEUR DE PGCD

- [CALCULATEUR DE PGCD](#calculateur-de-pgcd)
  - [Langage choisi](#langage-choisi)
  - [Exécution](#exécution)
  - [Points laissés ouverts par la spécification](#points-laissés-ouverts-par-la-spécification)
  - [Dossier regards](#dossier-regards)


## Langage choisi

Le programme `p.rgrd` est écrit en [Regards,](https://esolangs.org/wiki/Regards%2C).

- Sa page Esolangs est : https://esolangs.org/wiki/Regards%2C. 
- L'implémentation utilisée est : https://github.com/KvashaIhor/regards
- L'interpréteur est le fichier `regards.py` dans le github ci-dessus.
- La version de Python utilisée est `Python 3.12.3`

## Exécution

Depuis le répertoire contenant l'interpréteur :

```bash
python regards/regards.py p.rgrd
```

Le programme demande deux entiers puis affiche leur plus grand commun diviseur (PGCD).

Pour lancer les tests sur le programme `p.rgrd` :

```bash
./run.sh p.rgrd
```

## Points laissés ouverts par la spécification

La spécification du langage Regards, ne fixe pas nécessairement tous les détails d'une implémentation à l'autre. Ce programme dépend donc du comportement de l'interpréteur utilisé.

Les points pertinents sont notamment :

- la représentation interne des nombres
- la taille et les limites éventuelles des valeurs numériques
- le comportement en cas de dépassement numérique
- le comportement en fin d'entrée
- les éventuelles corrections automatiques ("autocorrect") réalisées par l'interpréteur

## Dossier regards

Le dossier regards contient l'interpréteur officiel de Regards, : https://github.com/KvashaIhor/regards.