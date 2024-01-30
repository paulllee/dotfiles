# https://github.com/junegunn/fzf
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# https://github.com/zsh-users/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# must be sourced LAST
# https://github.com/zsh-users/zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure
