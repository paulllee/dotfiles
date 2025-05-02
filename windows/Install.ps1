. "$PSScriptRoot\Apps.ps1"

scoop bucket add extras
scoop bucket add nerd-fonts

foreach ($App in $Apps)
{
    scoop install $App
}
