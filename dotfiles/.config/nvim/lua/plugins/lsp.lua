local function copy_tbl(orig)
  local new = {}
  for k, v in pairs(orig) do new[k] = v end
  return new
end

local function append_tbl(tbl, ...)
  for _, v in ipairs({ ... }) do table.insert(tbl, v) end
end

local cmd_template = { "micromamba", "run", "-n", "lsp" }

local bashls = { cmd = copy_tbl(cmd_template) }
append_tbl(bashls.cmd, "bash-language-server", "start")

local cssls = { cmd = copy_tbl(cmd_template) }
append_tbl(cssls.cmd, "vscode-css-language-server", "--stdio")

local html = { cmd = copy_tbl(cmd_template) }
append_tbl(html.cmd, "vscode-html-language-server", "--stdio")

local jsonls = { cmd = copy_tbl(cmd_template) }
append_tbl(jsonls.cmd, "vscode-json-language-server", "--stdio")

local pyright = { cmd = copy_tbl(cmd_template) }
append_tbl(pyright.cmd, "pyright-langserver", "--stdio")

-- tell pyright to use conda environment if activated
local conda_prefix = os.getenv("CONDA_PREFIX")
if conda_prefix ~= nil then
  pyright.settings = {
    python = { pythonPath = conda_prefix .. "/bin/python" }
  }
end

local ruff_lsp = { cmd = copy_tbl(cmd_template) }
append_tbl(ruff_lsp.cmd, "ruff-lsp")

local tsserver = { cmd = copy_tbl(cmd_template) }
append_tbl(tsserver.cmd, "typescript-language-server", "--stdio")

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup(bashls)
      lspconfig.clangd.setup({})
      lspconfig.cssls.setup(cssls)
      lspconfig.html.setup(html)
      lspconfig.jsonls.setup(jsonls)
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup(pyright)
      lspconfig.ruff_lsp.setup(ruff_lsp)
      lspconfig.rust_analyzer.setup({})
      lspconfig.tsserver.setup(tsserver)
    end
  },

  {
    "echasnovski/mini.completion",
    config = function()
      require("mini.completion").setup()
    end
  }
}
