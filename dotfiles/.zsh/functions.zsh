function ll() {  # [l]s -[l]
  eza "${1:-.}" -l --icons=auto --git --git-repos --git-ignore
}

function la() {  # ls -[la]
  eza "${1:-.}" -la --icons=auto --git --git-repos --git-ignore
}

function qcd() {  # [q]uick [cd]
  cd "$(fd --hidden --type d . "${1:-$HOME}" | 
    fzf --preview "tree --gitfile="$HOME/.config/fd/ignore" -a -C {}")"
  clear
}

function sfa() {  # [s]ync [f]rom [a]pplications
  DEST="$HOME/.dotfiles/dotfiles/.config/"

  ITERM2="$(osascript -e 'id of app "iTerm2"')"
  cp "$HOME/.config/iterm2/$ITERM2.plist" "$DEST/iterm2/"

  MACMOUSEFIX="$(osascript -e 'id of app "Mac Mouse Fix"')"
  cp "$HOME/Library/Application Support/$MACMOUSEFIX/config.plist" "$DEST/macmousefix/"

  SWISH="$(osascript -e 'id of app "Swish"')"
  defaults export "$SWISH" "$DEST/swish/$SWISH.plist"
}

function mma() {  # [m]icro[m]amba [a]ctivate
  micromamba activate "${1:-base}"
}

function mmc() {  # [m]icro[m]amba [c]reate
  micromamba create -f "$HOME/.config/micromamba/specs/$1.yml"
}

function mmlsp() {  # [m]icro[m]amba [lsp]
  micromamba create -n lsp python=3.12 nodejs=20.9.0
  
  function mmpip() { micromamba run -n lsp pip install "$@" }
  function mmnpm() { micromamba run -n lsp npm install i -g "$@" }
  
  # python
  mmpip ruff
  mmpip ruff-lsp
  mmnpm pyright

  # bash
  mmnpm bash-language-server

  # html/css/js
  mmnpm vscode-langservers-extracted
}

# function vc() {  # [v]s [c]ode
#   code "${1:-.}" --user-data-dir "$HOME/.config/vscode/"
# }
