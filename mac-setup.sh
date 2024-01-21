#!/bin/bash

declare -a CASK_PKGS=(
    "arc"
    "mac-mouse-fix"
    "obsidian"
    "swish"
    "tailscale"
    "visual-studio-code"
)

declare -a BREW_PKGS=(
    "colima"
    "docker"
    "neovim"
    "powerlevel10k"
)

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew analytics off

for PKG in "${CASK_PKGS[@]}"
    do
        brew install --cask $PKG
    done

for PKG in "${BREW_PKGS[@]}"
    do
        brew install $PKG
    done

git clone --depth=1 git@github.com:paulllee/dotfiles.git ~/.temp/dotfiles

yes "y" | ssh-keygen -t ed25519 -N "" -f ~/.temp/dotfiles/dotfiles/.ssh/id_rsa

rsync -aP ~/.temp/dotfiles/dotfiles/ ~
rsync -aP ~/.temp/dotfiles/fonts/ ~/Library/Fonts/

bash ~/.temp/dotfiles/bin/update-gitconfig.sh

open ~/.temp/dotfiles/configs/Main.terminal
defaults write com.apple.terminal "Default Window Settings" -string "Main"

defaults write com.apple.desktopservices DSDontWriteNetworkStores true

rm -rf ~/.temp

echo "Finished. You may now close this Terminal window and use the new one that opened up. Don't forget to add the newly generated SSH authentication key to GitHub/GitLab/any services that utilize your SSH key."
