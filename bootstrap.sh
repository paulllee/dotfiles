#!/bin/bash

printf "Your password is required for sudo access during Homebrew installation.\n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    eval "$(/opt/homebrew/bin/brew shellenv)" || \
    exit 1  # exit IF Homebrew installation returns a non zero code

read -e -p "Setup requires overwriting ~/.dotfiles directory. Continue? [Y/n]: " choice

[[ $choice != "y" && $choice != "Y" ]] && \
    printf "Setup exiting early due to user choice.\n" && \
    exit 0

rm -rf ~/.dotfiles && \
    git clone --depth=1 https://github.com/paulllee/dotfiles.git ~/.dotfiles && \
    BOOTSTRAP_MODE=1 /bin/bash ~/.dotfiles/dotfiles/.local/bin/dotsync -bcgms

printf "Setup completed! Next steps:
    - Create a new SSH key via 'auto-keygen' for GitHub.
    - View 'dotsync -h' for more information.
    - I personally like to use 'mkdir ~/dev'.
\n"

exec zsh
