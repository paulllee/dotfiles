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

-- install lazy manager
local lazy = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazy
  })
end
vim.opt.rtp:prepend(lazy)

local ui_width = 40
local ui_height = 12

require("lazy").setup({
  -- auto-pairing of chars
  {
    "windwp/nvim-autopairs",
    opts = {}
  },

  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "dcampos/nvim-snippy",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim"
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local snippy = require("snippy")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = ui_width,
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
            snippy.expand_snippet(args.body)
          end
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
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
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered()
        }
      })
    end
  },

  -- file explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          if name == ".git" then
            return true
          end
          return false
        end
      },
      float = {
        max_width = ui_width,
        max_height = ui_height
      }
    }
  },

  -- git decorators
  {
    "lewis6991/gitsigns.nvim",
    opts = {}
  },

  -- harpoon-like navigation
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      style = "basename",
      win_opts = {
        width = ui_width,
        height = ui_height
      }
    }

  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_lsp = require("cmp_nvim_lsp")

      local configs = {
        clangd = {},
        jsonls = {},
        lua_ls = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off"
              },
              pythonPath = function()
                if vim.fn.executable("python3") == 1 then
                  return vim.fn.exepath("python3")
                end
                return vim.fn.exepath("python")
              end
            }
          }
        },
        ruff_lsp = {
          on_attach = function(client, _)
            client.server_capabilities.hoverProvider = false
          end
        }
      }

      for name, config in pairs(configs) do
        config.capabilities = cmp_lsp.default_capabilities()
        lspconfig[name].setup(config)
      end
    end
  },

  -- notify customization
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "compact",
      stages = "static",
      timeout = 2500
    }
  },

  -- prettier ui
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true
        },
        hover = {
          opts = {
            size = {
              max_width = ui_width,
              max_height = ui_height
            }
          }
        },
        signature = {
          opts = {
            size = {
              max_width = ui_width,
              max_height = ui_height
            }
          }
        }
      },
      presets = {
        command_palette = true,
        lsp_doc_border = true
      }
    }


  },

  -- snippy
  {
    "dcampos/nvim-snippy",
    opts = {
      mappings = {
        is = {
          ["<Tab>"] = "next",
          ["<S-Tab>"] = "previous"
        }
      }
    }
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sections = {
        lualine_b = { "branch", "diagnostics" },
        lualine_x = {
          function()
            local reg = vim.fn.reg_recording()
            if reg == "" then
              return ""
            end
            return "recording @" .. reg
          end
          ,
          "filetype"
        },
        lualine_y = { "grapple" }
      }
    }
  },

  -- telescope
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
          additional_args = { "--hidden", "--glob=!.git" }
        }
      }
    }
  },

  -- terminal
  {
    "akinsho/toggleterm.nvim",
    opts = {
      direction = "float",
      open_mapping = [[<C-\>]],
      persist_mode = true
    }
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
  }
})

-- [[ KEYBINDS ]]

-- vim.keymap.set wrapper with sane defaults
local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

-- all rhs default to <CMD>rhs<CR> format
local function cmap(mode, lhs, rhs, desc, buffer)
  map(mode, lhs, "<CMD>" .. rhs .. "<CR>", desc, buffer)
end

-- to go between windows more conveniently
map("n", "<C-w><C-h>", "<C-w>h")
map("n", "<C-w><C-j>", "<C-w>j")
map("n", "<C-w><C-k>", "<C-w>k")
map("n", "<C-w><C-l>", "<C-w>l")

cmap("n", "<Leader>e", "Oil --float")

cmap("n", "<Leader>f", "Telescope find_files")
cmap("n", "<Leader>g", "Telescope live_grep")

cmap("n", "<C-s>", "Grapple toggle")
cmap("n", ",", "Grapple toggle_tags")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- wraps cmap for lsp keybinds
    local function lmap(mode, lhs, rhs, desc)
      cmap(mode, lhs, rhs, desc, args.buf)
    end

    lmap("n", "gh", "lua vim.lsp.buf.hover()")
    lmap("n", "gs", "lua vim.lsp.buf.signature_help()")

    lmap("n", "gd", "Telescope lsp_definitions")
    lmap("n", "gr", "Telescope lsp_references")

    lmap("n", "<Leader>R", "lua vim.lsp.buf.rename()")
    lmap("n", "<Leader>F", "lua vim.lsp.buf.format()")
  end
})
