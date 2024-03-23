# PATHS

fish_add_path "$HOME/.local/bin"

# ALIASES

alias lg="lazygit"
alias mm="micromamba"

# FUNCTIONS

function qcd
  cd "$(ff $argv)"
  clear
end

# VARIABLES

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

set -gx FZF_DEFAULT_OPTS "--border=rounded \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -gx MAMBA_ROOT_PREFIX "$HOME/.micromamba"
set -gx MAMBARC "$HOME/.config/micromamba/.mambarc"

# PACKAGES

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(micromamba shell hook -s fish)"
starship init fish | source
