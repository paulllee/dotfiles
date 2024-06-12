# dotfiles

Everything needed to setup macOS.

1.  Install Homebrew (https://brew.sh).
2.  Clone the dotfiles to `$HOME/.dotfiles`.
3.  Run the initial dotsync script to set up the dotfiles:
    ```sh
    /usr/bin/env bash "$HOME/.dotfiles/dotfiles/.local/bin/ds" -degmp
    ```
4.  Change the default shell to fish:
    ```sh
    # run these commands sequentially
    which fish | sudo tee -a /etc/shells
    chsh -s "$(which fish)"
    ```
5.  Restart your terminal after the script completes.

## dotsync

I provided an app to one-way sync your local dotfiles via `ds -d`.
View `ds -h` for more information.
