$DesiredApps = @(
    "7zip",
    "claude-code",
    "discord",
    "fd",
    "fzf",
    "gcc",
    "git",
    "heidisql",
    "jetbrains-mono",
    "klogg",
    "lazygit",
    "mongodb",
    "neovim",
    "nodejs",
    "obsidian",
    "postman",
    "rider",
    "ripgrep",
    "screentogif",
    "starship",
    "steam",
    "tailscale",
    "uv",
    "wezterm",
    "windirstat"
)

function Get-InstalledApps {
    return scoop list | ForEach-Object { $_.Name }
}

function Sync-Apps {
    $InstalledApps = Get-InstalledApps

    $InstalledApps `
        | ForEach-Object { scoop update $_ }

    $DesiredApps `
        | Where-Object { $_ -notin $InstalledApps } `
        | ForEach-Object { scoop install $_ }

    $InstalledApps `
        | Where-Object { $_ -notin $DesiredApps } `
        | ForEach-Object { scoop uninstall $_ }
}
