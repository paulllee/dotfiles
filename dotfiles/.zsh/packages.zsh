source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

eval "$(micromamba shell hook --shell zsh)"
eval "$(starship init zsh)"
