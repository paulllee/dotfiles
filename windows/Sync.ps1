. "$PSScriptRoot\Apps.ps1"
. "$PSScriptRoot\Buckets.ps1"

# git is needed prior to adding buckets
$InstalledApps = Get-InstalledApps
if ("git" -notin $InstalledApps) {
    scoop install git
}

Sync-Buckets
Sync-Apps

scoop cleanup -a