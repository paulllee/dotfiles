#!/bin/bash

printf "Homebrew is a requirement for paulllee/dotfiles and will be installed.
Your password is required for sudo access during the installation.
\n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    eval "$(/opt/homebrew/bin/brew shellenv)" || \
    exit 1  # exit IF Homebrew installation returns a non zero code

printf "Cloning dotfiles and executing dotsync.
This will rename ~/.dotfiles to ~/.dotfiles-old to prevent conflicts if it already exists.
\n"

[[ -d ~/.dotfiles ]] && mv ~/.dotfiles ~/.dotfiles-old
git clone --depth=1 https://github.com/paulllee/dotfiles.git ~/.dotfiles && \
    /bin/bash ~/.dotfiles/dotfiles/.local/bin/dotsync -bdfg

printf "Setup completed! Next steps:
    - Change the font of Apple Terminal to 'MesloLGS NF'.
    - Create a new SSH key via 'auto-keygen' and add it to services (e.g. GitHub).
\n"
