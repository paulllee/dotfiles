vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.o.colorcolumn = "80"
    vim.o.textwidth = 80
  end
})

vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 10
vim.o.undofile = true
vim.o.wrap = false

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
  { "xiyaowong/virtcolumn.nvim" },
  { "windwp/nvim-autopairs",                     opts = {} },
  { "lewis6991/gitsigns.nvim",                   opts = {} },
  { "nvim-lualine/lualine.nvim",                 opts = {} },
  { "MeanderingProgrammer/render-markdown.nvim", opts = {} },
  {
    "saghen/blink.cmp",
    -- use latest release for pre-built binaries
    version = "*",
    opts = {}
  },
  {
    "scottmckendry/cyberdream.nvim",
    config = function()
      vim.cmd([[colorscheme cyberdream]])
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
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp",
    },
    branch = "v4.x",
    config = function()
      local lsp_zero = require("lsp-zero")

      local lsp_attach = function(_, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "marksman" },
        handlers = {
          function(lsp)
            require("lspconfig")[lsp].setup({
              capabilities = require("blink.cmp").get_lsp_capabilities()
            })
          end,
          pyright = function()
            require("lspconfig").pyright.setup({
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
            })
          end,
          marksman = function()
            require("lspconfig").marksman.setup({
              on_attach = function(c, _)
                c.server_capabilities.semanticTokensProvider = nil
              end
            })
          end
        }
      })
    end
  }
}, { rocks = { enabled = false } })
