
Write-Host ""
Write-Host "=============================="
Write-Host "    oifeel Push Manager    "
Write-Host "=============================="
Write-Host ""


Write-Host "Git pull en gours..."
$pullResult = git pull origin main 2>&1
if ($pullResult -match "Merge automatique n'a pas abouti") {
    Write-Host "Des conflits de merge ont ete detectes ! Resolution en cours..." -ForegroundColor Yellow
    
    $mergeMessage = "Merge la branche main pour synchroniser avec les changements a distance"
    Set-Content -Path ".git/MERGE_MSG" -Value $mergeMessage
    
    git add .
    git commit -m "PUSH bot"
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Merge echoue! Merci de resoudre les conflits manuellement" -ForegroundColor Red
        exit 1
    }
}


Write-Host "Git Pull les dernieres modifications..."
git pull origin main
git add .
git commit -m "PUSH bot"
if ($LASTEXITCODE -ne 0) {
    Write-Host "Rien a commit."
}
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "Push echoue!"
    exit 1
}
Write-Host "Changements pousses avec succes !."
Write-Host ""
Write-Host "Operation effectuee avec succes !"





