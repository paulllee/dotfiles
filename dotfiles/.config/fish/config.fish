fish_add_path "$HOME/.local/bin"

alias lg="lazygit"

function qcd
  cd "$(fd --hidden --exclude '.git' --type d . | fzf)"
  clear
end

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

eval "$(/opt/homebrew/bin/brew shellenv)"
starship init fish | source
