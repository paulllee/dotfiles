ZSH_ORDER=(  # order of execution
  "paths"
  "variables"
  "packages"
  "options"
  "aliases"
  "functions"
)

for ZSH in "${ZSH_ORDER[@]}"; do
  source "$HOME/.zsh/$ZSH.zsh"
done
