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
