# Claude Code Power-Up Verification Script
# Run this to verify your installation is complete

Write-Host "=== Claude Code Power-Up Verification ===" -ForegroundColor Cyan
Write-Host ""

# 1. Check Node.js
Write-Host "1. Node.js Installation:" -ForegroundColor Yellow
$nodePath = "C:\Program Files\nodejs\node.exe"
if (Test-Path $nodePath) {
    $nodeVersion = & $nodePath --version
    Write-Host "   [OK] Node.js found: $nodeVersion" -ForegroundColor Green

    # Check if in PATH
    $envPath = $env:PATH -split ";"
    if ($envPath -contains "C:\Program Files\nodejs") {
        Write-Host "   [OK] Node.js is in PATH" -ForegroundColor Green
    } else {
        Write-Host "   [WARN] Node.js NOT in PATH - MCP servers may fail" -ForegroundColor Yellow
        Write-Host "   FIX: Add 'C:\Program Files\nodejs' to your PATH environment variable" -ForegroundColor Yellow
    }
} else {
    Write-Host "   [ERROR] Node.js not found" -ForegroundColor Red
}
Write-Host ""

# 2. Check Agents
Write-Host "2. Agents:" -ForegroundColor Yellow
$agentsPath = "$env:USERPROFILE\.claude\agents"
if (Test-Path $agentsPath) {
    $agentCount = (Get-ChildItem -Path $agentsPath -Recurse -Filter "*.md" | Measure-Object).Count
    Write-Host "   [OK] $agentCount agents installed" -ForegroundColor Green

    # List categories
    $categories = Get-ChildItem -Path $agentsPath -Directory
    Write-Host "   Categories: $($categories.Count)" -ForegroundColor Cyan
    foreach ($cat in $categories) {
        $count = (Get-ChildItem -Path $cat.FullName -Filter "*.md" | Measure-Object).Count
        Write-Host "     - $($cat.Name): $count agents" -ForegroundColor White
    }
} else {
    Write-Host "   [ERROR] Agents directory not found" -ForegroundColor Red
}
Write-Host ""

# 3. Check Commands
Write-Host "3. Slash Commands:" -ForegroundColor Yellow
$commandsPath = "$env:USERPROFILE\.claude\commands"
if (Test-Path $commandsPath) {
    $commandCount = (Get-ChildItem -Path $commandsPath -Recurse -Filter "*.md" | Measure-Object).Count
    Write-Host "   [OK] $commandCount commands installed" -ForegroundColor Green
} else {
    Write-Host "   [ERROR] Commands directory not found" -ForegroundColor Red
}
Write-Host ""

# 4. Check MCP Config
Write-Host "4. MCP Servers:" -ForegroundColor Yellow
$mcpPath = "$env:USERPROFILE\.claude.json"
if (Test-Path $mcpPath) {
    $mcpConfig = Get-Content $mcpPath | ConvertFrom-Json
    if ($mcpConfig.mcpServers) {
        $serverCount = ($mcpConfig.mcpServers.PSObject.Properties | Measure-Object).Count
        Write-Host "   [OK] $serverCount MCP servers configured" -ForegroundColor Green
        foreach ($server in $mcpConfig.mcpServers.PSObject.Properties) {
            Write-Host "     - $($server.Name)" -ForegroundColor White
        }
    }
} else {
    Write-Host "   [ERROR] MCP config not found" -ForegroundColor Red
}
Write-Host ""

# 5. Check Settings
Write-Host "5. Settings:" -ForegroundColor Yellow
$settingsPath = "$env:USERPROFILE\.claude\settings.json"
if (Test-Path $settingsPath) {
    Write-Host "   [OK] settings.json found" -ForegroundColor Green
} else {
    Write-Host "   [WARN] settings.json not found" -ForegroundColor Yellow
}
Write-Host ""

# 6. Check CLAUDE.md
Write-Host "6. Memory (CLAUDE.md):" -ForegroundColor Yellow
$claudeMdPath = "$env:USERPROFILE\.claude\CLAUDE.md"
if (Test-Path $claudeMdPath) {
    $lineCount = (Get-Content $claudeMdPath | Measure-Object -Line).Lines
    Write-Host "   [OK] CLAUDE.md found ($lineCount lines)" -ForegroundColor Green
} else {
    Write-Host "   [WARN] CLAUDE.md not found" -ForegroundColor Yellow
}
Write-Host ""

# 7. Check Hooks
Write-Host "7. Hooks:" -ForegroundColor Yellow
$hooksPath = "$env:USERPROFILE\.claude\hooks"
if (Test-Path $hooksPath) {
    $hookCount = (Get-ChildItem -Path $hooksPath -Filter "*.sh" | Measure-Object).Count
    Write-Host "   [OK] $hookCount hook scripts found" -ForegroundColor Green
    Write-Host "   [NOTE] Hooks are .sh files - require Git Bash or WSL on Windows" -ForegroundColor Yellow
} else {
    Write-Host "   [WARN] Hooks directory not found" -ForegroundColor Yellow
}
Write-Host ""

# Summary
Write-Host "=== Summary ===" -ForegroundColor Cyan
Write-Host "Restart Claude Code to activate all changes." -ForegroundColor White
Write-Host "Verify with: /mcp (check MCP servers)" -ForegroundColor White
Write-Host "           : /help (see available commands)" -ForegroundColor White
