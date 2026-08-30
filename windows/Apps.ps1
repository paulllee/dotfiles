$DesiredApps = @(
    "main/7zip",
    "main/git",
    "extras/discord",
    "extras/logitech-omm",
    "games/steam",
    "games/osulazer"
)

function Get-InstalledApps {
    return scoop list | ForEach-Object { $_.Name }
}

function Sync-Apps {
    $InstalledApps = Get-InstalledApps
    $DesiredAppNames = $DesiredApps | ForEach-Object { ($_ -split "/", 2)[-1] }

    $InstalledApps `
        | ForEach-Object { scoop update $_ }

    $DesiredApps `
        | Where-Object { ($_ -split "/", 2)[-1] -notin $InstalledApps } `
        | ForEach-Object { scoop install $_ }

    $InstalledApps `
        | Where-Object { $_ -notin $DesiredAppNames } `
        | ForEach-Object { scoop uninstall $_ }
}
