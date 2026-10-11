# Explication du programme

- [Explication du programme](#explication-du-programme)
  - [1. Principe général](#1-principe-général)
  - [2. Structure du programme : deux emails, deux rôles](#2-structure-du-programme--deux-emails-deux-rôles)
  - [3. Variables](#3-variables)
  - [4. Initialisation](#4-initialisation)
    - [4.1 Lecture des entrées](#41-lecture-des-entrées)
    - [4.2 La paire +1 / −1](#42-la-paire-1--1)
    - [4.3 Valeurs absolues](#43-valeurs-absolues)
    - [4.4 Appel et affichage](#44-appel-et-affichage)
  - [5. Cas de base](#5-cas-de-base)
  - [6. Cas récursif](#6-cas-récursif)
  - [7. Exemple](#7-exemple)
  - [8. Mémoire](#8-mémoire)


## 1. Principe général

Le programme calcule le PGCD de deux nombres avec l'algorithme d'Euclide :

```text
gcd(a, b) = gcd(b, a mod b)
```

tant que `b` et `a` sont différents de zéro. Les cas de base sont :

```text
gcd(a, 0) = a
gcd(0, b) = b
```

## 2. Structure du programme : deux emails, deux rôles

Un programme Regards est un email (le main) suivi d'un ou plusieurs mail : chaque message cité définit une personne (c'est-à-dire une fonction).

Eléonore écrit l'email principal : c'est le point d'entrée. Elle lit les entrées, normalise les valeurs, appelle la fonction de Mathieu et affiche le résultat.

Mathieu représente la fonction récursive qui calcule le PGCD.

Un appel à :

```text
Circling back on Mathieu's take.
```

correspond à un appel de la fonction récursive et affiche son résultat.

La valeur retournée par Mathieu est récupérée avec :

```text
result is Mathieu's take.
```

puis renvoyée avec :

```text
Net-net, result.
```

## 3. Variables

Toutes les variables sont des entiers et l'ensemble du programme partage ces variables :

- `a` : premier nombre
- `b` : deuxième nombre
- `remainder` : reste de la division entière de `a` par `b`
- `result` : valeur retournée par l'appel récursif

## 4. Initialisation

### 4.1 Lecture des entrées

Eléonore lit a et b depuis l'entrée standard :

```text
Just to level-set, we have 0 a. 
Thoughts?
Thanks in advance.
```

D'abord Eléonore déclare `a = 0`, puis `Thoughts?` lit un entier dans la dernière variable mentionnée, donc `a`. `Thanks in advance.` émet un avertissement si la lecture n'a pas donné un nombre entier.

La même chose est faite pour `b`.

La ligne `Circling back on "We need a first variable".` affichent la string "We need a first variable".

### 4.2 La paire +1 / −1

```text
Good news — we've added another a.   ->  a += 1
Quick flag: one a is now closed.     ->  a -= 1
```

Ces deux instructions s'annulent : c'est pour rester dans le ton corporate de l'email.

### 4.3 Valeurs absolues

Eléonore teste ensuite si a ou b est inférieur à 0. Si l'un des deux est un entier négatif, il est multiplié par -1 pour qu'on puisse manipuler sa valeur absolue.

```text
Just to level-set, we have 0 result.
If we're under result on b:
> Scaling b by -1.
```

### 4.4 Appel et affichage

Eléonore appelle ensuite Mathieu en affichant son net-net.

```text
Circling back on Mathieu's take. 
```

`+Leadership for visibility.` vide le buffer de sortie (flush).

## 5. Cas de base


Mathieu commence par déclarer `remainder`.

```text
Just to level-set, we have 0 remainder.
```

Mathieu teste si `b` vaut zéro :

```text
If b is at zero:
```
Dans ce cas, le PGCD est `a`.

Mathieu teste ensuite si `a` vaut zéro :

```text
If a is at zero:
```

Dans ce cas, le PGCD est `b`.

Le résultat est donc placé dans `result` :

```text
Per the attached, result is now a.
Net-net, result.
```

Le `Net-net` termine ces appel de Mathieu et retourne la valeur de `result`.

## 6. Cas récursif

Si aucun cas de base ne s'applique, le programme calcule `remainder = a mod b` :

```text
Per the attached, remainder is now what's left after splitting a across b.
```

Puis il effectue les deux mises à jour correspondant à l'algorithme d'Euclide `a, b = b, a % b` :

```text
Per the attached, a is now b.
Per the attached, b is now remainder.
```

Le programme appelle ensuite récursivement Mathieu avec ces nouvelles valeurs (les variables `a`, `b`, `remainder` sont partagées partout, l'appelant et l'appelé lisent et écrivent les mêmes variables) et le retourne à son propre appelant.

```text
Just to level-set, result is Mathieu's take.
Net-net, result.
```

Cette partie réalise :

```text
result = gcd(b, a mod b)
```

## 7. Exemple

Pour les entrées :

```text
48
18
```

les appels successifs sont :

```text
gcd(48, 18)
gcd(18, 12)
gcd(12, 6)
gcd(6, 0)
```

Le dernier appel rencontre le cas de base :

```text
gcd(6, 0) = 6
```

Le programme affiche finalement :

```text
6
```

## 8. Mémoire

Le programme n'utilise pas de mémoire sous forme de tableau ou de pile explicitement manipulée par le programme.

Les données sont stockées dans les variables `a`, `b`, `remainder` et `result`. Chaque niveau modifie `a` et `b` en place, puis délègue.

La récursion utilise implicitement le mécanisme d'appels de fonctions de l'interpréteur. La pile d'appels n'est donc pas gérée explicitement dans le programme `Regards,`.
