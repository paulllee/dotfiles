# .dotfiles

## Project Overview

macOS environment bootstrap and dotfile manager. Includes shell configuration (fish, bash), editor setup (Neovim, VS Code), terminal emulator config (WezTerm), and a custom `ds` (dotsync) script for symlinking and managing dotfiles.

## Tech Stack

- **Shell:** Fish, Bash (dotsync script)
- **Lua:** Neovim config, WezTerm config
- **Package management:** Homebrew (Brewfile)
- **Tools:** lazygit, ripgrep, fd, fzf, starship prompt

## Build Tools

No build system detected. The primary entry point is the `ds` (dotsync) script at `dotfiles/.local/bin/ds`.

## Development Standards

### General
- Keep changes minimal and focused
- Prefer editing existing files over creating new ones
- No autocommit — the developer commits when ready

### Language-Specific
No language-specific standards apply (no Python or C# detected).

## Architecture Decisions

<!-- Record why things are built a certain way so an agent can revisit the reasoning. -->

## Lessons Learned

<!-- One-line discoveries appended by /ap-plan after each run. Do not duplicate entries. -->
