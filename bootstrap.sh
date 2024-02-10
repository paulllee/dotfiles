#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    eval "$(/opt/homebrew/bin/brew shellenv)" || \
    exit 1  # exit IF Homebrew installation returns a non zero code

read -e -p "Setup requires overwriting $HOME/.dotfiles directory. Continue? [Y/n]: " choice

[[ $choice != "y" && $choice != "Y" ]] && \
    printf "Setup exiting early due to user choice.\n" && \
    exit 0

rm -rf $HOME/.dotfiles && \
    git clone --depth=1 https://github.com/paulllee/dotfiles.git $HOME/.dotfiles && \
    BOOTSTRAP_MODE=1 /bin/bash $HOME/.dotfiles/dotfiles/.local/bin/dotsync -bcgms

printf "Setup completed!\n"

exec zsh -l

