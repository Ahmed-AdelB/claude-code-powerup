# Pre-commit hook for Windows (PowerShell)
# Checks for secrets and runs linting before commit

param()

Write-Host "Running pre-commit checks..." -ForegroundColor Cyan

# Check for potential secrets
$patterns = @("password", "api_key", "secret", "token", "credential")
$files = git diff --cached --name-only --diff-filter=ACM | Where-Object { $_ -match '\.(js|ts|jsx|tsx|py|json)$' }

foreach ($file in $files) {
    foreach ($pattern in $patterns) {
        $matches = Select-String -Path $file -Pattern $pattern -CaseSensitive:$false 2>$null
        if ($matches) {
            Write-Host "[WARN] Potential secret found in $file" -ForegroundColor Yellow
            Write-Host "       Pattern: $pattern" -ForegroundColor Yellow
        }
    }
}

# Run linter if available
if (Test-Path "package.json") {
    $packageJson = Get-Content "package.json" | ConvertFrom-Json
    if ($packageJson.scripts.lint) {
        Write-Host "Running linter..." -ForegroundColor Cyan
        npm run lint
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[ERROR] Linting failed" -ForegroundColor Red
            exit 1
        }
    }
}

Write-Host "[OK] Pre-commit checks passed" -ForegroundColor Green
exit 0
