#!/usr/bin/env bash

set -e

if ! [[ -d "$HOME/.dotfiles" ]]; then
  printf "$HOME/.dotfiles does not exist. Please clone to that directory.\n"
  exit 1
fi

/usr/bin/env bash "$HOME/.dotfiles/dotfiles/.local/bin/ds" -degmp

printf "Changing default shell to fish will prompt for sudo access.\n"
echo "/opt/homebrew/bin/fish" | sudo tee -a "/etc/shells" && \
  chsh -s "/opt/homebrew/bin/fish"

printf "Bootstrap complete! Please restart your terminal.\n"
