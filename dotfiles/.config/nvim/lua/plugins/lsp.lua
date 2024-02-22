local bashls_conf = {
  cmd = { "micromamba", "run", "-n", "lsp", "bash-language-server", "start" }
}

local html_conf = {
  cmd = { "micromamba", "run", "-n", "lsp", "vscode-html-language-server", "--stdio" }
}

local pyright_conf = {
  cmd = { "micromamba", "run", "-n", "lsp", "pyright-langserver", "--stdio" }
}

-- tell pyright to use conda environment if activated
local conda_prefix = os.getenv("CONDA_PREFIX")
if conda_prefix ~= nil then
  pyright_conf.settings = {
    python = { pythonPath = conda_prefix .. "/bin/python" }
  }
end

local ruff_lsp_conf = {
  cmd = { "micromamba", "run", "-n", "lsp", "ruff-lsp" }
}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup(bashls_conf)
      lspconfig.clangd.setup({})
      lspconfig.html.setup(html_conf)
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup(pyright_conf)
      lspconfig.ruff_lsp.setup(ruff_lsp_conf)
    end
  },

  {
    "echasnovski/mini.completion",
    config = function()
      require("mini.completion").setup()
    end
  }
}
