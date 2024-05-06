-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remove unused providers from nvim
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- use folding in markdown files
vim.g.markdown_folding = 1

-- globally set tab to 2 spaces
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- disable line wrap
vim.o.wrap = false

-- smart case when finding/substitution
vim.o.smartcase = true

-- use SYSTEM clipboard
vim.o.clipboard = "unnamedplus"

-- allows for persistent undos
vim.o.undofile = true

-- set timeout for which-key plugin
vim.o.timeout = true
vim.o.timeoutlen = 150
