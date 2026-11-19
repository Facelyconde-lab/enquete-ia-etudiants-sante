# Enquête : l'IA et la robotique vue par les étudiants en santé

Projet de groupe réalisé en L2 MIASHS (Université de Bordeaux, UE Techniques d'enquête, 2025-2026).

**Question de départ :** comment les étudiants en santé perçoivent-ils l'usage de l'IA et de la robotique, entre aide à la précision et risque de déshumanisation du soin ?

## Démarche

- **Partie qualitative** : entretiens semi-directifs avec des étudiants en médecine, analyse thématique (méthode de Paillé et Mucchielli).
- **Partie quantitative** : questionnaire, sous-échantillon des 38 répondants de la filière santé, analyse sous R.

## Ce que fait le script `analyse_questionnaire.R`

- import et nettoyage des réponses (encodage, typage des variables)
- statistiques descriptives : moyennes, écarts-types, histogrammes, boxplots, diagrammes en barres
- test de trois hypothèses :
  - H1 : corrélation entre aide perçue et performance perçue (Pearson, `cor.test`)
  - H2 : lien entre sentiment global et vérification des résultats (test du Chi-2)
  - H3 : effet de la fréquence d'usage sur la performance perçue (rapport η², ANOVA)

Les données du questionnaire et les entretiens ne sont pas publiés (données de personnes interrogées).

## Outils

R (base R : `read.table`, `table`, `chisq.test`, `cor.test`, `aov`)
