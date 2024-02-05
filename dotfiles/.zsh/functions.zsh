IGNORE=".DS_Store|.git"

# auto-(ssh-)keygen - non-interactive ssh-keygen with best practice (defaults to $HOME/.ssh/id_rsa)
function auto-keygen() {
  KEYGEN_PATH="${1:-$HOME/.ssh/id_rsa}"
  ssh-keygen -t ed25519 -N "" -f $KEYGEN_PATH
}

# ls - uses eza for a modern replacement for ls
function ls() {
  eza -la --ignore-glob=$IGNORE --icons=auto --git --git-repos
}

# q(uick) cd - uses fuzzy search to change directories from any directory (defaults to $HOME)
function qcd() {
  BASE="${1:-$HOME}"
  cd $(fd --hidden --type d . $BASE | fzf --ansi --border --preview "tree -a -I '$IGNORE' -C {}")
  clear
}

