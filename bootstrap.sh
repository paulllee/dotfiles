#!/bin/bash

printf "Homebrew is a requirement for paulllee/dotfiles and will be installed.
Your password is required for sudo access during the Homebrew installation.
\n"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
    eval "$(/opt/homebrew/bin/brew shellenv)" || \
    exit 1  # exit IF Homebrew installation returns a non zero code

printf "Cloning dotfiles and executing dotsync.
This will rename ~/.dotfiles to ~/.dotfiles-old to prevent conflicts if it already exists.
\n"

[[ -d ~/.dotfiles ]] && rm -rf ~/.dotfiles-old && mv ~/.dotfiles ~/.dotfiles-old
git clone --depth=1 https://github.com/paulllee/dotfiles.git ~/.dotfiles && \
    BOOTSTRAP_MODE=1 /bin/bash ~/.dotfiles/dotfiles/.local/bin/dotsync -bgms

printf "Setup completed! Next steps:
    - Change the font of Apple Terminal to 'MesloLGS NF'.
    - Create a new SSH key via 'auto-keygen' and add it to services (e.g. GitHub).
    - I like to use ~/Developer for my dev workspace. 'mkdir ~/Developer'.
    - TIP: In the future, sync your dotfiles with remote via 'dotsync -s'.
      - View 'dotsync -h' for more information.
    - TIP: You can upgrade all packages with 'upgrade-all'.
\n"

exec zsh
