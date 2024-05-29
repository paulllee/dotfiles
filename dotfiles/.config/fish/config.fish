# PATHS

fish_add_path "$HOME/.local/bin"

# ALIASES

alias lg="lazygit"

# FUNCTIONS

function qcd
  cd "$(ff $argv)"
  clear
end

# VARIABLES

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

# PACKAGES

eval "$(/opt/homebrew/bin/brew shellenv)"
starship init fish | source
