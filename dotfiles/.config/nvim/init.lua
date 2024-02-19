-- checks if an environment is activated and sets it as the path
local conda_prefix = os.getenv("CONDA_PREFIX")
local python_path = conda_prefix == nil and "python" or conda_prefix .. "/bin/python"

-- options (sorted a-z)
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

-- plugins via https://github.com/echasnovski/mini.nvim :)
local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path,
  })
  vim.cmd("packadd mini.nvim | helptags ALL")
end

require("mini.deps").setup()
local add = MiniDeps.add

add("catppuccin/nvim")
vim.cmd.colorscheme "catppuccin-mocha"

require("mini.comment").setup()
require("mini.completion").setup()

add({
  source = "nvim-lualine/lualine.nvim",
  depends = { "nvim-tree/nvim-web-devicons" }
})
require("lualine").setup()

add("lewis6991/gitsigns.nvim")
require("gitsigns").setup()

add({
  source = "nvim-telescope/telescope.nvim",
  checkout = "0.1.x",
  depends = { "nvim-lua/plenary.nvim" }
})
require("telescope").setup()

add({
  source = "nvim-treesitter/nvim-treesitter",
  hooks = { 
    post_checkout = function()
      vim.cmd("TSUpdate")
    end
  }
})
 require("nvim-treesitter.configs").setup({
  ensure_installed = "all",
  highlight = { enable = true }
})

add("neovim/nvim-lspconfig")
require("lspconfig").pyright.setup({
  cmd = { "micromamba", "run", "-n", "lsp", "pyright-langserver", "--stdio" },
  settings = { python = { pythonPath = python_path } }
})
require("lspconfig").ruff_lsp.setup({
  cmd = { "micromamba", "run", "-n", "lsp", "ruff-lsp" }
})
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = vim.fn.bufnr(),
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
  end
})

add("folke/which-key.nvim")

local wk = require("which-key")
wk.setup()

local mappings = {}
local opts = { prefix = "<space>" }
mappings.t = {
  name = "[T]elescope",
  f = { "<cmd>Telescope find_files find_command=fd,--hidden,--type,f<cr>", "Find [F]iles" },
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
