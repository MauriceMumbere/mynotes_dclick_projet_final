# MyNotes 📓

[![Flutter](https://img.shields.io/badge/Flutter-2.20-blue?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-2.19-blue?logo=dart&logoColor=white)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

**MyNotes** est une application mobile Flutter de prise de notes simple et efficace avec un système d'authentification local. Elle vous permet de gérer vos notes en toute simplicité : créer, lire, modifier et supprimer, tout en gardant vos informations sécurisées.

---

## ✨ Fonctionnalités

- **Authentification locale :** Gérez votre session avec des fonctionnalités d'inscription, de connexion et de déconnexion.
- **Gestion des notes (CRUD) :** Créez, lisez, mettez à jour et supprimez vos notes facilement.
- **Expérience utilisateur intuitive :** Profitez d'une interface responsive et minimaliste conçue avec Flutter Material3.
- **Stockage sécurisé :** Vos données sont stockées localement sur votre appareil à l'aide de **SQLite**.
- **Splash Screen intelligent :** L'application vérifie automatiquement votre état de connexion au démarrage pour une redirection instantanée.

---

## 🚀 Installation

Suivez ces étapes pour lancer l'application sur votre machine :

1.  **Clonez le dépôt :**

    ```bash
    git clone [https://github.com/ton-utilisateur/mynotes.git](https://github.com/ton-utilisateur/mynotes.git)
    cd mynotes
    ```

2.  **Installez les dépendances :**

    ```bash
    flutter pub get
    ```

3.  **Exécutez l'application :**
    ```bash
    flutter run
    ```

---

## 🛠️ Packages utilisés

- `sqflite` : Pour la base de données locale (SQLite).
- `path` : Pour la gestion des chemins de fichiers.
- `shared_preferences` : Pour le stockage de l'état de connexion de l'utilisateur.

---

## ➡️ Fonctionnement de l'application

1.  **Démarrage :** L'application commence par un écran de démarrage (`IntroScreen`) qui affiche le logo pendant quelques secondes.
2.  **Vérification de l'état :** Un appel à `DBAuth.getLoginStatus()` est effectué.
3.  **Redirection :**
    - Si l'utilisateur est déjà connecté, il est automatiquement redirigé vers **`HomeScreen`**.
    - Sinon, il est dirigé vers **`LoginScreen`** pour s'authentifier.
4.  **Gestion des notes :** Depuis **`HomeScreen`**, vous pouvez créer, modifier ou supprimer des notes.
5.  **Déconnexion :** L'icône de déconnexion dans **`HomeScreen`** efface la session de l'utilisateur et le redirige vers l'écran de connexion.

---

## 📝 Licence

Ce projet est sous licence **MIT**. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

---
