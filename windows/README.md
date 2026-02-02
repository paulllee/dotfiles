# windows

adhoc scripts to get a windows machine up and running for my liking

```ps1
# install scoop package manager
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# install apps
.\Sync.ps1

# debloater - https://github.com/Raphire/Win11Debloat
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
```

open a new terminal as administrator

```ps1
# creates symlinks (administrator only)
.\Symlink.ps1
```

## symlinks

symlink creation requires admin rights...

| config | source | destination |
|--------|--------|-------------|
| nvim | `dotfiles/.config/nvim/` | `~/AppData/Local/nvim/` |
| lazygit | `dotfiles/.config/lazygit/config.yml` | `~/AppData/Roaming/lazygit/config.yml` |
| wezterm | `dotfiles/.config/wezterm/wezterm.lua` | `~/.wezterm.lua` |
| claude-code | `dotfiles/.claude/settings.json` | `~/.claude/settings.json` |
| ideavimrc | `windows/.ideavimrc` | `~/.ideavimrc` |
| powershell | `windows/Microsoft.PowerShell_profile.ps1` | `~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` |
| powershell | `windows/Microsoft.PowerShell_profile.ps1` | `~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` |
| powershell | `windows/Microsoft.PowerShell_profile.ps1` | `~/OneDrive/Documents/PowerShell/Microsoft.PowerShell_profile.ps1` |
| powershell | `windows/Microsoft.PowerShell_profile.ps1` | `~/OneDrive/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` |
