# must load in the priority configs BEFORE the rest
for config in ~/.local/configs/priority/**/*(.); source $config
for config in ~/.local/configs/**/*(.); source $config
