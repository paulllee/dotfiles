fish_add_path "$HOME/.local/bin"

alias lg="lazygit"

function qcd
  cd "$(fd --hidden --maxdepth 3 --exclude '.git' --type d . ~ | fzf)"
  clear
end

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

eval "$(/opt/homebrew/bin/brew shellenv)"
starship init fish | source
