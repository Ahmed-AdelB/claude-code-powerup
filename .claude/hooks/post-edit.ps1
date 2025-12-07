# Post-edit hook for Windows (PowerShell)
# Auto-formats files after editing

param(
    [string]$FilePath
)

if (-not $FilePath) {
    exit 0
}

Write-Host "Running post-edit formatting on $FilePath..." -ForegroundColor Cyan

$extension = [System.IO.Path]::GetExtension($FilePath)

switch ($extension) {
    { $_ -in ".ts", ".tsx", ".js", ".jsx", ".json", ".css", ".scss" } {
        if (Get-Command npx -ErrorAction SilentlyContinue) {
            npx prettier --write $FilePath 2>$null
            Write-Host "[OK] Formatted with Prettier" -ForegroundColor Green
        }
    }
    ".py" {
        if (Get-Command black -ErrorAction SilentlyContinue) {
            black $FilePath 2>$null
            Write-Host "[OK] Formatted with Black" -ForegroundColor Green
        }
    }
    ".go" {
        if (Get-Command gofmt -ErrorAction SilentlyContinue) {
            gofmt -w $FilePath
            Write-Host "[OK] Formatted with gofmt" -ForegroundColor Green
        }
    }
}

exit 0
