case "$(uname)" in
  Darwin) eval "$(/opt/homebrew/bin/brew shellenv)";;
  Linux)  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)";;
esac
