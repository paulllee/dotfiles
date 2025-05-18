. "$PSScriptRoot\Apps.ps1"
. "$PSScriptRoot\Buckets.ps1"

# git needed prior to adding buckets
scoop install git

# get buckets that is currently added
$Added = scoop bucket list | ForEach-Object { ($_ -split ' ')[0] }

# uninstall buckets that aren't in the list
$Added `
    | Where-Object { $_ -notin $Buckets } `
    | ForEach-Object { scoop bucket rm $_ }

# install missing buckets
$Buckets `
    | Where-Object { $_ -notin $Added } `
    | ForEach-Object { scoop bucket add $_ }

# get packages that are currently installed
$Installed = scoop list | ForEach-Object { ($_ -split ' ')[0] }

# uninstall apps that aren't in the list
$Installed `
    | Where-Object { $_ -notin $Apps } `
    | ForEach-Object { scoop uninstall $_ }

# install missing apps
$Apps `
    | Where-Object { $_ -notin $Installed } `
    | ForEach-Object { scoop install $_ }

# Update installed apps
$Installed `
    | ForEach-Object { scoop update $_ }
