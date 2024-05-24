local specs = {}

local helpers = require("support.helpers")

local ui_width = 40
local ui_height = 12

specs.default = {}

specs.grapple = {
  style = "basename",
  win_opts = {
    width = ui_width,
    height = ui_height
  }
}

specs.lspkind = {
  mode = "symbol_text",
  maxwidth = ui_width,
  ellipsis_char = "...",
  menu = {
    nvim_lsp = "",
    buffer = ""
  }
}

specs.lsps = {
  clangd = {},
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
  ruff_lsp = { on_attach = helpers.get_on_attach_ruff }
}

specs.lualine = {
  sections = {
    lualine_b = { "branch", "diagnostics" },
    lualine_x = { helpers.get_reg, "filetype" },
    lualine_y = { "grapple" }
  }
}

local noice_size = {
  size = {
    max_width = ui_width,
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

specs.notify = {
  render = "compact",
  stages = "static",
  timeout = 2500
}

specs.oil = {
  view_options = {
    show_hidden = true,
    is_always_hidden = helpers.get_always_hidden
  },
  float = {
    max_width = ui_width,
    max_height = ui_height
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

specs.telescope = {
  pickers = {
    find_files = {
      find_command = { "fd", "--hidden", "--type", "f" }
    },
    live_grep = {
      additional_args = { "--hidden", "--glob=!.git" }
    }
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
