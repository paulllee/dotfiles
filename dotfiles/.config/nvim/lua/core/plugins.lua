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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({
  { "nvim-tree/nvim-web-devicons" },
  { "catppuccin/nvim",            name = "catppuccin" },
  { "windwp/nvim-autopairs",      opts = {} },
  { "lewis6991/gitsigns.nvim",    opts = {} },
  { "ibhagwan/fzf-lua",           opts = {} },
  { "stevearc/oil.nvim",          opts = {} },
  { "nvim-lualine/lualine.nvim",  opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      opts.auto_install = true
      opts.highlight = { enable = true }
      opts.indent = { enable = true }
      require("nvim-treesitter.configs").setup(opts)
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function(_, opts)
      opts.clangd = {}
      opts.jsonls = {}
      opts.lua_ls = {}
      opts.pyright = {
        settings = {
          python = {
            analysis = { typeCheckingMode = "off" },
            pythonPath = (function()
              if vim.fn.executable("python3") == 1 then
                return vim.fn.exepath("python3")
              end
              return vim.fn.exepath("python")
            end)()
          }
        }
      }
      opts.ruff = {
        on_attach = function(client, _)
          client.server_capabilities.hoverProvider = false
        end
      }
      for k, v in pairs(opts) do
        v.capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[k].setup(v)
      end
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim"
    },
    config = function(_, opts)
      local cmp = require("cmp")
      opts.completion = { completeopt = "menu,menuone,noinsert" }
      opts.formatting = {
        format = require("lspkind").cmp_format({
          maxwidth = math.floor(0.35 * vim.o.columns)
        })
      }
      opts.mapping = {
        ["<C-y>"] = cmp.mapping.confirm({ select = false }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" })
      }
      opts.snippet = { expand = function(a) vim.snippet.expand(a.body) end }
      opts.sorting = require("cmp.config.default")().sorting
      table.insert(opts.sorting.comparators, function(entry1, entry2)
        local _, x = entry1.completion_item.label:find("^_+")
        local _, y = entry2.completion_item.label:find("^_+")
        x = x or 0
        y = y or 0
        if x == y then return else return x < y end
      end)
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "buffer" }
      }
      cmp.setup(opts)
    end
  }
})
