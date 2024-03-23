#!/usr/bin/env bash

set -e

/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
  eval "$(/opt/homebrew/bin/brew shellenv)"

rm -rf "$HOME/.dotfiles" && \
  git clone --depth=1 https://github.com/paulllee/dotfiles.git "$HOME/.dotfiles" && \
  /usr/bin/env bash "$HOME/.dotfiles/dotfiles/.local/bin/ds" -dgmp

printf "Changing default shell to fish will prompt for sudo access.\n"
echo "/opt/homebrew/bin/fish" | sudo tee -a "/etc/shells" && \
  chsh -s "/opt/homebrew/bin/fish"
