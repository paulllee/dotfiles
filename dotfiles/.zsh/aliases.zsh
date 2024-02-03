# auto-(ssh-)keygen - non-interactive ssh-keygen with best practice
#                     it will overwrite your ~/.ssh/id_rsa key
alias auto-keygen='yes "y" | ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_rsa'

# ls and lsg(ithub) - uses eza for a modern replacement for ls
alias ls='eza -la --ignore-glob ".DS_Store"'
alias lsg='ls --git --git-repos'

# q(uick) cd - uses fuzzy search from home to change directories
alias qcd='cd $(fd --hidden --type d . ~ | fzf)'

