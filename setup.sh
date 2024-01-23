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

printf_h "Cloning Dotfiles from GitHub"

git clone --depth=1 https://github.com/paulllee/dotfiles.git ~/.dotfiles

printf_h "Running Dot Scripts"

bash ~/.dotfiles/dotfiles/.local/bin/dot-filesync
bash ~/.dotfiles/dotfiles/.local/bin/dot-gitsync
bash ~/.dotfiles/dotfiles/.local/bin/dot-setdefaults

printf_h "Running Potential Overrides"

printf "CAUTION: Syncing the fonts can override the MesloLDS Nerd Font if previously installed and used.\n"
read -p "Do you want to continue? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rsync -aP ~/.dotfiles/fonts/ ~/Library/Fonts/
fi

printf "CAUTION: Generating a new SSH key can override your SSH key if previously named id_rsa.\n"
read -p "Do you want to continue? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    yes "y" | ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_rsa
fi

printf_h "Installing All Homebrew Packages"

printf "CAUTION: Any previously installed applications could be overriden by Homebrew cask install.\n"
read -p "Do you want to continue? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    brew bundle --file ~/.dotfiles/Brewfile --no-lock
fi

printf_h "Setup Completed!"

printf "https://github.com/paulllee/dotfiles for quick access to the GitHub.\n"

printf_h "NEXT STEPS"

printf "    - Change the font of Apple Terminal to 'MesloLGS NF'.\n"
printf "    - Add SSH key from '~/.ssh/id_rsa.pub' to required services (GitHub).\n\n"
