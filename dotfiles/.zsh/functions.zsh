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

function cdp() {  # cd-p(arent)
    cd ..
}

function cdu() {  # cd-u(ndo)
    cd -
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

function rf() {  # r(ipgrep)-f(zf)
    TARGET="${1:-.}"
    MATCH="$(rg --line-number --smart-case --hidden --glob="!.git" . $TARGET | fzf --delimiter=: --ansi --border --preview "fbp {1} {2}")"
    FILE="$(printf "$MATCH" | cut -d : -f 1)"
    LINENUM="$(printf "$MATCH" | cut -d : -f 2)"
    printf "$FILE:$LINENUM\n"
}
