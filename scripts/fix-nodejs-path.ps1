# Fix Node.js PATH - Run as Administrator

Write-Host "Adding Node.js to System PATH..." -ForegroundColor Cyan

$nodePath = "C:\Program Files\nodejs"

# Get current PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

if ($currentPath -notlike "*$nodePath*") {
    # Add Node.js to PATH
    $newPath = "$currentPath;$nodePath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Host "[OK] Node.js added to System PATH" -ForegroundColor Green
    Write-Host "Please restart your terminal for changes to take effect." -ForegroundColor Yellow
} else {
    Write-Host "[OK] Node.js already in PATH" -ForegroundColor Green
}

# Verify
Write-Host ""
Write-Host "Verification:" -ForegroundColor Cyan
& "$nodePath\node.exe" --version
& "$nodePath\npm.cmd" --version
