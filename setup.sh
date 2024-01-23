#!/bin/bash

function printf_h () {
    printf "\n> $1\n\n"
}

printf "Hello! This is the first time setup for paulllee/dotfiles.\n"

printf_h "Homebrew Installation (Requires Sudo Access)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ $? > 0 ]]
then
    printf "Homebrew installation failed, exiting...\n"
    exit 1
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

printf_h "Dotfiles Installation"

if [ -d ~/.dotfiles ]
then
    mv ~/.dotfiles ~/.dotfiles-old
    printf "Renamed old '.dotfiles' to '.dotfiles-old' to prevent conflicts when cloning.\n"
fi

git clone --depth=1 https://github.com/paulllee/dotfiles.git ~/.dotfiles

bash ~/.dotfiles/dotfiles/.local/bin/dot-filesync
bash ~/.dotfiles/dotfiles/.local/bin/dot-gitsync
bash ~/.dotfiles/dotfiles/.local/bin/dot-setdefaults

printf_h "Font Installation"

read -p "This will install 'MesloLDS Nerd Font' in your Font Book. Continue? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rsync -aP ~/.dotfiles/fonts/ ~/Library/Fonts/
fi

printf_h "SSH Key Generation"

read -p "This will generate a new key to '~/.ssh/id_rsa'. Continue? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    yes "y" | ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_rsa
fi

printf_h "Package Installation"

read -p "This will install all applications in the Brewfile. Continue? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    brew bundle --file ~/.dotfiles/Brewfile --no-lock
fi

printf_h "Setup Complete! Next Steps"

printf "    - Change the font of Apple Terminal to 'MesloLGS NF'.\n"
printf "    - Add SSH key from '~/.ssh/id_rsa.pub' to required services (GitHub).\n\n"
