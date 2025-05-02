fish_add_path "$HOME/.local/bin"

alias lg="lazygit"

function qcd
  cd "$(fd --hidden --maxdepth 3 --exclude '.git' --type d ~ | fzf)"
  clear
end

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
--color=selected-bg:#bcc0cc \
--color=border:#ccd0da,label:#4c4f69"

eval "$(/opt/homebrew/bin/brew shellenv)"
starship init fish | source
