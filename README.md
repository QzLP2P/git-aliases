# git-aliases

Collection de commandes Git personnalisées pour Windows (PowerShell + CMD) qui simplifient les workflows Git courants.

## Installation

1. Cloner le dépôt :

   ```bash
   git clone https://github.com/QzLP2P/git-aliases.git
   ```

2. Ajouter le dossier au PATH utilisateur :

   ```powershell
   .\add-to-user-path.ps1
   ```

3. Rouvrir un terminal pour que le PATH soit pris en compte.

## Commandes disponibles

| Commande | Alias | Description |
|----------|-------|-------------|
| `git-sync-branch` | `gsb` | Fetch + checkout + rebase d'une branche sur origin |
| `git-save-to-new-branch` | `gsnb` | Crée une branche, ajoute les modifications et commit (sans push) |
| `git-create-branch-commit-push` | `gbcp` | Crée une branche, commit et push sur origin |
| `git-rebase-onto` | `gro` | Rebase la branche courante sur une branche cible (normal ou interactif) |
| `git-tag-and-push` | `gtp` | Crée un tag annoté et le pousse sur origin |
| `git-commit-push` | `gcp` | Add all + commit + push de la branche courante |
| `git-scripts-help` | `gsh` | Affiche l'aide de toutes les commandes |

## Exemples

```bash
# Mettre à jour la branche main
gsb main

# Créer une branche feature, commiter et pousser
gbcp feature/ma-feature "feat: ajout du filtre"

# Commiter et pousser rapidement
gcp "fix: correction du tri"

# Rebase interactif sur develop
gro develop interactive

# Tagger une release
gtp v1.0.0 "Release 1.0.0"

# Sauvegarder le travail en cours sur une nouvelle branche
gsnb feature/wip "WIP: travail en cours"

# Afficher l'aide
gsh
```

## Structure du projet

- `*.ps1` — Scripts PowerShell contenant la logique
- `*.cmd` — Wrappers batch pour appeler les scripts depuis un terminal classique
- `build-script.ps1` — Génère les fichiers `.cmd` wrappers
- `add-to-user-path.ps1` — Ajoute le dossier au PATH utilisateur Windows

## Prérequis

- Windows 10/11
- PowerShell 5.1+
- Git installé et accessible dans le PATH

## Licence

MIT — voir [LICENSE](LICENSE).
