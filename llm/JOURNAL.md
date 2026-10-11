# Journal de confrontation au LLM

Date de la confrontation : 07/10/2026

- [Journal de confrontation au LLM](#journal-de-confrontation-au-llm)
  - [Prompt commun](#prompt-commun)
  - [Outils et modèles utilisés](#outils-et-modèles-utilisés)
  - [Propositions obtenues](#propositions-obtenues)
    - [p1 : ChatGPT](#p1--chatgpt)
    - [p2 : DeepSeek V3](#p2--deepseek-v3)
    - [p3 : Mistral AI](#p3--mistral-ai)
    - [p4 : Claude Sonnet 5.5](#p4--claude-sonnet-55)
    - [p5 : Copilot](#p5--copilot)
    - [p6 : Gemini](#p6--gemini)
  - [Tests](#tests)
    - [Résultats](#résultats)
    - [Détail des résultats](#détail-des-résultats)
      - [p1 : ChatGPT](#p1--chatgpt-1)
      - [p2 : DeepSeek V3](#p2--deepseek-v3-1)
      - [p3 : Mistral AI](#p3--mistral-ai-1)
      - [p4 : Claude Sonnet 5.5](#p4--claude-sonnet-55-1)
      - [p5 : Copilot](#p5--copilot-1)
      - [p6 : Gemini 3.6 Flash](#p6--gemini-36-flash)
    - [Synthèse](#synthèse)


## Prompt commun

Le prompt suivant a été utilisé comme point de départ pour les différentes confrontations :

```text
# Spécification

## Fonction

Le programme calcule le plus grand commun diviseur (PGCD) de deux entiers.


## Entrée

Le programme lit deux entiers depuis l'entrée standard.

Les deux entiers sont fournis sur des lignes séparées.

Exemple :


48
18

## Sortie

Le programme doit afficher un seul entier : le PGCD des deux entiers.

Par exemple, pour :


48
18


la sortie attendue est :


6



## Cas particuliers

### Deux nombres égaux

Si la valeur absolue des deux nombres d'entrée sont égaux, le résultat est sa valeur absolue.

Exemple :


12
12


sortie :


12


### Un nombre nul

Le PGCD de `0` et d'un entier non nul `x` est `|x|`.

Exemple :


0
15


sortie :


15



### Un nombre multiple de l'autre

Le PGCD de deux entiers `x` et `y` tel que `x = y * z` où `z` est un entier est `|y|`.

Exemple :


20
5


sortie :


5



fais ce code d'après ce spec en utilisant le langage Regards, https://esolangs.org/wiki/Regards,

```

Aucune modification du prompt n'a été effectuée entre les modèles. Chaque modèle n'a eu qu'un essai.

## Outils et modèles utilisés

| Proposition | Outil  | Modèle | Mode |
| - | -- | - | -|
| p1| ChatGPT | modèle utilisé par ChatGPT| Free |
| p2| DeepSeek| DeepSeek V3| - |
| p3 | Mistral AI | modèle utilisé par Mistral AI  | Work, rapide |
| p4 | Claude| Claude Sonnet 5.5 | -|
| p5| Copilot| modèle de base de Copilot Chat | - |
| p6| Gemini| Gemini 3.6 Flash | - |

Date d'utilisation : 07/10/2026.

## Propositions obtenues


### p1 : ChatGPT

ChatGPT propose l'algorithme d'Euclide avec calcul explicite de la valeur absolue des deux entrées.

La proposition est telle quelle dans `llm/p1.ext`. La réponse complète est celle ci-dessous.

```text
Oui. J’ai vérifié la spécification de **Regards** : l’entrée se fait avec `Thoughts?`, les conditions utilisent `If ...:`, les boucles `Per my last email, while ...:`, et le modulo est disponible via `what's left after splitting ... across ...`. ([Esolangs][1])

Voici un programme **Regards** qui gère également les nombres négatifs et les cas `0`.

Subject: PGCD — calcul du résultat

Hi team,

Just to level-set, we have 0 a.
Thoughts?

Just to level-set, we have 0 b.
Thoughts?

Just to level-set, we have 0 zero.
Just to level-set, we have 0 remainder.

If we're under 0 on a:
> Backing a out of zero.
> Per the attached, a is zero.

If we're under 0 on b:
> Backing b out of zero.
> Per the attached, b is zero.

Per my last email, while we still have b:
> Per the attached, remainder is what's left after splitting a across b.
> Per the attached, a is b.
> Per the attached, b is remainder.

Circling back on a.

Best,
Ihor

### Comment ça fonctionne

Pour `48` et `18` :

a = 48
b = 18

La boucle d'Euclide fait :

48 % 18 = 12
18 % 12 = 6
12 % 6  = 0

Donc :

a = 6
b = 0

et le programme affiche :

6

Le bloc :

If we're under 0 on a:
> Backing a out of zero.
> Per the attached, a is zero.

sert à calculer `|a|`. Comme Regards ne possède pas directement une instruction `abs`, on part de `zero = 0`, puis `Backing a out of zero.` effectue `zero = zero - a`. On remet ensuite cette valeur dans `a`. Les opérations d'affectation et de soustraction utilisées ici sont bien prévues par la spécification. ([Esolangs][1])

Ainsi, par exemple :

-48
18

devient :

48
18

avant d'appliquer l'algorithme d'Euclide.

Le cas :

0
15

fonctionne aussi : `a = 0`, `b = 15`, puis la boucle donne `a = 15`, `b = 0`, donc sortie `15`.

**Petite particularité :** la condition `while` est `while we still have b`, c'est-à-dire `b > 0`. C'est exactement adapté puisque les deux valeurs ont été rendues positives avant la boucle. ([Esolangs][1])

[1]: https://esolangs.org/wiki/Regards "Regards, - Esolang"

```

### p2 : DeepSeek V3

DeepSeek propose une version de l'algorithme d'Euclide basée sur des soustractions répétées.

La proposition utilise deux boucles permettant de soustraire alternativement le plus petit nombre au plus grand.

La proposition est dans `llm/p2.ext`. La réponse complète est celle ci-dessous.

```text
# Programme Regards, pour le calcul du PGCD

Voici un programme écrit dans le langage **Regards,** qui lit deux entiers sur l'entrée standard (chacun sur une ligne séparée) et affiche leur PGCD. Il utilise l'algorithme d'Euclide par soustractions répétées, qui gère naturellement les cas particuliers (nombres égaux, zéro, multiples) grâce à la valeur absolue.

Subject: PGCD — quick calc, need your eyes

Hi team,

FYI, on lit deux entiers sur des lignes séparées, puis on boucle tant que les deux ne sont pas égaux.
FYI, à chaque tour on soustrait le plus petit du plus grand.

Just to level-set, we have 0 first.
Just to level-set, we have 0 second.

Thoughts?
Per the attached, first is now it.
Thoughts?
Per the attached, second is now it.

Per my last email, while we're over 0 on second:
> If we're over 0 on first:
> > If we're over first on second:
> > > Backing first out of second.
> > That said, if we're over second on first:
> > > Backing second out of first.
> > That said:
> > > first is off the table.
> > > second is off the table.
> That said:
> > first is off the table.

Per my last email, while we're over 0 on first:
> If we're over 0 on second:
> > If we're over second on first:
> > > Backing second out of first.
> > That said, if we're over first on second:
> > > Backing first out of second.
> > That said:
> > > first is off the table.
> > > second is off the table.
> That said:
> > second is off the table.

If we're over 0 on first:
> Circling back on first.
That said:
> Circling back on second.

Best,
Ihor

## Explication du fonctionnement

Le programme repose sur la propriété `PGCD(a, b) = PGCD(|a−b|, min(a,b))`, répétée jusqu'à obtenir deux valeurs égales (ou l'une nulle).

1. **Lecture** : `Thoughts?` lit un entier dans la dernière variable mentionnée. On lit `first` puis `second`.

2. **Boucles de soustraction** : deux boucles `while` successives retirent le plus petit du plus grand. Comme les entiers de Regards, n'ont pas de limite de taille et que la soustraction fonctionne sur les valeurs négatives, le test `we're over 0 on X` (c.-à-d. `X > 0`) combiné à la soustraction symétrique aboutit à `first == second`, valeur absolue du PGCD.

3. **Cas particuliers couverts** :
   - **Nombres égaux** (`12`, `12`) : la première boucle voit `first == second`, ne fait rien ; la seconde non plus ; on affiche `12`.
   - **Zéro** (`0`, `15`) : `second > 0`, `first == 0` donc `first is off the table.` ; la seconde boucle s'arrête immédiatement ; on affiche `second = 15`.
   - **Multiple** (`20`, `5`) : les soustractions réduisent `first` de `20` à `5`, puis égalité, on affiche `5`.

4. **Sortie** : un seul `Circling back on …` imprime la valeur entière suivie d'un retour à la ligne, conformément à la spécification.

> Remarque : la variable `it` désigne la dernière variable mentionnée, ce qui permet la réaffectation `first is now it.` juste après `Thoughts?`. C'est le mécanisme standard de Regards, pour récupérer le résultat d'une lecture.
```

### p3 : Mistral AI

Mistral propose également l'algorithme d'Euclide, en calculant avant les valeurs absolues des deux entrées.

La proposition est dans `llm/p3.ext`. La réponse complète est celle ci-dessous.

```text
Voici le programme en **Regards,** (fichier `.rgrd`). Il lit deux entiers (un par ligne, négatifs acceptés), les passe en valeur absolue, puis applique l'algorithme d'Euclide :

Subject: PGCD — quick sync

Hi team,

FYI this computes the greatest common divisor of two integers.

Just to level-set, first is 0.
Thoughts?
Just to level-set, second is 0.
Thoughts?

FYI take absolute values before anything else.
Just to level-set, firstneg is 0.
Per my last email, while we still have first:
> Quick flag: one first is now closed.
> Good news — we've added another firstneg.
Per the attached, first is now firstneg.

Just to level-set, secondneg is 0.
Per my last email, while we still have second:
> Quick flag: one second is now closed.
> Good news — we've added another secondneg.
Per the attached, second is now secondneg.

FYI Euclid, per my last email.
Just to level-set, remainder is 0.
Per my last email, while we still have second:
> Per the attached, remainder is now what's left after splitting first across second.
> Per the attached, first is now second.
> Per the attached, second is now remainder.

Circling back on first.

Best,
Ihor

### Comment ça marche

1. **Lecture** : `Thoughts?` lit un entier dans la dernière variable mentionnée (`first`, puis `second`).
2. **Valeur absolue** : la boucle décrémente le nombre et incrémente un compteur séparé (`firstneg` / `secondneg`), puis on recopie ce compteur — c'est un `0 - x` écrit à la main.
3. **Euclide** : tant que `second > 0`, on calcule `first % second` avec `what's left after splitting first across second`, puis on fait tourner les variables.
4. **Sortie** : `Circling back on first.` affiche le PGCD.

Les cas particuliers sont couverts :
- `0 15` → la boucle Euclide ne tourne pas, on affiche `|15|` → `15`
- `12 12` → un seul tour de boucle, reste 0 → `12`
- `20 5` → `20 % 5 = 0` → `5`

(Source du langage : [Esolang wiki](https://esolangs.org/wiki/Regards))
```

### p4 : Claude Sonnet 5.5

Claude propose l'algorithme d'Euclide classique avec calcul du modulo.

La proposition traite les valeurs négatives avant la boucle.

Le modèle précise qu'il n'a pas exécuté le programme.

La proposition est dans `llm/p4.ext`. La réponse complète est celle ci-dessous.

```text
Je vérifie d'abord la définition du langage Regards.Voici le programme en **Regards,** (`pgcd.rgrd`), qui utilise l'algorithme d'Euclide.

Subject: PGCD - Re: Re: quick sync on the numbers

Hi team,

FYI, on lit deux entiers, un par ligne.
Just to level-set, dividend is 0.
Thoughts?
Just to level-set, divisor is 0.
Thoughts?
Just to level-set, remainder is 0.

FYI, on travaille sur les valeurs absolues.
If we're under 0 on dividend:
> Scaling dividend by -1.
If we're under 0 on divisor:
> Scaling divisor by -1.

FYI, algorithme d'Euclide.
Per my last email, while we still have divisor:
> Per the attached, remainder is now what's left after splitting dividend across divisor.
> Per the attached, dividend is now divisor.
> Per the attached, divisor is now remainder.

Circling back on dividend.

Best,
Ihor

**Fonctionnement**

1. `Thoughts?` lit un entier dans la dernière variable mentionnée. Chaque lecture suit donc directement la déclaration de sa variable.
2. Les deux `If` remplacent les nombres négatifs par leur valeur absolue (multiplication par `-1`).
3. La boucle `while` répète `(a, b) ← (b, a mod b)` tant que `divisor > 0`. À la fin, `dividend` contient le PGCD.
4. `Circling back on dividend.` affiche le résultat suivi d'un retour à la ligne, puis `Best,` termine le programme avec le code 0.

**Cas de la spécification**

| Entrée | Déroulement | Sortie |
|---|---|---|
| `48`, `18` | (48,18) → (18,12) → (12,6) → (6,0) | `6` |
| `12`, `12` | (12,12) → (12,0) | `12` |
| `0`, `15` | (0,15) → (15,0) | `15` |
| `20`, `5` | (20,5) → (5,0) | `5` |

Je n'ai pas pu exécuter le programme ici : je l'ai écrit d'après la documentation du langage. Vous pouvez le tester avec l'interpréteur de référence :

pip install regards
echo -e "48\n18" | regards pgcd.rgrd

Si une ligne était rejetée, dites-moi le message d'erreur et j'ajusterai.
```

### p5 : Copilot

Copilot propose également l'algorithme d'Euclide avec modulo.

La proposition est dans `llm/p5.ext`. La réponse complète est celle ci-dessous.

```text
Voici une solution en Regards utilisant l'algorithme d'Euclide :

Subject: PGCD

Hi team,

Just to level-set, we have 0 a.
Please advise.

Just to level-set, we have 0 b.
Please advise.

Per my last email, while we still have b:
> Just to level-set, temp is what's left after splitting a across b.
> Per the attached, a is now b.
> Per the attached, b is now temp.

Circling back on a.

Best,
Copilot


Cette implémentation suit l'algorithme :

Lire a
Lire b
Tant que b != 0
temp = a % b
a = b
b = temp
Afficher a

Le résultat est le PGCD des deux entiers. Pour les cas particuliers du sujet (0, nombres égaux, multiples), l'algorithme d'Euclide les gère naturellement.
```

### p6 : Gemini

Gemini propose une solution qui n'utilise pas la syntaxe de Regards. La réponse semble confondre Regards avec un langage utilisant des instructions telles que `in`, `out`, `dup`, `swap`, `abs` et `jmp`.

La proposition est dans `llm/p6.ext`. La réponse complète est celle ci-dessous.

```text
Voici l'implémentation de l'algorithme d'Euclide (PGCD) selon vos spécifications dans le langage ésotérique **Regards**.

### Principes du langage **Regards**

**Regards** est un esolang orienté pile basé sur l'évaluation de paires de formules logiques et la gestion des expressions. Il repose sur :

* `in` : lecture d'un entier sur l'entrée standard et empilement.
* `out` : dépilement et affichage de l'entier sur la sortie standard.
* Operateurs arithmétiques et logiques classiques : `%` (modulo), `dup` (duplication), `swap` (échange), `abs` (valeur absolue).
* La structure de boucle/condition basée sur les gardes et les registres mémoire.

---

### Code source (`pgcd.regards`)

# Lecture des deux entrées
in
abs
in
abs

# Boucle d'Euclide : tant que B != 0, faire (A, B) = (B, A % B)
:loop
dup
0 ==
? :end :continue

:continue
swap
over
%
:loop jmp

# Finalisation : affichage du résultat
:end
drop
out

---

### Fonctionnement détaillé du programme

1. **Prise en compte des valeurs absolues et cas nuls** :
Le programme lit les deux entrées (`in`) et applique immédiatement `abs` pour garantir le traitement des nombres négatifs.
2. **Gestion de la boucle** :
* `dup` duplique le deuxième nombre $B$.
* Si $B == 0$, le saut conditionnel `? :end :continue` redirige vers la fin.
* Si $B \neq 0$, `swap` et `over` préparent le calcul du modulo `$A \pmod B$`.


3. **Cas particuliers spécifiés** :
* **Nombres égaux** ($A = B$) : Le modulo donne $0$ dès le premier passage, la boucle s'arrête et renvoie $\vert{}A\vert{}$.
* **Un nombre nul** ($A = 0$ ou $B = 0$) : Si $B = 0$, la boucle s'arrête tout de suite et renvoie $\vert{}A\vert{}$.
* **Multiple** ($A = B \cdot Z$) : Le premier modulo donne $0$, le programme s'arrête et renvoie $\vert{}B\vert{}$.
```

## Tests

Toutes les propositions ont été exécutées avec le même interpréteur que mon programme, avec`run.sh`.

Aucun des résultats de ces tests n'a été communiqué aux LLM avant la génération de leurs propositions.

Les 13 cas de test utilisés sont les suivants :

| Test | Entrée | Résultat attendu |
| - | -| -: |
| 01 | `10`, `0`  | `10` |
| 02 | `0`, `10`  | `10` |
| 03 | `0`, `0` | `0` |
| 04 | `-10`, `0` | `10` |
| 05 | `0`, `-10` | `10` |
| 06 | `5`, `5` | `5` |
| 07 | `-5`, `-5` | `5` |
| 08 | `7`, `4` | `1` |
| 09 | `-4`, `7` | `1` |
| 10 | `-4`, `-7`  | `1` |
| 11 | `20`, `5` | `5` |
| 12 | `-5`, `20` | `5` |
| 13 | `-5`, `-20` | `5` |

### Résultats

| Proposition            | Réussis | Échoués |     Score |
| ---------------------- | ------: | ------: | --------: |
| p1 : ChatGPT           |       0 |      13 |  **0/13** |
| p2 : DeepSeek V3       |       1 |      12 |  **1/13** |
| p3 : Mistral AI        |       6 |       7 |  **6/13** |
| p4 : Claude Sonnet 5.5 |      13 |       0 | **13/13** |
| p5 : Copilot           |       8 |       5 |  **8/13** |
| p6 : Gemini 3.6 Flash  |       0 |      13 |  **0/13** |

### Détail des résultats

#### p1 : ChatGPT

**Résultat : 0/13 tests réussis.**

La proposition échoue dès l'exécution avec l'erreur :

```text
error: `Per the attached, a is zero.` isn't something I can action (line 16)
```

La même erreur apparaît sur les 13 entrées. Le programme ne produit donc aucun résultat.

Le problème est une instruction générée par le LLM qui n'est pas reconnue comme une action valide par l'interpréteur de Regards. En effet, la grammaire attend la formulation suivante :

```text
Per the attached, a is now zero.
```

#### p2 : DeepSeek V3

**Résultat : 1/13 test réussi.**

Le seul test réussi est le cas `0, 0`.

| Test | Résultat |
| ---- | -------- |
| 01   | FAIL     |
| 02   | FAIL     |
| 03   | OK   |
| 04   | FAIL     |
| 05   | FAIL     |
| 06   | FAIL     |
| 07   | FAIL     |
| 08   | FAIL     |
| 09   | FAIL     |
| 10   | FAIL     |
| 11   | FAIL     |
| 12   | FAIL     |
| 13   | FAIL     |

La proposition ne récupère pas correctement les valeurs fournies sur `stdin` à cause d'une mauvaise compréhension de la syntaxe de Regards. Elle ne gère pas non plus correctement les cas où l’une des valeurs est nulle et conserve des valeurs négatives dans plusieurs situations.

#### p3 : Mistral AI

**Résultat : 6/13 tests réussis.**

Les tests réussis sont :

- `10, 0` → `10`
- `0, 10` → `10`
- `0, 0` → `0`
- `5, 5` → `5`
- `7, 4` → `1`
- `20, 5` → `5`

Les sept autres tests échouent lorsque des nombres négatifs sont présents.

| Test | Résultat |
| ---- | -------- |
| 01   | OK  |
| 02   | OK  |
| 03   | OK   |
| 04   | FAIL     |
| 05   | FAIL     |
| 06   | OK   |
| 07   | FAIL     |
| 08   | OK  |
| 09   | FAIL     |
| 10   | FAIL     |
| 11   | OK |
| 12   | FAIL     |
| 13   | FAIL     |

La structure générale de l'algorithme d'Euclide fonctionne donc sur les valeurs positives, mais le calcul de la valeur absolue proposé par le LLM n'est pas correct à cause d'une mauvaise compréhension de la syntaxe de Regards.

#### p4 : Claude Sonnet 5.5

**Résultat : 13/13 tests réussis.**

Tous les tests passent, y compris les cas avec des nombres négatifs :

| Test | Résultat |
| ---- | -------- |
| 01   | OK   |
| 02   | OK   |
| 03   | OK   |
| 04   | OK   |
| 05   | OK   |
| 06   | OK   |
| 07   | OK   |
| 08   | OK   |
| 09   | OK   |
| 10   | OK   |
| 11   | OK   |
| 12   | OK   |
| 13   | OK   |

Il s'agit de la seule proposition obtenant un résultat parfait sur les 13 tests.

#### p5 : Copilot

**Résultat : 8/13 tests réussis.**

Les tests positifs et certains cas mixtes fonctionnent correctement mais les cas comportant deux valeurs négatives ou une valeur négative et une nulle échouent. Copilot ne normalise pas les valeurs négatives.

| Test | Résultat |
| ---- | -------- |
| 01   | OK   |
| 02   | OK   |
| 03   | OK   |
| 04   | FAIL     |
| 05   | FAIL     |
| 06   | OK   |
| 07   | FAIL     |
| 08   | OK   |
| 09   | OK   |
| 10   | FAIL     |
| 11   | OK   |
| 12   | OK   |
| 13   | FAIL     |

#### p6 : Gemini 3.6 Flash

**Résultat : 0/13 tests réussis.**

La proposition échoue dès la première ligne avec :

```text
error: no greeting. Who is this addressed to? (line 1)
```

Cette erreur apparaît sur tous les tests.

La proposition de Gemini n'utilise pas la syntaxe de Regards attendue par l'interpréteur. 

### Synthèse

Les résultats montrent que les erreurs ne concernent pas uniquement l'algorithme du PGCD. Plusieurs propositions utilisent correctement l'algorithme d'Euclide mais produisent un programme qui ne respecte pas correctement la syntaxe de Regards.

Les nombres négatifs constituent aussi un point discriminant : Mistral et Copilot fonctionnent sur une partie des cas positifs mais échouent sur plusieurs cas nécessitant une valeur absolue correcte. Claude est le seul modèle dont la proposition passe l'ensemble des tests.
