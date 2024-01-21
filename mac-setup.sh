#!/bin/bash

# COLORS
NORMAL='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m' 
BWHITE='\033[1;37m'

printf_h () {
   printf "\n${BLUE}>${NORMAL} $1 ${BLUE}<${NORMAL}\n\n"
} 

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

printf_h "Installing Xcode Command Lines Tools + Homebrew"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

printf_h "Disabling Homebrew's Analytics"

brew analytics off

printf_h "Installing All Homebrew Packages"

for PKG in "${CASK_PKGS[@]}"
    do
        brew install --cask $PKG
    done

for PKG in "${BREW_PKGS[@]}"
    do
        brew install $PKG
    done

printf_h "Cloning Remote Files to Temp Location"

git clone --depth=1 https://github.com/paulllee/dotfiles.git ~/.temp/dotfiles

printf_h "Generating New SSH Key"

yes "y" | ssh-keygen -t ed25519 -N "" -f ~/.temp/dotfiles/dotfiles/.ssh/id_rsa

printf_h "Rsyncing Files to Home"

rsync -aP ~/.temp/dotfiles/dotfiles/ ~
rsync -aP ~/.temp/dotfiles/fonts/ ~/Library/Fonts/

printf_h "Updating Git Configuration"

read -p "Enter Git Name: " GIT_NAME
read -p "Enter Git Email: " GIT_EMAIL

git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL
git config --global user.signingkey ~/.ssh/id_rsa.pub
git config --global gpg.format ssh

printf_h "Removing Temp Location"

rm -rfv ~/.temp

printf_h "Disabling DS_Store File Creation on NFS"

defaults write com.apple.desktopservices DSDontWriteNetworkStores true
printf "Updated DSDontWriteNetworkStores in com.apple.desktopservices from False to True\n"

printf_h "Setup ${GREEN}COMPLETED${NORMAL}"

printf "https://github.com/paulllee/dotfiles for quick access to the GitHub.\n"

printf_h "${BWHITE}NEXT STEPS${NORMAL}"

printf "    - Change the font of Apple Terminal to 'MesloLGS NF'.\n"
printf "    - Add SSH key from '~/.ssh/id_rsa.pub' to services that require one (GitHub).\n\n"
