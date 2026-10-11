# Spécification

- [Spécification](#spécification)
  - [Fonction](#fonction)
  - [Entrée](#entrée)
  - [Sortie](#sortie)
  - [Cas particuliers](#cas-particuliers)
    - [Deux nombres égaux](#deux-nombres-égaux)
    - [Un nombre nul](#un-nombre-nul)
    - [Un nombre multiple de l'autre](#un-nombre-multiple-de-lautre)

## Fonction

Le programme calcule le plus grand commun diviseur (PGCD) de deux entiers.


## Entrée

Le programme lit deux entiers depuis l'entrée standard.

Les deux entiers sont fournis sur des lignes séparées.

Exemple :

```text
48
18
```

## Sortie

Le programme doit afficher un seul entier : le PGCD des deux entiers.

Par exemple, pour :

```text
48
18
```

la sortie attendue est :

```text
6
```


## Cas particuliers

### Deux nombres égaux

Si la valeur absolue des deux nombres d'entrée sont égaux, le résultat est sa valeur absolue.

Exemple :

```text
12
12
```

sortie :

```text
12
```

### Un nombre nul

Le PGCD de `0` et d'un entier non nul `x` est `|x|`.

Exemple :

```text
0
15
```

sortie :

```text
15
```


### Un nombre multiple de l'autre

Le PGCD de deux entiers `x` et `y` tel que `x = y * z` où `z` est un entier est `|y|`.

Exemple :

```text
20
5
```

sortie :

```text
5
```

