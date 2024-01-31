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
