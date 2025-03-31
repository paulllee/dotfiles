-- lazy.nvim one time installation

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- settings

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 10
vim.o.undofile = true
vim.o.wrap = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.number = true
vim.wo.relativenumber = true

-- delete gr-defaults

vim.keymap.del("n", "grn")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")

-- configure diagnostics

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = true
})

-- create helpful autocmds

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

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local nmap = function(lhs, cmd)
      vim.keymap.set("n", lhs, cmd, { buffer = ev.buf })
    end
    nmap("gd", vim.lsp.buf.definition)
    nmap("gr", vim.lsp.buf.references)
    nmap("<F2>", vim.lsp.buf.rename)
    nmap("<F3>", vim.lsp.buf.format)
    nmap("<F4>", vim.lsp.buf.code_action)
  end
})

-- configure lsps

local lsps = {
  lua_ls = {},
  pyright = {
    settings = {
      python = {
        analysis = { typeCheckingMode = "off" },
        pythonPath = vim.fn.executable("python3") == 1 and
            vim.fn.exepath("python3") or
            vim.fn.exepath("python")
      }
    }
  },
  markdown_oxide = {}
}
if vim.fn.has("win32") == 1 then
  lsps.omnisharp = {}
end

-- install plugins

require("lazy").setup({
  { "nvim-tree/nvim-web-devicons" },
  { "xiyaowong/virtcolumn.nvim" },
  { "windwp/nvim-autopairs",                     opts = {} },
  { "lewis6991/gitsigns.nvim",                   opts = {} },
  { "nvim-lualine/lualine.nvim",                 opts = {} },
  { "MeanderingProgrammer/render-markdown.nvim", opts = {} },
  { "mcauley-penney/visual-whitespace.nvim",     opts = {} },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-latte]])
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
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" },
      scope = {
        show_start = false,
        show_end = false
      }
    }
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
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      { "saghen/blink.cmp", version = "*", opts = {} },
    },
    config = function()
      local cmp = require("blink.cmp").get_lsp_capabilities()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(lsps),
        handlers = {
          function(name)
            local conf = lsps[name] or {}
            conf.capabilities = cmp
            require("lspconfig")[name].setup(conf)
          end
        }
      })
    end
  }
}, { rocks = { enabled = false } })
