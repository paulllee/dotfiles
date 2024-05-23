local specs = {}

local helpers = require("support.helpers")

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
  window = { width = helpers.width }
}

specs.grapple = {
  style = "basename",
  win_opts = {
    width = helpers.width,
    height = helpers.height
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
  ruff_lsp = {
    cmd = { "micromamba", "run", "-n", "lsp", "ruff-lsp" },
    on_attach = helpers.ruff_lsp_on_attach
  },
  rust_analyzer = {},
  tsserver = {}
}

specs.lspkind = {
  mode = "symbol_text",
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
    max_width = helpers.width + 20,
    max_height = helpers.height
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