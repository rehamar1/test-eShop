# e_shop

E-Shop est une application Flutter permettant aux utilisateurs de parcourir et d'acheter des produits en ligne. L'application utilise les APIs de [dummyjson](https://dummyjson.com/) pour obtenir les données des produits et Firebase Authentication pour l'authentification des utilisateurs.

## Configuration du Projet

### Prérequis

- Flutter 3.22.2
- Un compte Firebase

### Installation

1. Clonez le projet :

   ```bash
   git clone git clone https://github.com/rehamar1/test-eShop.git
   cd test-eShop

2. L'architecture :
   Le projet suit une architecture basée sur le modèle MVC (Modèle-Vue-Contrôleur). Les fichiers sont organisés de la manière suivante :
- lib/
  - screens/
    - home_screen.dart
    - ...
  - blocs/
    - product/
      - product_bloc.dart
      - product_event.dart
      - product_state.dart
    - cart/
      - cart_bloc.dart
      - cart_event.dart
      - cart_state.dart
  - models/
    - product.dart
  - notifications/
    - notification_service.dart
  - repository/
    - product_repository.dart
  - services/
    - auth_service.dart 
  - main.dart
 
  ## Utilisation
  ### Exécution de l'application
      Pour exécuter l'application, suivez ces étapes :
         1. Assurez-vous d'avoir Flutter installé sur votre machine.
         2. Clonez ce dépôt.
         3. Exécutez la commande suivante pour installer les dépendances  : flutter pub get
         4. Connectez votre appareil ou lancez un émulateur.
         5. Lancez l'application avec la commande : flutter run
  ### Fonctionnalités
      Écran connexion : Pour soit connecter ou s'inscrire
      Écran d'accueil : Affiche la liste des produits disponibles , recherche et filtrer des produits .
      Carte produit : Affiche écran détail d'un produit 
      Panier : Permet de consulter ou supprimer des produits du panier.
