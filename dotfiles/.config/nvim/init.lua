-- checks if an environment is activated and sets it as the path
local conda_prefix = os.getenv("CONDA_PREFIX")
local python_path = conda_prefix == nil and "python" or conda_prefix .. "/bin/python"

-- options (sorted a-z)
vim.g.mapleader = " "
vim.g.maplocaleader = " "
vim.g.python_host_prog = python_path
vim.g.python3_host_prog = python_path

vim.o.breakindent = true
vim.o.clipboard = "unnamedplus"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.wo.number = true
vim.wo.relativenumber = true

-- plugins
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

local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.comment").setup()
      require("mini.completion").setup()
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            find_command = { "fd", "--hidden", "--type", "f" }
          },
          live_grep = {
            additional_args = function(_)
              return {"--hidden", "--glob=!.git"}
            end
          }
        }
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        highlight = { enable = true }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.pyright.setup({
        cmd = { "micromamba", "run", "-n", "lsp", "pyright-langserver", "--stdio" },
        settings = { python = { pythonpath = python_path } }
      })
      lspconfig.ruff_lsp.setup({
        cmd = { "micromamba", "run", "-n", "lsp", "ruff-lsp" }
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = vim.fn.bufnr(),
        callback = function()
          vim.lsp.buf.format({ timeout_ms = 3000 })
        end
      })
    end
  },
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup()

      local mappings = {}
      local opts = { prefix = "<space>" }
      mappings.t = {
        name = "[T]elescope",
        f = { "<cmd>Telescope find_files<cr>", "Find [F]iles" },
        g = { "<cmd>Telescope live_grep<cr>", "Live [G]rep" }
      }
      wk.register(mappings, opts)

      vim.api.nvim_create_autocmd({ "LspAttach" }, {
        callback = function()
          mappings.d = {
            name = "[D]iagnostic",
            o = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[O]pen Diagnostic" },
            n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[N]ext Diagnostic" },
            p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[P]revious Diagnostic" }
          }
          mappings.g = {
            name = "[G]o To",
            d = { vim.lsp.buf.definition, "Go to [D]efinition" },
            t = { vim.lsp.buf.type_definition, "Go to [T]ype Definition" }
          }
          mappings.t = {
            d = { "<cmd>Telescope diagnostics<cr>", "Telescope [D]iagnostics" },
            r = { require("telescope.builtin").lsp_references, "Telescope [R]eferences" }
          }
          wk.register(mappings, opts)
        end
      })
    end
  }
}

require("lazy").setup(plugins)
