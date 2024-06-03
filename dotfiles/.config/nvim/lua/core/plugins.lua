-- use lazy.nvim for plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- autopairs
  {
    "windwp/nvim-autopairs",
    opts = {}
  },

  -- git helpers
  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },

  -- modern notifications
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = { override_vim_notify = true }
    }
  },

  -- buffer styled file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = { show_hidden = true }
    }
  },

  -- theme of choice
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
      require("nvim-treesitter.configs").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  },

  -- modular statusline
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

  -- browsing made easy
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
          additional_args = {
            "--hidden", "--glob", "!.git"
          }
        }
      }
    }
  },

  -- lsp + cmp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "dcampos/nvim-snippy",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim"
    },
    config = function()
      -- solves issue between windows vs mac
      -- where windows doesn't recognize `python3`
      local function get_python_path()
        if vim.fn.executable("python3") == 1 then
          return vim.fn.exepath("python3")
        end
        return vim.fn.exepath("python")
      end

      -- disables hover to prioritize pyright
      local function on_attach_ruff(c, _)
        c.server_capabilities.hoverProvider = false
      end

      local confs = {
        clangd = {},
        jsonls = {},
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off"
              },
              pythonPath = get_python_path()
            }
          }
        },
        ruff_lsp = { on_attach = on_attach_ruff }
      }

      local cmp_lsp = require("cmp_nvim_lsp")
      for lsp, conf in pairs(confs) do
        conf.capabilities = cmp_lsp.default_capabilities()
        require("lspconfig")[lsp].setup(conf)
      end

      -- for when i decide to code in a small window
      local function get_dynamic_maxwidth()
        return math.floor(0.35 * vim.o.columns)
      end
      local formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = get_dynamic_maxwidth,
          ellipsis_char = "...",
          menu = {
            nvim_lsp = "",
            buffer = ""
          }
        })
      }

      local cmp = require("cmp")
      local behavior = { behavior = "select" }
      local mapping = {
        ["<C-y>"] = cmp.mapping.confirm(),
        ["<C-p>"] = cmp.mapping.select_prev_item(behavior),
        ["<C-n>"] = cmp.mapping.select_next_item(behavior)
      }

      local snippy = require("snippy")
      snippy.setup({
        mappings = {
          is = {
            ["<Tab>"] = "next",
            ["<S-Tab>"] = "previous"
          }
        }
      })
      local snippet = {
        expand = function(args)
          snippy.expand_snippet(args.body)
        end
      }

      -- sort completion items with two underscores in a row
      local function compare_double_underscore(a, b)
        local _, us1 = a.completion_item.label:find("^_+")
        local _, us2 = b.completion_item.label:find("^_+")
        us1 = us1 or 0
        us2 = us2 or 0
        if us1 > us2 then
          return false
        elseif us1 < us2 then
          return true
        end
      end
      local sorting = {
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          compare_double_underscore,
          cmp.config.compare.locality,
          cmp.config.compare.kind
        }
      }

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = formatting,
        mapping = mapping,
        snippet = snippet,
        sorting = sorting,
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" }
        }
      })
    end
  }
})
