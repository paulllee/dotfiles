-- settings

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

vim.o.clipboard = "unnamedplus"
vim.o.scrolloff = 10
vim.o.undofile = true
vim.o.wrap = false

vim.o.ignorecase = true
vim.o.smartcase = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.o.colorcolumn = "80"
    vim.o.textwidth = 80
  end
})

vim.wo.number = true
vim.wo.relativenumber = true

-- mappings

local ndel = function(lhs)
  vim.keymap.del("n", lhs)
end

ndel("grn")
ndel("gra")
ndel("grr")
ndel("gri")
ndel("grt")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local nmapb = function(lhs, cmd)
      vim.keymap.set("n", lhs, cmd, { buffer = ev.buf })
    end
    nmapb("gd", vim.lsp.buf.definition)
    nmapb("gr", vim.lsp.buf.references)
    nmapb("gt", vim.lsp.buf.type_definition)
    nmapb("cr", vim.lsp.buf.rename)
    nmapb("cf", vim.lsp.buf.format)
    nmapb("ca", vim.lsp.buf.code_action)
  end
})

local nmap = function(lhs, cmd)
  vim.keymap.set("n", lhs, cmd)
end

nmap("<leader><leader>", function()
  local save_pos = vim.fn.winsaveview()
  -- remove trailing whitespace
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.winrestview(save_pos)
end)

-- lsps/diagnostics

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
  markdown_oxide = {},
  vtsls = {}
}
if vim.fn.has("win32") == 1 then
  lsps.omnisharp = {}
end

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  virtual_text = true
})

-- packages

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

require("lazy").setup({
  { "nvim-tree/nvim-web-devicons" },
  { "windwp/nvim-autopairs",      opts = {} },
  { "lewis6991/gitsigns.nvim",    opts = {} },
  { "nvim-lualine/lualine.nvim",  opts = {} },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({ contrast = "bold" })
      vim.cmd([[colorscheme gruvbox]])
    end
  },
  {
    "stevearc/oil.nvim",
    keys = {
      { "-", ":Oil<cr>", noremap = true }
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
      { "<Leader>d", ":FzfLua diagnostics_workspace<cr>" },
      { "<Leader>f", ":FzfLua files<cr>" },
      { "<Leader>g", ":FzfLua live_grep<cr>" }
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
        indent = {
          enable = true,
          disable = { "markdown" }
        }
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
