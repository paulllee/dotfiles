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
  { "windwp/nvim-autopairs",      opts = {} },
  { "lewis6991/gitsigns.nvim",    opts = {} },
  { "nvim-lualine/lualine.nvim",  opts = {} },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 100,
    config = function()
      vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },
  {
    "j-hui/fidget.nvim",
    opts = {
      notification = { override_vim_notify = true }
    }
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
    opts = {}
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff" }
      },
      format_on_save = { lsp_fallback = true }
    }
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        python = { "pylint", "ruff" }
      }
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          lint.try_lint()
        end
      })
    end
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
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "onsails/lspkind.nvim"
    },
    config = function()
      local lsps = {
        clangd = {},
        jsonls = {},
        lua_ls = {},
        pyright = {
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
      }
      for k, v in pairs(lsps) do
        v.capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[k].setup(v)
      end

      local cmp = require("cmp")
      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        formatting = {
          format = require("lspkind").cmp_format({
            maxwidth = math.floor(0.35 * vim.o.columns)
          })
        },
        mapping = {
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" })
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" }
        }
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { noremap = true, buffer = ev.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

          -- getting used to new default keymaps arriving in 0.11
          vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
          vim.keymap.set("i", "<C-S>", vim.lsp.buf.signature_help, opts)

          opts.expr = true
          vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if vim.snippet.active() then
              vim.snippet.jump(-1)
            else
              return "<S-Tab>"
            end
          end, opts)
          vim.keymap.set({ "i", "s" }, "<Tab>", function()
            if vim.snippet.active() then
              vim.snippet.jump(1)
            else
              return "<Tab>"
            end
          end, opts)
        end
      })
    end
  },
})
