# ensure ~/.config is default across all applications
export XDG_CONFIG_HOME="$HOME/.config"

# https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

# default to nvim
export EDITOR=nvim
export VISUAL="$EDITOR"

# catppuccin-mocha theme for fzf
export FZF_DEFAULT_OPTS="--color=\
    bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,\
    fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,\
    marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

