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
  {
    "altermo/ultimate-autopair.nvim",
    opts = {}
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },

  {
    "j-hui/fidget.nvim",
    opts = { notification = { override_vim_notify = true } }
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { view_options = { show_hidden = true } }
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme catppuccin-mocha")
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_b = { "branch" },
        lualine_x = { "filetype" },
        lualine_y = { "diagnostics" }
      }
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "0.1.x",
    opts = {
      pickers = {
        find_files = {
          theme = "dropdown",
          find_command = {
            "fd", "--hidden", "--exclude", ".git", "--type", "f"
          }
        },
        live_grep = {
          theme = "dropdown",
          additional_args = { "--hidden", "--glob", "!.git" }
        }
      }
    }
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local python_path = vim.fn.exepath("python")
      if vim.fn.executable("python3") == 1 then
        python_path = vim.fn.exepath("python3")
      end

      local opts = {}

      opts.clangd = {}
      opts.jsonls = {}
      opts.lua_ls = {}
      opts.pyright = {
        settings = {
          python = {
            analysis = { typeCheckingMode = "off" },
            pythonPath = python_path
          }
        }
      }
      opts.ruff_lsp = {
        on_attach = function(a, _)
          a.server_capabilities.hoverProvider = false
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
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim"
    },
    config = function()
      local cmp = require("cmp")
      local opts = {}

      opts.completion = { completeopt = "menu,menuone,noinsert" }
      opts.formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = function() return math.floor(0.35 * vim.o.columns) end,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "",
            buffer = ""
          }
        })
      }
      opts.mapping = {
        ["<C-y>"] = cmp.mapping.confirm(),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" })
      }
      opts.snippet = {
        expand = function(a) vim.snippet.expand(a.body) end
      }
      opts.sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          function(a, b)
            local _, x = a.completion_item.label:find("^_+")
            local _, y = b.completion_item.label:find("^_+")
            x = x or 0
            y = y or 0
            if x == y then
              return
            else
              return x < y
            end
          end,
          cmp.config.compare.locality,
          cmp.config.compare.kind
        }
      }
      opts.sources = {
        { name = "nvim_lsp" },
        { name = "buffer" }
      }

      cmp.setup(opts)
    end
  }
})
