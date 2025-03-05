# Vérifier si Git et Netlify CLI sont installés
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Output "❌ Git is not installed or not in PATH."
    Exit
}

if (-not (Get-Command netlify -ErrorAction SilentlyContinue)) {
    Write-Output "❌ Netlify CLI is not installed or not in PATH."
    Exit
}

# Demander un message de commit personnalisé
$commit_message = Read-Host "Enter commit message"

# Ajouter tous les fichiers modifiés à Git
git add .

# Commit avec le message personnalisé
git commit -m "$commit_message"

# Pousser les changements sur GitHub
git push origin main

# Déployer sur Netlify
netlify deploy --prod

# Afficher un message de succès
Write-Output "✅ Deployment complete! Your site is live."
