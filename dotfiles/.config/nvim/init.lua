vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "json", "ps1", "python" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end
})

vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 10
vim.o.undofile = true
vim.o.wrap = false

vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.filetype.add({
  filename = { ["Brewfile"] = "ruby" }
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-tree/nvim-web-devicons" },
  { "windwp/nvim-autopairs",     opts = {} },
  { "lewis6991/gitsigns.nvim",   opts = {} },
  { "nvim-lualine/lualine.nvim", opts = {} },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 100,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", "<CMD>Oil<CR>", noremap = true }
    },
    opts = {}
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<Leader>f", "<CMD>FzfLua files<CR>" },
      { "<Leader>g", "<CMD>FzfLua live_grep<CR>" }
    },
    opts = {
      winopts = { backdrop = 100 }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  }
}, { rocks = { enabled = false } })
