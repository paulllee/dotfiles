# must load in the priority commands BEFORE the rest
for config in ~/.local/command/priority/**/*(.); source $config
for config in ~/.local/command/**/*(.); source $config
