# dotfiles

I like to reset my machines more frequently than most.

These bootstrap script pretty much installs and configures everything I need.
The goal was the make this a simple process with little overhead.

For quick setup, use the bootstrap script below.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/paulllee/dotfiles/main/bootstrap.sh)"
```

## dotsync

I provided an app to one-way sync from remote to your local dotfiles via `dotsync -s`. 
View `dotsync -h` for more information.

## .zshrc tips

Here are a few aliases that I feel are the most helpful to note.

| Alias | Command | Description |
| --- | --- | --- |
| `upgrade-all` | `brew upgrade && brew upgrade --cask && mas upgrade` | Upgrades all packages installed through Brewfile |
| `lsg` | `eza -la --icons --git --git-repos` | Uses `eza` to produce list view with `git` information |
| `qcd` | `cd $(fd . ~ --type d -E ".git" \| fzf)` | Uses `fd` and `fzf` quickly browse through file system from home directory |
