alias auto-keygen="yes 'y' | ssh-keygen -t ed25519 -N '' -f ~/.ssh/id_rsa"

alias ls="eza -la --icons"
alias lsg="eza -la --icons --git --git-repos"

alias fzfd="fd . ~ --type d -E '.git' | fzf"

alias upgrade-all="brew upgrade && brew upgrade --cask && mas upgrade"

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme && \
    [[ -f ~/.local/plugins/p10k.zsh ]] && \
    source ~/.local/plugins/p10k.zsh

[[ -f ~/.local/plugins/fzf.zsh ]] && \
    source ~/.local/plugins/fzf.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
