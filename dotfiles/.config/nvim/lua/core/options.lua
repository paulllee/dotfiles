-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remove unused providers from nvim
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- globally set tab to 2 spaces
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- misc
vim.o.wrap = false
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.o.timeout = true
vim.o.timeoutlen = 300
