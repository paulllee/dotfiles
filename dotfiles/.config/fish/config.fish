fish_add_path "$HOME/.local/bin"

alias lg="lazygit"

function qcd
  cd "$(fd --hidden --maxdepth 3 --exclude '.git' --type d . ~ | fzf)"
  clear
end

set -gx EDITOR nvim
set -gx VISUAL "$EDITOR"

# gruvbox
set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#3C3836,bg:-1,spinner:#FABD2F,hl:#FE8019 \
--color=fg:#EBDBB2,header:#83A598,info:#D3869B,pointer:#FABD2F \
--color=marker:#B8BB26,fg+:#FBF1C7,prompt:#83A598,hl+:#FE8019 \
--color=selected-bg:#504945 \
--color=border:#504945,label:#EBDBB2"

# catppuccin
# --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
# --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
# --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
# --color=selected-bg:#45475A \
# --color=border:#313244,label:#CDD6F4

eval "$(/opt/homebrew/bin/brew shellenv)"
starship init fish | source
