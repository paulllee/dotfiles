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

require("lazy").setup({
  -- common dependencies
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",

  { "numToStr/Comment.nvim",     opts = {} }, -- comments
  { "lewis6991/gitsigns.nvim",   opts = {} }, -- git tooltips
  { "nvim-lualine/lualine.nvim", opts = {} }, -- fancy statusline
  { "windwp/nvim-autopairs",     opts = {} }, -- autopairings
  { "nvim-tree/nvim-tree.lua",   opts = {} }, -- file explorer
  { "folke/which-key.nvim",      opts = {} }, -- keybind tooltips

  -- theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },

  -- harpoon-like navigation
  {
    "otavioschwanck/arrow.nvim",
    opts = {
      show_icons = true,
      leader_key = ","
    }
  },

  -- fancy ui
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true
        }
      },
      presets = {
        command_palette = true,
        lsp_doc_border = true
      }
    }
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
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
  },

  -- lsp and cmp
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }
    },
    config = function()
      local function get_conf(cmd, settings)
        local new_conf = {}

        new_conf.capabilities = require("cmp_nvim_lsp").default_capabilities()

        if cmd then
          new_conf.cmd = { "micromamba", "run", "-n", "lsp" }
          for _, arg in ipairs(cmd) do
            table.insert(new_conf.cmd, arg)
          end
        end

        if settings then
          new_conf.settings = settings
        end

        return new_conf
      end

      local confs = {
        bashls        = get_conf({ "bash-language-server", "start" }),
        clangd        = get_conf(),
        cssls         = get_conf({ "vscode-css-language-server", "--stdio" }),
        html          = get_conf({ "vscode-html-language-server", "--stdio" }),
        jsonls        = get_conf({ "vscode-jsonls-language-server", "--stdio" }),
        lua_ls        = get_conf(),
        pyright       = get_conf(
          { "pyright-langserver", "--stdio" },
          {
            python = {
              analysis = {
                -- strict type checking can be a bit of a pain
                typeCheckingMode = "off"
              },
              -- telling pyright what the current python environment is
              pythonPath = vim.fn.exepath("python3")
            }
          }
        ),
        ruff_lsp      = get_conf({ "ruff-lsp" }),
        rust_analyzer = get_conf(),
        tsserver      = get_conf({ "typescript-language-server", "--stdio" })
      }

      for name, conf in pairs(confs) do
        require("lspconfig")[name].setup(conf)
      end

      local cmp = require("cmp")
      local ls = require("luasnip")

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
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
          ["<C-d>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),
          ["<C-j>"] = cmp.mapping(function() ls.jump(-1) end, { "i", "s" }),
          ["<C-k>"] = cmp.mapping(function() ls.jump(1) end, { "i", "s" })
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            -- sorts completion items with one or more underscores
            -- helpful in python especially
            function(entry1, entry2)
              local _, entry1_under = entry1.completion_item.label:find("^_+")
              local _, entry2_under = entry2.completion_item.label:find("^_+")
              entry1_under = entry1_under or 0
              entry2_under = entry2_under or 0
              if entry1_under > entry2_under then
                return false
              elseif entry1_under < entry2_under then
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
  }
})
