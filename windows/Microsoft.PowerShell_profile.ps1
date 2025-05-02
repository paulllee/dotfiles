Set-Alias -Name lg -Value lazygit

# [q]uick [cd]
function qcd {
    cd "$(fd --hidden --maxdepth 3 --exclude '.git' --type d ~ | fzf)"
}

# [w]eekly [n]ote
function wn {
    $Today = (Get-Date).Date
    $Mon = $Today.AddDays(1 - $Today.DayOfWeek.value__).ToString("yyyy-MM-dd")
    $NotePath = "~/stuff/weekly/W$Mon.md"
    if (!(Test-Path -Path $NotePath)) {
        Set-Content -Path $NotePath -Value " weekly picture"
    }
    & $Env:EDITOR $NotePath
}

$Env:EDITOR = "nvim"

$Env:FZF_DEFAULT_OPTS=@"
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78
--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39
--color=selected-bg:#bcc0cc
--color=border:#ccd0da,label:#4c4f69
"@

Invoke-Expression (&starship init powershell)
