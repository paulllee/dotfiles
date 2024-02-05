IGNORE=".DS_Store|.git"

function auto-keygen() {  # auto-(ssh-)keygen
    KEYGEN_PATH="${1:-$HOME/.ssh/id_rsa}"
    ssh-keygen -t ed25519 -N "" -f $KEYGEN_PATH
}

function ls() {  # (modern-)ls
    eza -la --ignore-glob=$IGNORE --icons=auto --git --git-repos
}

function qcd() {  # q(uick)-cd
    BASE="${1:-$HOME}"
    cd $(fd --hidden --type d . $BASE | fzf --ansi --border --preview "tree -a -I '$IGNORE' -C {}")
    clear
}

