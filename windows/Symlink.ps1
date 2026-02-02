$RepoRoot = Split-Path -Parent $PSScriptRoot

$Symlinks = @{
    "dotfiles\.config\nvim\init.lua"       = "$env:LOCALAPPDATA\nvim\init.lua"
    "dotfiles\.config\nvim\.luarc.json"    = "$env:LOCALAPPDATA\nvim\.luarc.json"
    "dotfiles\.config\lazygit\config.yml"  = "$env:APPDATA\lazygit\config.yml"
    "dotfiles\.config\wezterm\wezterm.lua" = "$HOME\.wezterm.lua"
    "dotfiles\.claude\settings.json"       = "$HOME\.claude\settings.json"
    "windows\.ideavimrc"                       = "$HOME\.ideavimrc"
    "windows\Microsoft.PowerShell_profile.ps1" = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
}

foreach ($Source in $Symlinks.Keys) {
    $SourcePath = Join-Path $RepoRoot $Source
    $DestPath = $Symlinks[$Source]

    if (-not (Test-Path $SourcePath)) {
        Write-Host "$Source not found"
        continue
    }

    $DestDir = Split-Path -Parent $DestPath
    if (-not (Test-Path $DestDir)) {
        New-Item -ItemType Directory -Path $DestDir -Force
    }

    if (Test-Path $DestPath) {
        Remove-Item $DestPath -Force
    }

    try {
        New-Item -ItemType SymbolicLink -Path $DestPath -Target $SourcePath -Force
        Write-Host "Linked: $DestPath"
    }
    catch {
        Write-Error "Failed to create symlink at $DestPath"
    }
}
