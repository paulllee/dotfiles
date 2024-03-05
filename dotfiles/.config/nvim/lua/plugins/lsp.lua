return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim"
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        sources = {
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" }
        },
        mapping = {
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" })
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "..."
          })
        }
      })

      -- most of my lsps are contained in a conda env named "lsp"
      -- this returns the redundancy for all configs
      local function new_conf(cmd, settings)
        local conf = {}

        conf.capabilities = require("cmp_nvim_lsp").default_capabilities()

        if cmd then
          conf.cmd = { "micromamba", "run", "-n", "lsp" }
          for _, v in ipairs(cmd) do
            table.insert(conf.cmd, v)
          end
        end

        if settings then
          conf.settings = settings
        end

        return conf
      end

      local lspconfig = require("lspconfig")

      lspconfig.bashls.setup(new_conf({ "bash-language-server", "start" }))
      lspconfig.clangd.setup(new_conf())
      lspconfig.cssls.setup(new_conf({ "vscode-css-language-server", "--stdio" }))
      lspconfig.html.setup(new_conf({ "vscode-html-language-server", "--stdio" }))
      lspconfig.jsonls.setup(new_conf({ "vscode-json-language-server", "--stdio" }))
      lspconfig.lua_ls.setup(new_conf())
      lspconfig.pyright.setup(new_conf({ "pyright-langserver", "--stdio" }, {
        python = {
          analysis = {
            -- strict type checking can be a bit of a pain
            typeCheckingMode = "off"
          },
          -- telling pyright what the current python environment is
          pythonPath = vim.fn.exepath("python3")
        }
      }))
      lspconfig.ruff_lsp.setup(new_conf({ "ruff-lsp" }))
      lspconfig.rust_analyzer.setup(new_conf())
      lspconfig.tsserver.setup(new_conf({ "typescript-language-server", "--stdio" }))
    end
  }
}
