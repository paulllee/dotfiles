-- [[ OPTIONS ]]

-- set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- remove unused providers for nvim
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- enable markdown folds and default to expanded
vim.g.markdown_folding = 1
vim.o.foldlevel = 99

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

-- [[ PLUGINS ]]

-- install lazy.nvim
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
  {
    "windwp/nvim-autopairs",
    opts = {}
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },

  {
    "stevearc/dressing.nvim",
    opts = {},
  },

  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = { show_hidden = true }
    }
  },

  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },

  {
    "j-hui/fidget.nvim",
    opts = {
      notification = { override_vim_notify = true }
    }
  },

  {
    "akinsho/toggleterm.nvim",
    opts = {
      direction = "float",
      open_mapping = [[<C-\>]],
      persist_mode = true
    }
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_b = { "branch", "diagnostics" },
        lualine_x = { "filetype" },
        lualine_y = { "grapple" }
      }
    }
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "0.1.x",
    opts = {
      pickers = {
        find_files = {
          find_command = { "fd", "--hidden", "--type", "f" }
        },
        live_grep = {
          additional_args = { "--hidden", "--glob=!{.git}" }
        }
      }
    }
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
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- the following should always be installed
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",

          -- the following is required by noice.nvim
          "regex",
          "bash",
          "markdown",
          "markdown_inline"
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true
        },
        indent = { enable = true }
      })
    end
  },

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

      for lsp, conf in pairs(confs) do
        -- adding cmp capabilities to all lsps
        conf.capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[lsp].setup(conf)
      end

      local cmp = require("cmp")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            menu = {
              nvim_lsp = "",
              buffer = ""
            }
          })
        },
        mapping = {
          ["<C-y>"] = cmp.mapping.confirm(),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" })
        },
        snippet = {
          expand = function(args)
            require("snippy").expand_snippet(args.body)
          end
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            -- sort completion items with two underscores in a row
            function(a, b)
              local _, us1 = a.completion_item.label:find("^_+")
              local _, us2 = b.completion_item.label:find("^_+")
              us1 = us1 or 0
              us2 = us2 or 0
              if us1 > us2 then
                return false
              elseif us1 < us2 then
                return true
              end
            end,
            cmp.config.compare.locality,
            cmp.config.compare.kind
          }
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" }
        }
      })

      require("snippy").setup({
        mappings = {
          is = {
            ["<Tab>"] = "next",
            ["<S-Tab>"] = "previous"
          }
        }
      })
    end
  }
})

-- [[ MAPPINGS ]]

local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, "<CMD>" .. rhs .. "<CR>", {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

map("n", "<Leader>e", "Oil --float")

map("n", "<Leader>f", "Telescope find_files")
map("n", "<Leader>g", "Telescope live_grep")

map("n", ",", "Grapple toggle_tags")
map("n", "<C-s>", "Grapple toggle")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lmap(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, desc, args.buf)
    end
    lmap("n", "gd", "Telescope lsp_definitions")
    lmap("n", "gr", "Telescope lsp_references")

    lmap("n", "gh", "lua vim.lsp.buf.hover()")
    lmap("n", "gs", "lua vim.lsp.buf.signature_help()")

    lmap("n", "<Leader>R", "lua vim.lsp.buf.rename()")
    lmap("n", "<Leader>F", "lua vim.lsp.buf.format()")
  end
})
