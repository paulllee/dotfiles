-- sets leader key to <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use 4 spaces instead of a tab
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- sync clipboard between OS and nvim
vim.o.clipboard = "unnamedplus"

-- enable mouse
vim.o.mouse = "a"

-- break indent
vim.o.breakindent = true

-- saves undo history in a file
vim.o.undofile = true

-- case-insensitive searching unless you have a capital
vim.o.ignorecase = true
vim.o.smartcase = true

-- better completion experience
vim.o.completeopt = "menuone,noselect"

-- enable true color
vim.o.termguicolors = true

-- decrease update time for backup swaps
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- relative line numbers are game changer
vim.wo.number = true
vim.wo.relativenumber = true

-- keep signcolumn on by default
vim.wo.signcolumn = "yes"
