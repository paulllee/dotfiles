# windows

adhoc scripts to get a windows machine up and running for my liking

```ps1
# install scoop package manager
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# install apps via scoop
.\Install.ps1

# debloater - https://github.com/Raphire/Win11Debloat
& ([scriptblock]::Create((irm "https://debloat.raphi.re/")))
```

you can use `scoop update -a` to update all apps at any given time

config paths are not 1 to 1 with macOS, please move configs to respective
location on windows as needed (can be automated at some point)

```
nvim: ~/AppData/Local/nvim/init.lua
lazygit: ~/AppData/Roaming/lazygit/config.yml
wezterm: ~/.wezterm.lua
ideavimrc: ~/.ideavimrc
powershell: ~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1 | $PROFILE
```
