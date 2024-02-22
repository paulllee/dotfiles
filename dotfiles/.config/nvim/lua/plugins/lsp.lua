local function copy_tbl(orig)
  local new = {}
  for k, v in pairs(orig) do new[k] = v end
  return new
end

local function append_tbl(tbl, ...)
  for _, v in ipairs({ ... }) do table.insert(tbl, v) end
end

local mmr = { "micromamba", "run", "-n", "lsp" }

local bashls_conf = { cmd = copy_tbl(mmr) }
append_tbl(bashls_conf.cmd, "bash-language-server", "start")

local cssls_conf = { cmd = copy_tbl(mmr) }
append_tbl(cssls_conf.cmd, "vscode-css-language-server", "--stdio")

local html_conf = { cmd = copy_tbl(mmr) }
append_tbl(html_conf.cmd, "vscode-html-language-server", "--stdio")

local jsonls_conf = { cmd = copy_tbl(mmr) }
append_tbl(jsonls_conf.cmd, "vscode-json-language-server", "--stdio")

local pyright_conf = { cmd = copy_tbl(mmr) }
append_tbl(pyright_conf.cmd, "pyright-langserver", "--stdio")

-- tell pyright to use conda environment if activated
local conda_prefix = os.getenv("CONDA_PREFIX")
if conda_prefix ~= nil then
  pyright_conf.settings = {
    python = { pythonPath = conda_prefix .. "/bin/python" }
  }
end

local ruff_lsp_conf = { cmd = copy_tbl(mmr) }
append_tbl(ruff_lsp_conf.cmd, "ruff-lsp")

local tsserver_conf = { cmd = copy_tbl(mmr) }
append_tbl(tsserver_conf.cmd, "typescript-language-server", "--stdio")

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup(bashls_conf)
      lspconfig.clangd.setup({})
      lspconfig.cssls.setup(cssls_conf)
      lspconfig.html.setup(html_conf)
      lspconfig.jsonls.setup(jsonls_conf)
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup(pyright_conf)
      lspconfig.ruff_lsp.setup(ruff_lsp_conf)
      lspconfig.rust_analyzer.setup({})
      lspconfig.tsserver.setup(tsserver_conf)
    end
  },

  {
    "echasnovski/mini.completion",
    config = function()
      require("mini.completion").setup()
    end
  }
}
