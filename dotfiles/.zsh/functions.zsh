function ll() {  # [l]s -[l]
  eza "${1:-.}" -l --icons=auto --git --git-repos --git-ignore
}

function la() {  # ls -[la]
  eza "${1:-.}" -la --icons=auto --git --git-repos --git-ignore
}

function qcd() {  # [q]uick [cd]
  cd "$(fd --hidden --type d . "${1:-$HOME}" | fzf)"
  clear
}

function vsc() {  # [v]isual [s]tudio [c]ode
  code "${1:-.}" --user-data-dir "$HOME/.config/vscode/"
}
