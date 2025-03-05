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
$deploy_output = netlify deploy --prod

# Extraire l'URL du site depuis la sortie de Netlify
if ($deploy_output -match "Website URL:\s+(https?://\S+)") {
    $website_url = $matches[1]
    Write-Output "✅ Deployment complete! Your site is live at: $website_url"

    # Ouvrir le site dans le navigateur par défaut
    Start-Process $website_url
} else {
    Write-Output "⚠️ Deployment complete, but failed to extract the website URL."
}

