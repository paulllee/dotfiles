# https://github.com/junegunn/fzf
source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

# https://github.com/zsh-users/zsh-autosuggestions
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# https://github.com/zsh-users/zsh-syntax-highlighting - must be sourced LAST
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure

# single line pure prompt
# https://github.com/sindresorhus/pure/issues/228#issuecomment-299425799
prompt_newline='%666v'
PROMPT=" $PROMPT"

