# Post-edit hook for Claude Code SDLC Orchestration (PowerShell)
# Performs formatting and validation after file edits

param()

# Read JSON input from stdin
$InputJson = $null
try {
    $InputJson = $input | Out-String | ConvertFrom-Json -ErrorAction SilentlyContinue
} catch {}

# Parse hook data
$ToolName = if ($InputJson.tool_name) { $InputJson.tool_name } else { "" }
$FilePath = if ($InputJson.tool_input.file_path) { $InputJson.tool_input.file_path } else { "" }

# Configuration from environment
$HookMode = if ($env:CLAUDE_HOOK_MODE) { $env:CLAUDE_HOOK_MODE } else { "automatic" }
$AutoFormat = if ($env:AUTO_FORMAT -eq "false") { $false } else { $true }
$AutoLintFix = if ($env:AUTO_LINT_FIX -eq "false") { $false } else { $true }

# Check if disabled
if ($HookMode -eq "disabled") {
    exit 0
}

# Only process Edit and Write tools
if ($ToolName -ne "Edit" -and $ToolName -ne "Write") {
    exit 0
}

# Skip if no file path or file doesn't exist
if (-not $FilePath -or -not (Test-Path $FilePath)) {
    exit 0
}

# Get file extension
$Ext = [System.IO.Path]::GetExtension($FilePath).TrimStart(".")

# Auto-format based on file type
if ($AutoFormat) {
    switch -Regex ($Ext) {
        "^(js|jsx|ts|tsx|json|md|css|scss|html)$" {
            if (Get-Command prettier -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Formatting $FilePath with Prettier..." -ForegroundColor Blue
                prettier --write $FilePath 2>$null
            } elseif (Get-Command npx -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Formatting $FilePath with Prettier (npx)..." -ForegroundColor Blue
                npx prettier --write $FilePath 2>$null
            }
        }
        "^py$" {
            if (Get-Command black -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Formatting $FilePath with Black..." -ForegroundColor Blue
                black $FilePath 2>$null
            } elseif (Get-Command ruff -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Formatting $FilePath with Ruff..." -ForegroundColor Blue
                ruff format $FilePath 2>$null
            }
        }
        "^go$" {
            if (Get-Command gofmt -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Formatting $FilePath with gofmt..." -ForegroundColor Blue
                gofmt -w $FilePath 2>$null
            }
        }
        "^rs$" {
            if (Get-Command rustfmt -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Formatting $FilePath with rustfmt..." -ForegroundColor Blue
                rustfmt $FilePath 2>$null
            }
        }
    }
}

# Auto-fix lint issues
if ($AutoLintFix) {
    switch -Regex ($Ext) {
        "^(js|jsx|ts|tsx)$" {
            if (Get-Command npx -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Auto-fixing lint issues in $FilePath..." -ForegroundColor Blue
                npx eslint --fix $FilePath 2>$null
            }
        }
        "^py$" {
            if (Get-Command ruff -ErrorAction SilentlyContinue) {
                Write-Host "[POST-EDIT] Auto-fixing lint issues in $FilePath..." -ForegroundColor Blue
                ruff check --fix $FilePath 2>$null
            }
        }
    }
}

# Validate file syntax
switch ($Ext) {
    "json" {
        try {
            Get-Content $FilePath -Raw | ConvertFrom-Json | Out-Null
        } catch {
            Write-Host "[POST-EDIT] Invalid JSON syntax in $FilePath" -ForegroundColor Yellow
        }
    }
    "py" {
        if (Get-Command python -ErrorAction SilentlyContinue) {
            $result = python -m py_compile $FilePath 2>&1
            if ($LASTEXITCODE -ne 0) {
                Write-Host "[POST-EDIT] Python syntax error in $FilePath" -ForegroundColor Yellow
            }
        }
    }
}

# Check for TODO/FIXME comments
$todoMatches = Select-String -Path $FilePath -Pattern "TODO|FIXME|XXX|HACK" -CaseSensitive 2>$null
if ($todoMatches) {
    Write-Host "[POST-EDIT] Found TODO/FIXME comments in $FilePath" -ForegroundColor Blue
}

Write-Host "[POST-EDIT] Post-edit processing complete for $FilePath" -ForegroundColor Green
exit 0
