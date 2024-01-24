# powerlevel10k prompt theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.local/plugins/p10k.zsh ]] || source ~/.local/plugins/p10k.zsh

# common aliases
alias dsf="dotsync -f"

alias auto-keygen="yes 'y' | ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_rsa"

alias ls="eza -la --icons"
alias lsg="eza -la --icons --git --git-repos"

alias g="git"
alias gb="git branch"
alias gc="git checkout"
alias ga="git add"
alias gcm="git commit -m"
alias gs="git status"
