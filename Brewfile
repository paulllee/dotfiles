brew "colima"
brew "docker"
brew "eza"
brew "fd"
brew "fzf"
brew "lazygit"
brew "micromamba"
brew "neovim"
brew "pure"
brew "ripgrep"
brew "zsh"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

if OS.linux?
  tap "homebrew/linux-fonts"
  brew "font-jetbrains-mono-nerd-font"
end

if OS.mac?
  cask "arc"
  cask "iterm2"
  cask "mac-mouse-fix"
  cask "swish"

  tap "homebrew/cask-fonts"
  cask "font-jetbrains-mono-nerd-font"

  brew "mas"
  mas "Tailscale", id: 1475387142
end
