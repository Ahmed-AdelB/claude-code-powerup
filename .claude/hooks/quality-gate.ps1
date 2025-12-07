# Quality gate hook for Claude Code SDLC Orchestration (PowerShell)
# Enforces quality standards before task completion

param()

# Read JSON input from stdin
$InputJson = $null
try {
    $InputJson = $input | Out-String | ConvertFrom-Json -ErrorAction SilentlyContinue
} catch {}

# Configuration from environment
$HookMode = if ($env:CLAUDE_HOOK_MODE) { $env:CLAUDE_HOOK_MODE } else { "automatic" }
$MinCoverage = if ($env:MIN_TEST_COVERAGE) { [int]$env:MIN_TEST_COVERAGE } else { 80 }
$RequireTests = if ($env:REQUIRE_TESTS -eq "false") { $false } else { $true }
$RequireDocs = if ($env:REQUIRE_DOCS -eq "true") { $true } else { $false }

# Check if disabled
if ($HookMode -eq "disabled") {
    exit 0
}

Write-Host "`n" -NoNewline
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host "  Quality Gate Check" -ForegroundColor Cyan
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host ""

$Passed = 0
$Failed = 0
$Warnings = 0

# 1. Check test coverage
Write-Host "[QUALITY] Checking test coverage..." -ForegroundColor Blue

$Coverage = 0
if (Test-Path "coverage/coverage-summary.json") {
    try {
        $coverageData = Get-Content "coverage/coverage-summary.json" | ConvertFrom-Json
        $Coverage = $coverageData.total.lines.pct
    } catch {}
}

if ($Coverage -gt 0) {
    if ($Coverage -ge $MinCoverage) {
        Write-Host "[QUALITY] Test coverage: $Coverage% (minimum: $MinCoverage%)" -ForegroundColor Green
        $Passed++
    } else {
        Write-Host "[QUALITY] Test coverage: $Coverage% (minimum: $MinCoverage%)" -ForegroundColor Red
        $Failed++
    }
} else {
    if ($RequireTests) {
        Write-Host "[QUALITY] Could not determine test coverage" -ForegroundColor Yellow
        $Warnings++
    }
}

# 2. Run tests
Write-Host "[QUALITY] Running tests..." -ForegroundColor Blue

$TestResult = $true
if (Test-Path "package.json") {
    $pkgJson = Get-Content "package.json" | ConvertFrom-Json
    if ($pkgJson.scripts.test) {
        npm test 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { $TestResult = $false }
    }
} elseif (Test-Path "pytest.ini" -or Test-Path "pyproject.toml") {
    if (Get-Command pytest -ErrorAction SilentlyContinue) {
        pytest 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { $TestResult = $false }
    }
}

if ($TestResult) {
    Write-Host "[QUALITY] All tests passing" -ForegroundColor Green
    $Passed++
} else {
    Write-Host "[QUALITY] Tests failed" -ForegroundColor Red
    $Failed++
}

# 3. Check for linting errors
Write-Host "[QUALITY] Checking for linting errors..." -ForegroundColor Blue

$LintResult = $true
if (Test-Path "package.json") {
    $pkgJson = Get-Content "package.json" | ConvertFrom-Json
    if ($pkgJson.scripts.lint) {
        npm run lint 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { $LintResult = $false }
    }
} elseif (Get-Command ruff -ErrorAction SilentlyContinue) {
    ruff check . 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $LintResult = $false }
}

if ($LintResult) {
    Write-Host "[QUALITY] No linting errors" -ForegroundColor Green
    $Passed++
} else {
    Write-Host "[QUALITY] Linting errors found" -ForegroundColor Red
    $Failed++
}

# 4. Check for type errors
Write-Host "[QUALITY] Checking for type errors..." -ForegroundColor Blue

$TypeResult = $true
if (Test-Path "tsconfig.json") {
    npx tsc --noEmit 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $TypeResult = $false }
} elseif ((Get-Command mypy -ErrorAction SilentlyContinue) -and (Test-Path "pyproject.toml")) {
    mypy . 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $TypeResult = $false }
}

if ($TypeResult) {
    Write-Host "[QUALITY] No type errors" -ForegroundColor Green
    $Passed++
} else {
    Write-Host "[QUALITY] Type errors found" -ForegroundColor Red
    $Failed++
}

# 5. Check for security vulnerabilities
Write-Host "[QUALITY] Checking for security vulnerabilities..." -ForegroundColor Blue

$SecurityResult = $true
if (Test-Path "package-lock.json") {
    npm audit --audit-level=high 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { $SecurityResult = $false }
}

if ($SecurityResult) {
    Write-Host "[QUALITY] No high/critical vulnerabilities" -ForegroundColor Green
    $Passed++
} else {
    Write-Host "[QUALITY] Security vulnerabilities detected" -ForegroundColor Yellow
    $Warnings++
}

# 6. Check documentation
if ($RequireDocs) {
    Write-Host "[QUALITY] Checking documentation..." -ForegroundColor Blue
    if (Test-Path "README.md") {
        Write-Host "[QUALITY] README.md present" -ForegroundColor Green
        $Passed++
    } else {
        Write-Host "[QUALITY] README.md missing" -ForegroundColor Yellow
        $Warnings++
    }
}

# 7. Check git status
Write-Host "[QUALITY] Checking git status..." -ForegroundColor Blue

$GitClean = $true
$diff1 = git diff --quiet 2>$null
$diff2 = git diff --cached --quiet 2>$null
if ($LASTEXITCODE -ne 0) { $GitClean = $false }

if ($GitClean) {
    Write-Host "[QUALITY] Working directory clean" -ForegroundColor Green
    $Passed++
} else {
    Write-Host "[QUALITY] Uncommitted changes detected" -ForegroundColor Yellow
    $Warnings++
}

# Summary
Write-Host "`n" -NoNewline
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host "  Quality Gate Summary" -ForegroundColor Cyan
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host ""
Write-Host "  Passed:   $Passed" -ForegroundColor Green
Write-Host "  Failed:   $Failed" -ForegroundColor Red
Write-Host "  Warnings: $Warnings" -ForegroundColor Yellow
Write-Host ""

if ($Failed -gt 0) {
    Write-Host "[QUALITY] Quality gate FAILED" -ForegroundColor Red
    exit 1
}

if ($Warnings -gt 0) {
    Write-Host "[QUALITY] Quality gate PASSED with warnings" -ForegroundColor Yellow
} else {
    Write-Host "[QUALITY] Quality gate PASSED" -ForegroundColor Green
}

exit 0
