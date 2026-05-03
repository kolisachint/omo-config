# OMO Config — One-Command Installer (PowerShell)
# Supports: irm | iex, git clone, or manual run

$ErrorActionPreference = "Stop"

$RepoUrl    = "https://github.com/kolisachint/omo-config.git"
$InstallDir = if ($env:OMO_INSTALL_DIR) { $env:OMO_INSTALL_DIR } else { "$env:USERPROFILE\.config\omo-config" }
$ConfigDir  = "$env:USERPROFILE\.config\opencode"
$DefaultProfile = if ($args[0]) { $args[0] } else { "codex-daily" }

function Info  ($msg) { Write-Host "ℹ $msg" -ForegroundColor Cyan }
function Ok    ($msg) { Write-Host "✅ $msg" -ForegroundColor Green }
function Warn  ($msg) { Write-Host "⚠ $msg" -ForegroundColor Yellow }
function Err   ($msg) { Write-Host "❌ $msg" -ForegroundColor Red }

# Detect if running from a cloned repo
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$RepoFiles = @("profiles", "bin", "scripts")
$FromClone = $RepoFiles | ForEach-Object { Test-Path (Join-Path $ScriptDir $_) } | Where-Object { $_ } | Measure-Object | ForEach-Object { $_.Count -eq 3 }

if ($FromClone) {
    $RepoRoot = $ScriptDir
} else {
    $RepoRoot = $InstallDir
}

function Ensure-Dir ($dir) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Info "Created: $dir"
    }
}

function Clone-Repo {
    if (Test-Path "$RepoRoot\.git") {
        Info "Repo already exists at $RepoRoot"
        Push-Location $RepoRoot
        try {
            git pull origin main 2>$null | Out-Null
        } catch {
            Warn "Could not pull updates"
        } finally {
            Pop-Location
        }
    } else {
        Info "Cloning $RepoUrl → $RepoRoot"
        git clone --depth 1 $RepoUrl $RepoRoot | Out-Null
        Ok "Cloned successfully"
    }
}

function Backup-IfExists ($file) {
    if (Test-Path $file) {
        $ts = Get-Date -Format "yyyyMMdd-HHmmss"
        $backup = "$file.backup-$ts"
        Copy-Item $file $backup
        Ok "Backup created: $backup"
    }
}

function Install-Profile ($profile) {
    $profileFile = "$RepoRoot\profiles\$profile.json"
    if (!(Test-Path $profileFile)) {
        Err "Profile not found: $profileFile"
        Err "Run 'node $RepoRoot\bin\omo list' to see available profiles."
        exit 1
    }
    Ensure-Dir $ConfigDir
    Backup-IfExists "$ConfigDir\oh-my-openagent.json"
    Copy-Item $profileFile "$ConfigDir\oh-my-openagent.json"
    Ok "Installed profile: $profile"
}

function Install-Bin {
    $binSrc = "$RepoRoot\bin\omo"
    if (!(Test-Path $binSrc)) {
        Warn "omo binary not found at $binSrc"
        return
    }

    # Check if already in PATH
    $existing = Get-Command omo -ErrorAction SilentlyContinue
    if ($existing) {
        Ok "omo is already in PATH: $($existing.Source)"
        return
    }

    # Create wrapper scripts
    $binDir = "$env:USERPROFILE\bin"
    Ensure-Dir $binDir

    # PowerShell wrapper
    $psWrapper = @"
# Auto-generated OMO wrapper
`$script = "$binSrc"
node `$script `@args
"@
    Set-Content -Path "$binDir\omo.ps1" -Value $psWrapper -Encoding UTF8

    # CMD wrapper
    $cmdWrapper = @"
@node "$binSrc" %*
"@
    Set-Content -Path "$binDir\omo.cmd" -Value $cmdWrapper -Encoding ASCII

    Ok "Created wrappers: $binDir\omo.cmd and $binDir\omo.ps1"

    # Add to PATH if not present
    $pathDirs = ($env:PATH -split ';') | ForEach-Object { $_.Trim().TrimEnd('\') } | Where-Object { $_ }
    if ($pathDirs -notcontains $binDir) {
        [Environment]::SetEnvironmentVariable("Path", "$env:PATH;$binDir", "User")
        $env:Path += ";$binDir"
        Warn "Added $binDir to your User PATH. Restart your terminal to use 'omo' directly."
    }
}

function Main {
    Write-Host "`n🔧 OMO Config Installer (PowerShell)`n" -ForegroundColor Cyan

    if (!$FromClone) {
        Clone-Repo
    }

    Install-Profile $DefaultProfile
    Install-Bin

    Write-Host "`n🎉 Installation complete!`n" -ForegroundColor Green
    Write-Host "   Config:   $ConfigDir\oh-my-openagent.json"
    Write-Host "   Profile:  $DefaultProfile"
    Write-Host "   Repo:     $RepoRoot`n"
    Write-Host "Next steps:"
    Write-Host "  omo list              - List all profiles"
    Write-Host "  omo <profile>         - Switch profile"
    Write-Host "  omo status            - Check current profile"
    Write-Host "  omo compare           - Compare providers`n"
}

Main
