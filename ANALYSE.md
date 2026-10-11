# Analyse

- [Analyse](#analyse)
  - [1. Objectif de l'analyse](#1-objectif-de-lanalyse)
  - [2. Sémantique](#2-sémantique)
    - [2.1 Résultats expérimentaux](#21-résultats-expérimentaux)
    - [2.2 Analyse de ma proposition](#22-analyse-de-ma-proposition)
  - [3. Analyse sémantique des propositions du LLM](#3-analyse-sémantique-des-propositions-du-llm)
    - [3.1 ChatGPT : p1](#31-chatgpt--p1)
    - [3.2 DeepSeek V3 : p2](#32-deepseek-v3--p2)
    - [3.3 Mistral AI : p3](#33-mistral-ai--p3)
    - [3.4 Claude Sonnet 5.5 : p4](#34-claude-sonnet-55--p4)
    - [3.5 Copilot : p5](#35-copilot--p5)
    - [3.6 Gemini : p6](#36-gemini--p6)
  - [4. Comparaison syntaxique](#4-comparaison-syntaxique)
    - [4.1 Ma proposition](#41-ma-proposition)
    - [4.2 Structure des propositions LLM](#42-structure-des-propositions-llm)
  - [5. Distance syntaxique](#5-distance-syntaxique)
  - [6. Qu'est-ce qui éloigne ma proposition de ce qu'un LLM écrit spontanément ?](#6-quest-ce-qui-éloigne-ma-proposition-de-ce-quun-llm-écrit-spontanément-)
  - [7. Quelle proposition est préférable ?](#7-quelle-proposition-est-préférable-)
  - [8. Ce que l'expérience montre](#8-ce-que-lexpérience-montre)


## 1. Objectif de l'analyse

L'objectif de cette confrontation n'est pas uniquement de déterminer si un LLM est capable de retrouver l'algorithme du PGCD. Il s'agit surtout d'étudier la distance entre un programme `p` écrit par un humain (moi) et les programmes `p'` générés par des LLM à partir de la spécification.

Deux aspects sont donc étudiés séparément :

- la sémantique : est-ce que `p'` calcule le même résultat que `p` ?
- la syntaxe : est-ce que `p'` ressemble à `p` dans sa structure, son organisation et son style ?

## 2. Sémantique

### 2.1 Résultats expérimentaux

Les six propositions générées par les LLM ont été exécutées avec le même interpréteur et les mêmes 13 cas de test.

| Proposition            |  Résultat | Taux de réussite |
| ---------------------- | --------: | ---------------: |
| p1 : ChatGPT           |      0/13 |              0 % |
| p2 : DeepSeek V3       |      1/13 |            7,7 % |
| p3 : Mistral AI        |      6/13 |           46,2 % |
| p4 : Claude Sonnet 5.5 |     13/13 |            100 % |
| p5 : Copilot           |      8/13 |           61,5 % |
| p6 : Gemini 3.6 Flash  |      0/13 |              0 % |
| p : ma proposition | 13/13 |        100 % |

Ma proposition passe tous les tests utilisés par `run.sh`.

Les 13 tests couvrent notamment :

- les deux entrées nulles
- une seule entrée nulle
- deux nombres égaux
- des nombres négatifs
- deux nombres négatifs
- des nombres positifs non multiples
- des nombres multiples.

Cela permet de tester à la fois le calcul du PGCD et la gestion de la valeur absolue.

### 2.2 Analyse de ma proposition

Le calcul repose sur l'algorithme d'Euclide.

Après avoir transformé les deux entrées en valeurs positives, le programme utilise ces règles ci-dessous dans une fonction récursive :

```text
si b = 0 : résultat = a
si a = 0 : résultat = b
sinon :
    reste = a % b
    a = b
    b = reste
    recommencer
```

À chaque appel, lorsque `b` est non nul, le nouveau deuxième argument est un reste strictement inférieur à `b` pour des valeurs positives. La suite finit donc par atteindre `0` et le seul argument non nul contient alors le PGCD.

La gestion des nombres négatifs est réalisée avant l'appel récursif. Le programme transforme donc les valeurs négatives en valeurs absolues. Le résultat obtenu correspond ainsi à la définition du PGCD donnée dans `SPEC.md`.

## 3. Analyse sémantique des propositions du LLM

### 3.1 ChatGPT : p1

La proposition de ChatGPT obtient 0/13.

L'erreur apparaît avant même que l'algorithme du PGCD puisse être utilisé :

```text
error: `Per the attached, a is zero.` isn't something I can action (line 16)
```

Le LLM a donc écrit une action invalide pour Regards,. La syntaxe correct est :

```text
Per the attached, a is now zero.
```

Il y a une différence entre une réponse qui semble plausible à la lecture et un programme réellement exécutable. L'explication fournie par le LLM affirme notamment que cette instruction permet de recopier `zero` dans `a`, mais l'interpréteur montre que cette interprétation est incorrecte.

Le problème est donc principalement syntaxique au niveau du langage, plutôt qu'une erreur dans l'algorithme du PGCD lui-même.

Cependant, même en corrigeant cette erreur de syntaxe, la gestion des valeurs négatives proposée par ChatGPT reste incorrecte. L'algorithme utilise :

```text
Just to level-set, we have 0 zero.

If we're under 0 on a:
> Backing a out of zero.
> Per the attached, a is zero.

If we're under 0 on b:
> Backing b out of zero.
> Per the attached, b is zero.
```

Le problème est que la variable `zero` est utilisée comme accumulateur pour les deux valeurs. Si `a` et `b` sont négatifs, le premier `if` modifie `zero` pour obtenir `-a`, puis le second `if` continue à utiliser cette même valeur au lieu de repartir de zéro.

Ainsi, `a` devient bien `-a`, mais `b` devient **`-a-b`** au lieu de `-b`.

Il aurait donc fallu réinitialiser `zero` entre les deux blocs `if`.

### 3.2 DeepSeek V3 : p2

DeepSeek obtient 1/13.

La proposition utilise une autre version de l'algorithme du PGCD : des soustractions répétées plutôt que le modulo.

Sur le principe, cette méthode est correcte : soustraire le plus petit nombre au plus grand conserve le PGCD.

Cependant, l'implémentation générée ne gère pas correctement les valeurs lues en entrée et ne préserve donc pas les variables nécessaires à l'exécution de l'algorithme. Les résultats montrent les erreurs suivantes :

```text
10, 0   -> 0
0, 10   -> 0
5, 5    -> 0
7, 4    -> 0
20, 5   -> 0
```

Un problème vient de la mauvaise compréhension de la lecture de l'entrée standard dans Regards. DeepSeek utilise le code suivant :

```text
Just to level-set, we have 0 first.
Just to level-set, we have 0 second.

Thoughts?
Per the attached, first is now it.
Thoughts?
Per the attached, second is now it.
```
Or, dans Regards, `Thoughts?` lit un entier dans la dernière variable mentionnée. Ainsi, après `Per the attached, first is now it.`, la variable `first` devient la dernière variable mentionnée. Le second `Thoughts?` écrase donc `first` au lieu de lire une nouvelle valeur dans `second`.

La gestion des valeurs négatives est également incorrecte. Les entrées ne sont pas normalisées en valeurs absolues avant l'exécution de l'algorithme. Ainsi, des résultats négatifs sont parfois directement conservés :

```text
0, -10    -> -10
-5, -5    -> -5
-4, -7    -> -7
```

Le LLM a donc bien identifié une propriété mathématique du PGCD mais sa traduction dans Regards est incorrecte. 

L'algorithme comporte également des mises à zéro injustifiées. Par exemple :

```text
> Per my last email, while we're over 0 on second:
>
> > If we're over 0 on first:
> >
> > > ...
> > > That said:
> > > first is off the table.
> > > second is off the table.
```

Cette logique est problématique. Lorsque les deux valeurs sont égales, comme pour (5, 5), aucune mise à zéro ne devrait être effectuée : la valeur commune 5 est directement le PGCD.

### 3.3 Mistral AI : p3

Mistral obtient 6/13.

La structure principale du programme repose sur l'algorithme d'Euclide :

```text
remainder = a % b
a = b
b = remainder
```

Le programme fonctionne correctement pour les cas où les deux valeurs sont positives.

En revanche, la gestion des nombres négatifs est incorrecte. Le programme tente de calculer la valeur absolue des deux entrées, mais cette transformation ne fonctionne pas. On obtient notamment les résultats suivants :

```text
-4, 7  -> 7
-5, 20 -> 20
-5, -20 -> 0
```

Pour gérer les nombres négatifs, Mistral utilise le code suivant :

```text
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
```

Cependant, la condition `Per my last email, while we still have first:` correspond à `while first > 0` et non à `while first != 0`. Ainsi, lorsque `first` est négatif, la condition est fausse et la boucle n'est jamais exécutée. La valeur négative ne peut donc pas être transformée en sa valeur positive. Le même problème se produit avec `second`.

La difficulté réside ici moins dans l'algorithme du PGCD que dans l'implémentation de l'opération `abs` dans Regards, ainsi que dans la compréhension de sa syntaxe.

### 3.4 Claude Sonnet 5.5 : p4

Claude obtient 13/13, soit le même résultat que ma proposition.

La solution utilise également l'algorithme d'Euclide avec modulo et traite les nombres négatifs avant la boucle. L'algorithme utilisé est similaire au mien donc `p4` devrait calculer la même chose que `p`.

Les tests montrent qu'elle fonctionne pour :

- les valeurs nulles
- les valeurs positives
- les valeurs négatives
- les nombres égaux
- les multiples
- les cas généraux.

Cela ne signifie toutefois pas que sa proposition est équivalente à la mienne : elle utilise une organisation et un style différents.


### 3.5 Copilot : p5

Copilot obtient 8/13.

La proposition utilise également l'algorithme d'Euclide avec modulo.

Elle fonctionne sur les cas positifs et sur quelques cas contenant un seul nombre négatif.

Cependant, elle ne calcule pas la valeur absolue des deux entrées. Les tests suivants échouent notamment :

```text
-10, 0
-5, -5
-4, -7
-5, -20
```

L'algorithme général est donc correct mais sa traduction ne respecte pas la spécification.


### 3.6 Gemini : p6

Gemini obtient 0/13.

La proposition est très différente des autres et utilise un langage qui ne correspond pas à Regards.

Elle propose notamment des instructions telles que :

```text
in
out
dup
swap
over
jmp
```

L'interpréteur rejette immédiatement le programme :

```text
error: no greeting. Who is this addressed to? (line 1)
```

Cette proposition ne parvient donc pas à respecter la syntaxe fondamentale de Regards.

## 4. Comparaison syntaxique

### 4.1 Ma proposition

Ma proposition est assez différente des programmes produits par les LLM.

Elle utilise notamment :

- plusieurs messages
- des phrases servant à introduire les différentes étapes du calcul
- un appel récursif.

Le cœur de mon programme est organisé autour de la récursion :

```text
si b = 0 :
    résultat = a

si a = 0 :
    résultat = b

sinon :
    reste = a % b
    a = b
    b = reste
    appel récursif
```

Cette organisation est différente de la plupart des propositions LLM, qui utilisent plutôt une boucle `while`.


### 4.2 Structure des propositions LLM

La plupart des LLM convergent vers cette structure :

```text
lecture de a
lecture de b
traitement des nombres négatifs
tant que b est non nul :
    calcul du reste
    échange de a et b
affichage de a
```

ChatGPT, Mistral, Claude et Copilot utilisent tous une variante de l'algorithme d'Euclide par modulo.

DeepSeek choisit les soustractions répétées.

Gemini, en revanche, s'écarte même de la syntaxe de Regards.

Les LLM convergent tous vers une représentation itérative assez standard du programme, alors que ma proposition utilise une organisation récursive.


## 5. Distance syntaxique

Pour comparer objectivement les programmes, j'ai calculé une distance de Levenshtein sur les instructions calculée après normalisation des programmes :
 
1. les lignes vides sont supprimées
2. les commentaires (`FYI`) sont supprimés
3. les éléments du protocole d'email qui n'ont aucun effet sur le calcul sont supprimés (`Subject`, salutation, formule de politesse, signature, `P.S.`)
4. les `>` sont retirés, mais leur nombre est conservé comme niveau d'imbrication du bloc
5. chaque instruction restante est remplacée par son type (`DECLARE`, `READ`, `IF`, `WHILE`, `MOD`, `ASSIGN`, `CALL`, `RETURN`...) suivi de son niveau d'imbrication.
Le nom des variables et le texte exact des instructions ne sont donc pas pris en compte : `Per the attached, a is now b.` et `Per the attached, dividend is now divisor.` sont la même instruction.
 
La distance utilisée correspond au nombre minimal d'insertions, suppressions ou substitutions nécessaires pour transformer une séquence d'instructions en une autre (https://fr.wikipedia.org/wiki/Distance_de_Levenshtein).

Cette mesure est plus pertinente qu'une distance caractère par caractère car elle mesure davantage la différence entre les programmes eux-mêmes. La distance caractère par caractère donnerait de l'importance à des différences de présentation telles que les espaces, les retours à la ligne ou l'indentation.
 
Ma proposition `p` contient 32 instructions après normalisation. Les distances obtenues sont les suivantes :
 
| Proposition            | Nombre d'instructions | Distance | Distance normalisée |
| ---------------------- | --------------------: | -------: | ------------------: |
| p1 : ChatGPT           |                    17 |       21 |              65,6 % |
| p2 : DeepSeek V3       |                    32 |       31 |              96,9 % |
| p3 : Mistral AI        |                    20 |       23 |              71,9 % |
| p4 : Claude Sonnet 5.5 |                    14 |       20 |              62,5 % |
| p5 : Copilot           |                     9 |       25 |              78,1 % |
| p6 : Gemini            |                    19 |       32 |               100 % |
 
La distance normalisée est calculée par (https://metricgate.com/docs/fr/levenshtein-distance/) :
 
$$
D_{norm} =
\frac{D(p,p')}{\max(|p|,|p'|)}
$$
 
Cette normalisation permet de tenir compte du nombre différent d'instructions dans les programmes comparés.

Les distances sont globalement élevées, entre 62,5 % et 100 %. Elles indiquent que les propositions des LLM sont syntaxiquement éloignées de ma proposition. Il faut toutefois les lire avec précaution : comme `p` contient 32 instructions, la distance avec un programme de 14 instructions (p4) est au minimum de 18, soit 56,3 %.

Les propositions les plus proches de `p` sont p4 (Claude), p1 (ChatGPT) et p3 (Mistral). 
 
DeepSeek (p2) et Gemini (p6) sont les plus éloignées. Pour DeepSeek, c'est cohérent avec le choix des soustractions répétées avec deux boucles imbriquées et des mises à zéro (`is off the table.`), qui n'existent pas dans `p`. Pour Gemini, la distance de 100 % est cohérente avec le fait que le programme n'est pas écrit dans le langage Regards.
 
Pour savoir si `p` s'écarte de ce qu'un LLM écrit spontanément, il faut aussi comparer les propositions entre elles. Les distances normalisées de tous les programmes entre eux sont les suivantes :
 
|        |   p | p1 | p2 | p3 | p4 | p5 | p6 |
| ------ | --: | -: | -: | -: | -: | -: | -: |
| **p**  |   0 | 66 | 97 | 72 | 62 | 78 | 100 |
| **p1** |  66 |  0 | 88 | 50 | 29 | 47 | 100 |
| **p2** |  97 | 88 |  0 | 84 | 88 | 88 | 100 |
| **p3** |  72 | 50 | 84 |  0 | 50 | 55 | 100 |
| **p4** |  62 | 29 | 88 | 50 |  0 | 36 | 100 |
| **p5** |  78 | 47 | 88 | 55 | 36 |  0 | 100 |
| **p6** | 100 | 100 | 100 | 100 | 100 | 100 | 0 |
 
Les propositions p1, p4 et p5 (algorithme d'Euclide avec une boucle `while`) sont proches les unes des autres : entre 29 % et 47 %. Ma proposition `p` est entre 62 % et 78 % de chacune d'elles. Elle est donc plus éloignée de ces trois programmes qu'ils ne le sont entre eux, ce qui correspond bien à la différence d'organisation (fonction récursive contre boucle) décrite plus haut.

## 6. Qu'est-ce qui éloigne ma proposition de ce qu'un LLM écrit spontanément ?

La principale différence est l'organisation du calcul.

Les LLM qui ont correctement compris Regards choisissent spontanément une boucle correspondant directement à l'algorithme itératif d'Euclide :

```text
while b != 0
    remainder = a % b
    a = b
    b = remainder
```

Ma proposition utilise au contraire une fonction récursive.

Le calcul est donc exprimé comme une succession d'appels :

```text
PGCD(a,b)
    |
    +-- si b = 0 -> a
    |
    +-- sinon -> PGCD(b, a % b)
```

Ma proposition exploite davantage la structure narrative de Regards. Le programme est écrit comme une conversation par e-mails.

## 7. Quelle proposition est préférable ?

Sur le plan sémantique, ma proposition et celle de Claude sont les deux seules à obtenir 13/13 sur les tests.

Je préfère cependant ma proposition pour cette expérience parce qu'elle correspond mieux à l'objectif de l'exercice : produire un programme qui exploite les particularités du langage ésotérique plutôt que de traduire directement un pseudo-code classique.

La proposition de Claude est plus directe. Pour un programme destiné uniquement à calculer le PGCD, la version de Claude est plus simple à lire.

## 8. Ce que l'expérience montre

Le PGCD est un problème classique. La plupart des LLM identifient rapidement l'algorithme d'Euclide. Pourtant, plusieurs propositions échouent lorsqu'elles doivent traduire cet algorithme dans Regards.

Les erreurs observées sont de plusieurs types :

- mauvaise compréhension de la syntaxe d'une instruction
- mauvaise interprétation des affectations
- mauvaise gestion des valeurs négatives
- utilisation d'une syntaxe provenant d'un autre langage

Le pire cas est celui de Gemini : le modèle produit un algorithme qui ressemble à une solution mais qui n'est pas exprimé dans la syntaxe de Regards.

La confrontation montre donc que la difficulté n'est pas seulement de savoir calculer le PGCD, mais de savoir exprimer ce calcul dans le modèle syntaxique et sémantique du langage utilisé.

Un LLM peut connaître la bonne réponse mathématique sans nécessairement savoir produire le programme correspondant.
