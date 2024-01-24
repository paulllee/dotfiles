# auto-(ssh-)keygen - non-interactive ssh-keygen with best practice
#                     it will overwrite your ~/.ssh/id_rsa key
alias auto-keygen='yes "y" | ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_rsa'

# ls and lsg(ithub) - uses eza for a modern replacement for ls
alias ls='eza -la --icons'
alias lsg='eza -la --icons --git --git-repos'

# q(uick) cd - uses fuzzy search to change directories
alias qcd='cd $(fd . ~ --type d -E ".git" | fzf)'

# upgrade-all (packages) - upgrades everything that was installed through brew, cask, and mas
alias upgrade-all='brew upgrade && brew upgrade --cask && mas upgrade'

# powerlevel10k - prompt theme
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme && \
    [[ -f ~/.local/plugins/p10k.zsh ]] && \
    source ~/.local/plugins/p10k.zsh

# fzf - fuzzy search
[[ -f ~/.local/plugins/fzf.zsh ]] && \
    source ~/.local/plugins/fzf.zsh

# zsh-autosuggestions - auto suggestions based on previous zsh history
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting - in line shell syntax highlighting for zsh
#                           NOTE: THIS MUST BE SOURCED LAST
# https://github.com/zsh-users/zsh-syntax-highlighting/tree/master?tab=readme-ov-file#faq
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
