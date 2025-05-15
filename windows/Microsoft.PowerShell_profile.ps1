Set-Alias -Name lg -Value lazygit

# [q]uick [cd]
function qcd {
    cd "$(fd --hidden --maxdepth 3 --exclude '.git' --type d ~ | fzf)"
}

# [t]oday [n]ote
function tn {
    $TodayNote = "~/stuff/$((Get-Date).Year).md"
    if (!(Test-Path -Path $TodayNote)) {
        New-Item -Path $TodayNote -ItemType File
    }
    & $Env:EDITOR $TodayNote
}

# [i]n[b]ox
function ib {
    $Inbox = "~/stuff/inbox.md"
    if (!(Test-Path -Path $Inbox)) {
        New-Item -Path $Inbox -ItemType File
    }
    & $Env:EDITOR $Inbox
}

$Env:EDITOR = "nvim"

$Env:FZF_DEFAULT_OPTS=@"
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8
--color=selected-bg:#45475A
--color=border:#313244,label:#CDD6F4
"@

Invoke-Expression (&starship init powershell)
