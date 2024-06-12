fish_add_path "$HOME/.local/bin"

alias lg="lazygit"

function qcd
  cd "$(fd --hidden --exclude '.git' --type d . | fzf)"
  clear
end

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

eval "$(/opt/homebrew/bin/brew shellenv)"
starship init fish | source
