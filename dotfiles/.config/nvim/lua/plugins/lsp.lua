return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local function get_conf(cmd, settings)
        local new_conf = {}

        new_conf.capabilities = require("cmp_nvim_lsp").default_capabilities()

        if cmd then
          new_conf.cmd = { "micromamba", "run", "-n", "lsp" }
          for _, arg in ipairs(cmd) do
            table.insert(new_conf.cmd, arg)
          end
        end

        if settings then
          new_conf.settings = settings
        end

        return new_conf
      end

      local confs = {
        bashls = get_conf({ "bash-language-server", "start" }),
        clangd = get_conf(),
        cssls = get_conf({ "vscode-css-language-server", "--stdio" }),
        html = get_conf({ "vscode-html-language-server", "--stdio" }),
        jsonls = get_conf({ "vscode-jsonls-language-server", "--stdio" }),
        lua_ls = get_conf(),
        pyright = get_conf(
          { "pyright-langserver", "--stdio" },
          {
            python = {
              analysis = {
                -- strict type checking can be a bit of a pain
                typeCheckingMode = "off"
              },
              -- telling pyright what the current python environment is
              pythonPath = vim.fn.exepath("python3")
            }
          }
        ),
        ruff_lsp = get_conf({ "ruff-lsp" }),
        rust_analyzer = get_conf(get_conf()),
        tsserver = get_conf({ "typescript-language-server", "--stdio" })
      }

      for name, conf in pairs(confs) do
        require("lspconfig")[name].setup(conf)
      end
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
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
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" }
        },
        mapping = {
          ["<C-y>"] = cmp.mapping.confirm({ select = false }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
          ["<C-d>"] = cmp.mapping.scroll_docs(5),
          ["<C-u>"] = cmp.mapping.scroll_docs(-5)
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end
        },
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol_text",
            menu = {
              nvim_lsp = "[LSP]",
              buffer = "[BUF]",
              path = "[PATH]"
            },
            maxwidth = 50,
            ellipsis_char = "..."
          })
        }
      })
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        doc_lines = 0,
        maxwidth = 50,
        hint_enable = false
      })
    end
  }
}
