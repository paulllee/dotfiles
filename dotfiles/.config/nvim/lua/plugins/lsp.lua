local bashls_conf = {
  cmd = { "micromamba", "run", "-n", "lsp", "bash-language-server", "start" }
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
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup(pyright_conf)
      lspconfig.ruff_lsp.setup(ruff_lsp_conf)
      lspconfig.rust_analyzer.setup({})
    end
  },

  {
    "echasnovski/mini.completion",
    config = function()
      require("mini.completion").setup()
    end
  }
}
