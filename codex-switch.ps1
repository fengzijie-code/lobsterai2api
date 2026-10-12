# codex-switch.ps1 -- 切换 Codex 默认供应商（CLI 与 Desktop 共用 ~/.codex/config.toml）
# 用法: .\codex-switch.ps1 lobsterai | shanyi
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("lobsterai", "shanyi")]
    [string]$Target
)

$cfg = Join-Path $env:USERPROFILE ".codex\config.toml"

$map = @{
    lobsterai = @{ provider = "lobsterai";         model = "kimi-k2.7-code" }
    shanyi    = @{ provider = "codex_local_access"; model = "gpt-5.6-sol" }
}
$newProv = $map[$Target].provider
$newModel = $map[$Target].model

$ErrorActionPreference = 'Stop'

if (-not (Test-Path $cfg)) { Write-Error "config not found: $cfg"; exit 1 }

$lines = Get-Content $cfg
$provDone = $false; $modelDone = $false
$out = foreach ($l in $lines) {
    if (-not $provDone -and $l -match '^model_provider\s*=') {
        $provDone = $true; "model_provider = `"$newProv`""
    }
    elseif (-not $modelDone -and $l -match '^model\s*=') {
        $modelDone = $true; "model = `"$newModel`""
    }
    else { $l }
}
if (-not $provDone -or -not $modelDone) {
    Write-Error "top-level model/model_provider not found -- nothing changed"
    exit 1
}

# 备份后原子写回（PowerShell 5.1 无 utf8NoBOM，用 .NET 直接写，无 BOM）
Copy-Item $cfg "$cfg.bak-switch" -Force
[System.IO.File]::WriteAllLines($cfg, [string[]]$out, (New-Object System.Text.UTF8Encoding($false)))
Write-Host "switched to $newProv / $newModel"
Write-Host "Codex Desktop 需重启生效; CLI 直接生效"
