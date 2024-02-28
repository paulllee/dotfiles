local function default_conf(...)
  local new_conf = {}

  -- if no arguments are provided, return an empty conf
  if select("#", ...) == 0 then
    return new_conf
  end

  -- if arguments are provided, append to cmd that uses lsp env
  new_conf.cmd = { "micromamba", "run", "-n", "lsp" }
  for _, v in ipairs({ ... }) do
    table.insert(new_conf.cmd, v)
  end
  return new_conf
end

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup(default_conf("bash-language-server", "start"))
      lspconfig.clangd.setup(default_conf())
      lspconfig.cssls.setup(default_conf("vscode-css-language-server", "--stdio"))
      lspconfig.html.setup(default_conf("vscode-html-language-server", "--stdio"))
      lspconfig.jsonls.setup(default_conf("vscode-json-language-server", "--stdio"))
      lspconfig.lua_ls.setup(default_conf())

      local pyright_conf = default_conf("pyright-langserver", "--stdio")
      pyright_conf.settings = {
        python = {
          analysis = {
            -- strict type checking can be a bit of a pain
            typeCheckingMode = "off"
          },
          -- telling pyright what the current python environment is
          pythonPath = vim.fn.exepath("python3")
        }
      }
      lspconfig.pyright.setup(pyright_conf)

      lspconfig.ruff_lsp.setup(default_conf("ruff-lsp"))
      lspconfig.rust_analyzer.setup(default_conf())
      lspconfig.tsserver.setup(default_conf("typescript-language-server", "--stdio"))
    end
  },

  {
    "echasnovski/mini.completion",
    config = function()
      require("mini.completion").setup()
    end
  }
}
