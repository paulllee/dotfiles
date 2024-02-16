function auto-keygen() {  # auto-(ssh-)keygen
  KEYGEN_PATH="${1:-$HOME/.ssh/id_rsa}"
  ssh-keygen -t ed25519 -N "" -f "$KEYGEN_PATH"
}

function ll() {  # (ls -)l
  TARGET="${1:-.}"
  eza "$TARGET" -l --icons=auto --git --git-repos --git-ignore
}

function la() {  # (ls -)la
  TARGET="${1:-.}"
  eza "$TARGET" -la --icons=auto --git --git-repos --git-ignore
}

function qcd() {  # q(uick)-cd
  BASE="${1:-$HOME}"
  IGNORE="$HOME/.config/fd/ignore"
  cd "$(fd --hidden --type d . "$BASE" | fzf --preview "tree --gitfile="$IGNORE" -a -C {}")"
  clear
}

function sfa() {  # s(ync)-f(rom)-app(lications)
  DEST="$HOME/.dotfiles/dotfiles/.config/"

  ITERM2="$(osascript -e 'id of app "iTerm2"')"
  cp "$HOME/.config/iterm2/$ITERM2.plist" "$DEST/iterm2/"

  MACMOUSEFIX="$(osascript -e 'id of app "Mac Mouse Fix"')"
  cp "$HOME/Library/Application Support/$MACMOUSEFIX/config.plist" "$DEST/macmousefix/"

  SWISH="$(osascript -e 'id of app "Swish"')"
  defaults export "$SWISH" "$DEST/swish/$SWISH.plist"
}

function c() {  # c(ode)
  PROJECT="${1:-.}"
  code "$PROJECT" --user-data-dir "$HOME/.config/vscode/"
}

function mma() {  # m(icro)m(amba)-a(ctivate)
  ENV="${1:-base}"
  micromamba activate "$ENV"
}

function mmc() {  # m(icro)m(amba)-c(reate)
  SPEC="${1:-}"
  micromamba create -f "$HOME/.config/micromamba/specs/$SPEC.yml"
}
