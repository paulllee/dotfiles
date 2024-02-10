IGNORE=".DS_Store|.git|__pycache__"

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

function si2() {  # s(ync)-i(term)2
    cp $HOME/.config/iterm2_user/* $HOME/.dotfiles/dotfiles/.config/iterm2_user
}

function c() {  # c(ode)
    PROJECT="${1:-.}"
    code $PROJECT --user-data-dir $HOME/.config/vscode/
}

function cei() {  # c(ode)-e(xtension)-i(nstall)
    source $HOME/.config/vscode/extensions.zsh
    for EXTENSION in "${EXTENSIONS[@]}"; do
        code --install-extension $EXTENSION --force
    done
}
