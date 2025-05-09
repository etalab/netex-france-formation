# Généralités

Ce dépôt contient un ensemble de présentations permettant de se former de façon interactive à l'usage de la norme européenne NeTEx. Le contenu regroupe à la fois des éléments théoriques et des exercices à faire.

La formation s'appuie sur [Livebook](https://livebook.dev/), outil gratuit disponible [pour Windows et MacOS](https://livebook.dev/#install). L'installation est aussi possible sous Linux quoiqu'un peu plus complexe.

Pour pouvoir dérouler cette formation, vous devez télécharger le contenu de ce dépôt.

## Pour télécharger le contenu

Vous avez deux possibilités:
- (recommandé) "cloner" ce dépôt GitHub sur votre machine, par exemple avec [GitHub Desktop](https://github.com/apps/desktop)
- (alternative) télécharger le zip de la [release](releases) et le décompresser sur votre machine

Une fois le contenu récupéré, vous pouvez ouvrir directement les fichiers `.livemd` avec Livebook (voir plus bas).

## Pour ouvrir le contenu

Vous devez suivre ces étapes :
1. Avoir installé Livebook sur votre machine
2. Avoir télécharger le contenu de ce dépôt (voir point précédent)
3. Dans le contenu téléchargé, naviguer jusqu'au sous-dossier `livebooks\1_intro`
4. Ouvrir le fichier `intro.livemd`

La navigation vers les autres parties de la formation se font sur la base des liens situés en bas de page. 

**Note** : Ouvrir le contenu directement en ligne dans ce dépôt GitHub est aussi possible mais l'ensemble du code de la formation sera également apparent.

## Structure du dépôt

Voici les éléments principaux du dépôt:

- `livebooks`
  - `1_intro/intro.livemd` - Introduction générale avec la présentation des formateurs et quelques règles de base
  - `2_bases/bases.livemd` - Les définitions et concepts de base nécessaires à la compréhensions des parties suivantes
  - `3_reseau/reseau_rochefort.livemd` - La modélisation d'un réseau en NeTEx en partant d'un exemple concret
  - `4_reseau/Stop_place.livemd` - La modélisation de la multimodalité dans NeTEx
  - `5_accessibilite/accessibilite_transport.livemd` - La modélisation de l'accessibilité des transports avec NeTEx
  - `5_accessibilite/accessibilite_voirie.livemd` - La modélisation de l'accessibilité de la voirie avec NeTEx
  - `6_outils/outils.livemd` - La présentation de l'ensemble des outils utiles pour creuser davantage le sujet
- `lib` - code utilisé par les livebooks
- `data` - capture des jeux de données utilisés pour la formation et ses exercices

## Auteurs

Dans l'ordre des Livebooks

|Prénom & Nom |Affiliation |Expertise pour la formation | Email |
|------|--------------------------------------|------------------|-------------------------|
|Tu-Tho Thai|Indépendante|Concepts de base & Ressources|tutho@ttandj.com|
|Ariane Durand|CS Group|Modélisation des réseaux de transport|ariane.durand@cs-soprasteria.com|
|Thibaut Barrère|Indépendant|Modélisation des réseaux de transport|thibaut.barrere@gmail.com|
|Thierry Hénault|CS Group|La représentation de la multimodalité|thierry.henault@cs-soprasteria.com|
|Noémie Lehuby|Jungle Bus|L'accessibilité des transports et de la voirie|noemie@junglebus.io|

## En cas de question ou problème

Nous vous invitons à créer un ticket dans ce dépôt. Pour ce faire, vous deviez :
- sélectionner `Issues` dans le ruban supérieur
- cliquer sur `New issue`
- entrer un titre
- décrire votre question ou problème
- valider le tout en appuysant sur le bouton `Create`

**Note** : les questions et problèmes de ce dépôt ne doivent concerner que le contenu de la formation et ses supports. Pour toute question / demande liée au profil France de NeTEx, merci de bien vouloir utiliser [l'espace de travail du profil France de NeTEx](https://github.com/etalab/transport-profil-netex-fr), piloté par le GT7.

# Crédits / attributions

Le contenu documentaire de ce dépôt sont placés sous la licence CC-BY.
Les images présentées (illustrations, photos) ont leurs propres licences ou conditions de réutilisations. Si non précisé dans le livebook, elles sont également placées sous la licence CC-BY.

Le code présent dans ce dépôt est placé sous la licence WTFPL.

Ce dépôt comporte également des données d'exemple. Elles sont toutes issues du Point d'Accès National (les liens sont précisés dans les livebooks) et ont leur propre licence :
- ODbL (Nouvelle-Aquitaine Mobilités) pour le jeu de donnée de la partie 3
- LO (Syndicat mixte Atoumod, mars 2025) pour le jeu de donnée de la partie 4
- ODbL (Jungle Bus / contributeurs OpenStreetMap) pour les jeux de données de la partie 5

Merci aux producteurs de données qui utilisent le format NeTEx pour diffuser leurs données.

# Liens utiles

| Titre                                          | Description                                                        | Lien                                                                                     |
| ---------------------------------------------- | ------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- |
| Livebook                                       | Pour consulter le contenu de la formation                          | https://livebook.dev/#install                                                            |
| GitHub Desktop                                 | Pour cloner le contenu du dépôt de la formation                    | https://github.com/apps/desktop                                                          |
| Enterprise Architect Viewer                    | Pour visualiser le diagramme UML de Transmodel                     | https://sparxsystems.com/products/ea/downloads.html                                      |
| XMLSpy                                         | Outil de visualisation de la XSD de NeTEx et SIRI                  | https://www.altova.com/xmlspy-xml-editor/download                                        |
| Visual Code Studio                             | Pour lire et éditer des fichiers XML                              | https://code.visualstudio.com/download                                                   |
| Visual Code Studio - extension JSON & XML grid | Pour bénéfichier d'une vue sous forme de grille d'un fichier XML | https://marketplace.visualstudio.com/items?itemName=EddilbertMacharia.jsonxmlgridviewer  |
| Notepad++                                      | Pour lire et éditer des fichiers XML                              | https://notepad-plus-plus.org/downloads/                                                 |
