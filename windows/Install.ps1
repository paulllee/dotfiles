. "$PSScriptRoot\Apps.ps1"

# git needed prior to adding buckets
scoop install git

scoop bucket add extras
scoop bucket add nerd-fonts

foreach ($App in $Apps)
{
    scoop install $App
}
