IGNORE=".DS_Store|.git|__pycache__"

function auto-keygen() {  # auto-(ssh-)keygen
    KEYGEN_PATH="${1:-$HOME/.ssh/id_rsa}"
    ssh-keygen -t ed25519 -N "" -f "$KEYGEN_PATH"
}

function ll() {  # l(s)-l(ong)
    TARGET="${1:-.}"
    eza "$TARGET" -la --ignore-glob="$IGNORE" --icons=auto --git --git-repos
}

function qcd() {  # q(uick)-cd
    BASE="${1:-$HOME}"
    cd "$(fd --hidden --type d . "$BASE" | fzf --ansi --border --preview "tree -a -I '$IGNORE' -C {}")"
    clear
}

function saa() {  # s(ync)-a(ll)-a(pplications)
    DEST="$HOME/.dotfiles/dotfiles/.config/"

    # iterm2
    cp "$HOME/.config/iterm2/com.googlecode.iterm2.plist" "$DEST/iterm2/"

    SWISH="$(osascript -e 'id of app "Swish"')"
    defaults export "$SWISH" "$DEST/swish/$SWISH.plist"

    MACMOUSEFIX="$(osascript -e 'id of app "Mac Mouse Fix"')"
    defaults export "$MACMOUSEFIX" "$DEST/macmousefix/$MACMOUSEFIX.plist"
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
