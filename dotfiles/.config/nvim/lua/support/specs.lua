local specs = {}

local helpers = require("support.helpers")

specs.default = {}

specs.grapple = {
  style = "basename",
  win_opts = {
    width = 30,
    height = 12
  }
}

specs.lspkind = {
  mode = "symbol_text",
  maxwidth = 50,
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
  window = { width = 30 }
}

local noice_size = {
  size = {
    max_width = 50,
    max_height = 12
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
