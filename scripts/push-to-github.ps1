# Push Claude Code Power-Up to GitHub
# Run this once network connectivity is restored

Write-Host "Pushing to GitHub..." -ForegroundColor Cyan

Set-Location "C:\Users\ahmed\claude-code-powerup"

# Check status
git status

# Push
git push origin master

if ($LASTEXITCODE -eq 0) {
    Write-Host "[OK] Successfully pushed to GitHub" -ForegroundColor Green
    Write-Host "View at: https://github.com/Ahmed-AdelB/claude-code-powerup" -ForegroundColor Cyan
} else {
    Write-Host "[ERROR] Push failed - check network connectivity" -ForegroundColor Red
}
