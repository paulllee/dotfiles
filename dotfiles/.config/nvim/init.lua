-- checks if an environment is activated and sets it as the path
local conda_prefix = os.getenv("CONDA_PREFIX")
local python_path = conda_prefix == nil and "python" or conda_prefix .. "/bin/python"

-- options (sorted a-z)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.python_host_prog = python_path
vim.g.python3_host_prog = python_path

vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.tabstop = 2

vim.wo.number = true
vim.wo.relativenumber = true

-- plugins via https://github.com/echasnovski/mini.nvim :)
local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  })
  vim.cmd("packadd mini.nvim | helptags ALL")
end

require("mini.deps").setup()
local add = MiniDeps.add

MiniDeps.now(function()
  add("catppuccin/nvim")
  vim.cmd("colorscheme catppuccin-mocha")

  add("lewis6991/gitsigns.nvim")
  require("gitsigns").setup()

  add("nvim-tree/nvim-web-devicons")
  require("nvim-web-devicons").setup()

  require("mini.statusline").setup()

  add("neovim/nvim-lspconfig")
  require("lspconfig").lua_ls.setup({
    settings = { Lua = { diagnostics = { globals = { "MiniDeps", "vim" } } } }
  })
  require("lspconfig").pyright.setup({
    cmd = { "micromamba", "run", "-n", "lsp", "pyright-langserver", "--stdio" },
    settings = { python = { pythonPath = python_path } }
  })
  require("lspconfig").ruff_lsp.setup({
    cmd = { "micromamba", "run", "-n", "lsp", "ruff-lsp" }
  })

  require("mini.completion").setup()

  add({
    source = "nvim-treesitter/nvim-treesitter",
    hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
  })
  require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    highlight = { enable = true },
    indent = { enable = true },
  })
end)
