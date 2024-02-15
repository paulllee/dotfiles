local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local ignore = { ".DS_Store", ".git", "__pycache__" }

-- TODO: next time I try nvim, utilize
--       https://github.com/echasnovski/mini.nvim
--       also, add LSPs manually...

local plugins = { -- sorted alphabetically by plugin NAME
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function() 
      vim.cmd.colorscheme "catppuccin-mocha"
    end,
  },

  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
    config = function()
      local lsp = require("lsp-zero").preset({})

      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        lsp.buffer_autoformat()
      end)

      lsp.ensure_installed({
        "clangd",
        "lua_ls",
        "ruff_lsp",
      })

      lsp.setup()

      require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("lualine").setup()
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "MunifTanjim/nui.nvim" },
    },
    config = function()
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,
            never_show = ignore,
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_installed = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            file_ignore_patterns = ignore,
            hidden = true
          },
          live_grep = {
            file_ignore_patterns = ignore,
            additional_args = function(_)
              return { "--hidden" }
            end
          }
        },
      })
    end,
  },
}

require("lazy").setup(plugins)
