#!/usr/bin/env bash

/usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \
  eval "$(/opt/homebrew/bin/brew shellenv)" || \
  exit 1  # exit IF Homebrew installation returns a non zero code

rm -rf "$HOME/.dotfiles" && \
  git clone --depth=1 https://github.com/paulllee/dotfiles.git "$HOME/.dotfiles" && \
  /usr/bin/env bash "$HOME/.dotfiles/dotfiles/.local/bin/dotsync" -bcgmsv
