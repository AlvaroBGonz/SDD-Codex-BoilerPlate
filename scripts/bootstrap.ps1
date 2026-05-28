Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Write-Host "======================================"
Write-Host "      SDD Framework Bootstrap"
Write-Host "======================================"
Write-Host ""

if (-not (Test-Path ".codex" -PathType Container)) {
    Write-Error "ERROR: .codex/ directory not found. You must run this script from the repository root."
}

if (-not (Test-Path ".codex/commands" -PathType Container)) {
    Write-Error "ERROR: .codex/commands directory not found. This repo may be incomplete."
}

Write-Host "OK: Repository root detected."
Write-Host ""

$opsxDir = ".codex/commands/opsx"
$aiSpecsDir = ".codex/commands/ai-specs"

if (-not (Test-Path $opsxDir -PathType Container)) {
    Write-Error "ERROR: Missing $opsxDir"
}

if (-not (Test-Path $aiSpecsDir -PathType Container)) {
    Write-Error "ERROR: Missing $aiSpecsDir"
}

$opsxCount = @(Get-ChildItem $opsxDir -Filter "*.md" -File).Count
$aiSpecsCount = @(Get-ChildItem $aiSpecsDir -Filter "*.md" -File).Count

if ($opsxCount -eq 0) {
    Write-Error "ERROR: No opsx command files found."
}

if ($aiSpecsCount -eq 0) {
    Write-Error "ERROR: No ai-specs command files found."
}

Write-Host "OK: opsx commands detected: $opsxCount"
Write-Host "OK: ai-specs commands detected: $aiSpecsCount"
Write-Host ""

Write-Host "Checking OpenSpec CLI..."

$openspec = Get-Command openspec -ErrorAction SilentlyContinue
if ($null -ne $openspec) {
    $version = (& openspec --version 2>$null)
    if ([string]::IsNullOrWhiteSpace($version)) {
        $version = "version unknown"
    }
    Write-Host "OK: OpenSpec CLI detected: $version"
} else {
    Write-Host "WARNING: OpenSpec CLI is NOT installed."
    Write-Host ""
    Write-Host "Install it using your preferred method:"
    Write-Host "  npm install -g @fission-ai/openspec@latest"
    Write-Host "  or"
    Write-Host "  pnpm add -g @fission-ai/openspec@latest"
}

Write-Host ""
Write-Host "Verifying repository integrity..."

if (-not (Test-Path "openspec" -PathType Container)) {
    Write-Host "WARNING: openspec/ directory not found. This template should include it."
}

if (Test-Path ".codex/commands/default" -PathType Container) {
    Write-Host ""
    Write-Host "WARNING: It looks like default OpenSpec commands may have been generated."
    Write-Host "If someone ran 'openspec init', custom commands might be overwritten."
    Write-Host ""
    Write-Host "DO NOT run 'openspec init' in this repository."
}

Write-Host "OK: Repository structure looks correct."
Write-Host ""
Write-Host "Next Steps:"
Write-Host ""
Write-Host "1) Open this folder in Codex."
Write-Host "2) Type '/' in Codex to verify commands are detected."
Write-Host ""
Write-Host "IMPORTANT:"
Write-Host "This repository is already initialized."
Write-Host "DO NOT run: openspec init"
Write-Host ""
Write-Host "Bootstrap completed successfully."
Write-Host "======================================"
