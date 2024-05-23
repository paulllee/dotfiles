local specs = {}

local helpers = require("support.helpers")

local ui_width = 30
local ui_height = 12

specs.default = {}

specs.neotree = {
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_hidden = false,
      never_show = { ".git" }
    }
  },
  window = { width = ui_width }
}

specs.grapple = {
  style = "basename",
  win_opts = {
    width = ui_width,
    height = ui_height
  }
}

specs.lsps = {
  bashls = {},
  clangd = {},
  cssls = {},
  html = {},
  jsonls = {},
  lua_ls = {},
  pyright = {
    settings = {
      python = {
        analysis = { typeCheckingMode = "off" },
        pythonPath = helpers.get_python_path()
      }
    }
  },
  ruff_lsp = { on_attach = helpers.ruff_lsp_on_attach },
  rust_analyzer = {},
  tsserver = {}
}

specs.lspkind = {
  mode = "symbol_text",
  maxwidth = ui_width + 20,
  ellipsis_char = "...",
  menu = {
    nvim_lsp = "",
    buffer = ""
  }
}

specs.snippy = {
  mappings = {
    is = {
      ["<Tab>"] = "next",
      ["<S-Tab>"] = "previous"
    }
  }
}

local noice_size = {
  size = {
    max_width = ui_width + 20,
    max_height = ui_height
  }
}
specs.noice = {
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true
    },
    hover = { opts = noice_size },
    signature = { opts = noice_size }
  },
  presets = {
    command_palette = true,
    lsp_doc_border = true
  }
}

specs.lualine = {
  sections = {
    lualine_b = { "branch", "diagnostics" },
    lualine_x = { helpers.get_reg, "filetype" },
    lualine_y = { "grapple" }
  }
}

specs.toggleterm = {
  direction = "float",
  open_mapping = [[<C-\>]],
  persist_mode = true
}

specs.treesitter = {
  ensure_installed = {
    -- the following should always be installed
    "c",
    "lua",
    "vim",
    "vimdoc",
    "query",

    -- the following is required by noice.nvim
    "regex",
    "bash",
    "markdown",
    "markdown_inline"
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = { enable = true }
}

return specs
