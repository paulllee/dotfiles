$DesiredBuckets = @(
    "main",
    "extras",
    "nerd-fonts",
    "psmux https://github.com/marlocarlo/scoop-psmux"
)

function Get-AddedBuckets {
    return scoop bucket list | ForEach-Object { $_.Name }
}

function Sync-Buckets {
    $AddedBuckets = Get-AddedBuckets

    $DesiredBuckets `
        | Where-Object { $_ -notin $AddedBuckets } `
        | ForEach-Object { scoop bucket add $_ }

    $AddedBuckets `
        | Where-Object { $_ -notin $DesiredBuckets } `
        | ForEach-Object { scoop bucket rm $_ }
}
