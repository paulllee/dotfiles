local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  }
end
vim.opt.rtp:prepend(lazypath)

local helpers = require("support.helpers")
local specs = require("support.specs")
require("lazy").setup({
  -- auto-pairing of chars
  {
    "windwp/nvim-autopairs",
    opts = specs.default
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    opts = specs.neotree
  },

  -- fzf no telescope
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = specs.default
  },

  -- git decorators
  {
    "lewis6991/gitsigns.nvim",
    opts = specs.default
  },

  -- harpoon-like navigation
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = specs.grapple
  },

  -- lsp + cmp + snippy
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    -- due to external lib use, it is not in specs
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_lsp = require("cmp_nvim_lsp")

      for name, lsp in pairs(specs.lsps) do
        lsp.capabilities = cmp_lsp.default_capabilities()
        lspconfig[name].setup(lsp)
      end
    end
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "dcampos/nvim-snippy",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim"
    },
    -- due to external lib use, it is not in specs
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local snippy = require("snippy")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = { format = lspkind.cmp_format(specs.lspkind) },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item()
        },
        snippet = {
          expand = function(args)
            snippy.expand_snippet(args.body)
          end
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            helpers.get_cmp_under_comparator,
            cmp.config.compare.locality,
            cmp.config.compare.kind
          }
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" }
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        }
      })
    end
  },

  {
    "dcampos/nvim-snippy",
    opts = specs.snippy
  },

  -- overall prettier ui
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    opts = specs.noice
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = specs.lualine
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    opts = specs.toggleterm
  },

  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin-mocha")
    end
  },

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup(specs.treesitter)
    end
  }
})
