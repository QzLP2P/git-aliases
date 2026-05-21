Write-Host ""
Write-Host "=== Commandes Git personnalisees ===" -ForegroundColor Cyan
Write-Host ""

$commands = @(
    @{
        Name = "git-sync-branch"
        Alias = "gsb"
        Description = "Se place sur une branche, fait un fetch puis un pull --rebase pour la mettre a jour."
        Usage = "git-sync-branch <branch>   |   gsb <branch>"
        Example = "gsb main"
    },
    @{
        Name = "git-save-to-new-branch"
        Alias = "gsnb"
        Description = "Cree une nouvelle branche depuis l'etat courant, ajoute toutes les modifications et commit."
        Usage = "git-save-to-new-branch <branch-name> [message]   |   gsnb <branch-name> [message]"
        Example = 'gsnb feature/mon-ticket "WIP: premiere version"'
    },
    @{
        Name = "git-create-branch-commit-push"
        Alias = "gbcp"
        Description = "Cree une nouvelle branche depuis l'etat courant, ajoute toutes les modifications, commit puis pousse la branche sur origin."
        Usage = "git-create-branch-commit-push <branch-name> <message>   |   gbcp <branch-name> <message>"
        Example = 'gbcp feature/filter-cleanup "feat: nettoyage du filtre"'
    },
    @{
        Name = "git-rebase-onto"
        Alias = "gro"
        Description = "Met a jour une branche cible puis fait un rebase de la branche courante dessus. Mode normal ou interactif."
        Usage = "git-rebase-onto <target-branch> [normal|interactive]   |   gro <target-branch> [normal|interactive]"
        Example = "gro develop interactive"
    },
    @{
        Name = "git-tag-and-push"
        Alias = "gtp"
        Description = "Cree un tag annote puis le pousse sur origin."
        Usage = "git-tag-and-push <tag-name> [message]   |   gtp <tag-name> [message]"
        Example = 'gtp v1.2.0 "Release 1.2.0"'
    },
    @{
        Name = "git-commit-push"
        Alias = "gcp"
        Description = "Ajoute toutes les modifications, cree un commit puis pousse la branche courante sur origin."
        Usage = "git-commit-push <message>   |   gcp <message>"
        Example = 'gcp "fix: clean filter logic"'
    },
    @{
        Name = "git-scripts-help"
        Alias = "gsh"
        Description = "Affiche la liste des commandes Git personnalisees disponibles, leur usage et des exemples."
        Usage = "git-scripts-help   |   gsh"
        Example = "gsh"
    }
)

foreach ($cmd in $commands) {
    Write-Host "Commande    : " -NoNewline
    Write-Host $cmd.Name -ForegroundColor Green

    Write-Host "Alias       : " -NoNewline
    Write-Host $cmd.Alias -ForegroundColor Yellow

    Write-Host "Description : $($cmd.Description)"
    Write-Host "Usage       : $($cmd.Usage)"
    Write-Host "Exemple     : $($cmd.Example)"
    Write-Host ""
}