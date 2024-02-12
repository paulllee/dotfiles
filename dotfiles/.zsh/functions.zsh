IGNORE=".DS_Store|.git|__pycache__"

function auto-keygen() {  # auto-(ssh-)keygen
    KEYGEN_PATH="${1:-$HOME/.ssh/id_rsa}"
    ssh-keygen -t ed25519 -N "" -f "$KEYGEN_PATH"
}

function ls() {  # (modern-)ls
    TARGET="${1:-.}"
    eza "$TARGET" -la --ignore-glob="$IGNORE" --icons=auto --git --git-repos
}

function qcd() {  # q(uick)-cd
    BASE="${1:-$HOME}"
    cd "$(fd --hidden --type d . "$BASE" | fzf --ansi --border --preview "tree -a -I '$IGNORE' -C {}")"
    clear
}

function si2() {  # s(ync)-i(term)2
    cp "$HOME/.config/iterm2_user/*" "$HOME/.dotfiles/dotfiles/.config/iterm2_user/"
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
    [[ -n "$SPEC" ]] && \
        printf "ERROR: Please provide a SPEC name.\n" && \
        exit 1
    micromamba create -f "$HOME/.config/micromamba/specs/$SPEC.yml"
}
