# Quality gate hook for Windows (PowerShell)
# Enforces quality standards before deployment

param()

Write-Host "Running quality gate checks..." -ForegroundColor Cyan

$failed = $false

# Check test coverage if available
if (Test-Path "package.json") {
    $packageJson = Get-Content "package.json" | ConvertFrom-Json

    if ($packageJson.scripts.test) {
        Write-Host "Running tests..." -ForegroundColor Cyan
        npm test
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[ERROR] Tests failed" -ForegroundColor Red
            $failed = $true
        } else {
            Write-Host "[OK] Tests passed" -ForegroundColor Green
        }
    }

    # Security audit
    Write-Host "Running security audit..." -ForegroundColor Cyan
    npm audit --audit-level=high 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[WARN] Security vulnerabilities found" -ForegroundColor Yellow
    } else {
        Write-Host "[OK] No high-severity vulnerabilities" -ForegroundColor Green
    }
}

# Check for Python projects
if (Test-Path "requirements.txt") {
    if (Get-Command pytest -ErrorAction SilentlyContinue) {
        Write-Host "Running pytest..." -ForegroundColor Cyan
        pytest
        if ($LASTEXITCODE -ne 0) {
            Write-Host "[ERROR] Pytest failed" -ForegroundColor Red
            $failed = $true
        }
    }
}

if ($failed) {
    Write-Host "[FAILED] Quality gate checks failed" -ForegroundColor Red
    exit 1
} else {
    Write-Host "[PASSED] All quality gate checks passed" -ForegroundColor Green
    exit 0
}
