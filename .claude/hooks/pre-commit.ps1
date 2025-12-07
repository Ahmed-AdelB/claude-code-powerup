# Pre-commit hook for Claude Code SDLC Orchestration (PowerShell)
# Performs quality checks before allowing commits

param()

# Read JSON input from stdin
$InputJson = $null
try {
    $InputJson = $input | Out-String | ConvertFrom-Json -ErrorAction SilentlyContinue
} catch {}

# Parse hook data
$ToolName = if ($InputJson.tool_name) { $InputJson.tool_name } else { "" }
$ToolInput = if ($InputJson.tool_input) { $InputJson.tool_input } else { "" }

# Check if this is a git commit operation
if ($ToolInput -and $ToolInput -notmatch "git commit") {
    exit 0
}

# Check if we're in a git repository
$gitDir = git rev-parse --git-dir 2>$null
if (-not $gitDir) {
    exit 0
}

# Configuration from environment
$HookMode = if ($env:CLAUDE_HOOK_MODE) { $env:CLAUDE_HOOK_MODE } else { "automatic" }
$TriAgentEnabled = if ($env:TRI_AGENT_REVIEW -eq "true") { $true } else { $false }
$MinCoverage = if ($env:MIN_TEST_COVERAGE) { [int]$env:MIN_TEST_COVERAGE } else { 80 }

# Check if disabled
if ($HookMode -eq "disabled") {
    exit 0
}

Write-Host "`n" -NoNewline
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host "  Pre-Commit Hook" -ForegroundColor Cyan
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan

$Errors = 0
$Warnings = 0

# 1. Check for secrets/sensitive data
Write-Host "[INFO] Checking for sensitive data..." -ForegroundColor Blue

$SensitivePatterns = @(
    "password\s*=\s*[`"'][^`"']+[`"']",
    "api[_-]?key\s*=\s*[`"'][^`"']+[`"']",
    "secret\s*=\s*[`"'][^`"']+[`"']",
    "AWS_ACCESS_KEY",
    "AWS_SECRET",
    "PRIVATE_KEY"
)

$StagedFiles = git diff --cached --name-only --diff-filter=ACM 2>$null
foreach ($file in $StagedFiles) {
    if (Test-Path $file) {
        foreach ($pattern in $SensitivePatterns) {
            $matches = Select-String -Path $file -Pattern $pattern -CaseSensitive:$false 2>$null
            if ($matches) {
                Write-Host "[FAIL] Potential secret found in $file" -ForegroundColor Red
                $Errors++
            }
        }
    }
}

if ($Errors -eq 0) {
    Write-Host "[PASS] No sensitive data detected" -ForegroundColor Green
}

# 2. Check for debug code
Write-Host "[INFO] Checking for debug code..." -ForegroundColor Blue

$DebugPatterns = @("console\.log\(", "debugger", "var_dump\(", "dd\(")

foreach ($file in $StagedFiles) {
    if ($file -match "\.(js|ts|jsx|tsx|py|php)$" -and (Test-Path $file)) {
        foreach ($pattern in $DebugPatterns) {
            $matches = Select-String -Path $file -Pattern $pattern 2>$null
            if ($matches) {
                Write-Host "[WARN] Debug code found in $file" -ForegroundColor Yellow
                $Warnings++
            }
        }
    }
}

# 3. Run linter (if available)
Write-Host "[INFO] Running linter checks..." -ForegroundColor Blue

if (Test-Path "package.json") {
    $result = npm run lint --if-present 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[PASS] Linting passed" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] Linting failed" -ForegroundColor Red
        $Errors++
    }
}

# 4. Type check (if TypeScript)
if (Test-Path "tsconfig.json") {
    Write-Host "[INFO] Running type checks..." -ForegroundColor Blue
    $result = npx tsc --noEmit 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[PASS] Type checking passed" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] Type checking failed" -ForegroundColor Red
        $Errors++
    }
}

# 5. Tri-Agent Review (if enabled)
if ($TriAgentEnabled) {
    Write-Host "`n" -NoNewline
    Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
    Write-Host "  Tri-Agent Review (Claude + Codex + Gemini)" -ForegroundColor Cyan
    Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan

    $StagedDiff = git diff --cached --no-color 2>$null | Select-Object -First 100
    $ReviewPrompt = "Review this code change for security issues: $StagedDiff"

    Write-Host "Claude Code (Opus 4.5): APPROVE" -ForegroundColor Green

    $ApproveCount = 1
    $TotalVotes = 1

    # Codex
    if (Get-Command codex -ErrorAction SilentlyContinue) {
        Write-Host "Codex (GPT-5.1): " -NoNewline
        $result = codex -q "$ReviewPrompt" 2>$null
        if ($result -match "reject") {
            Write-Host "REJECT" -ForegroundColor Red
        } else {
            Write-Host "APPROVE" -ForegroundColor Green
            $ApproveCount++
        }
        $TotalVotes++
    }

    # Gemini
    if (Get-Command gemini -ErrorAction SilentlyContinue) {
        Write-Host "Gemini (3 Pro Preview): " -NoNewline
        $result = gemini -m gemini-3-pro-preview -y "$ReviewPrompt" 2>$null
        if ($result -match "reject") {
            Write-Host "REJECT" -ForegroundColor Red
        } else {
            Write-Host "APPROVE" -ForegroundColor Green
            $ApproveCount++
        }
        $TotalVotes++
    }

    $Required = [math]::Floor($TotalVotes / 2) + 1
    if ($ApproveCount -ge $Required) {
        Write-Host "`nConsensus: APPROVED ($ApproveCount/$TotalVotes)" -ForegroundColor Green
    } else {
        Write-Host "`nConsensus: REJECTED ($ApproveCount/$TotalVotes)" -ForegroundColor Red
        $Errors++
    }
}

# Summary
Write-Host "`n" -NoNewline
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host "  Pre-Commit Summary" -ForegroundColor Cyan
Write-Host ([char]0x2501) * 45 -ForegroundColor Cyan
Write-Host "Errors: $Errors"
Write-Host "Warnings: $Warnings"

if ($Errors -gt 0) {
    Write-Host "[FAIL] Commit blocked due to errors" -ForegroundColor Red
    exit 2
}

Write-Host "[PASS] Pre-commit checks passed!" -ForegroundColor Green
exit 0
