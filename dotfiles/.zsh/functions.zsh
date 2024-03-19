function ll() {  # [l]s -[l]
  eza "${1:-.}" -l --icons=auto --git --git-repos
}

function la() {  # ls -[la]
  eza "${1:-.}" -la --icons=auto --git --git-repos
}

function qcd() {  # [q]uick [cd]
  cd "$(fd --hidden --type d . "${1:-$HOME}" | fzf)"
  clear
}
