-- using which-key for my keybinds
local wk = require("which-key")

-- using telescope for searching through lsp info
local builtin = require("telescope.builtin")

local mappings = {}
local opts = { prefix = "<space>" }

mappings.l = {
  name = "[L]sp",
  i = { "<cmd>:LspInfo<cr>", "[I]nfo" },
  r = { "<cmd>:LspRestart<cr>", "[_R]estart" }
}

mappings.n = {
  name = "[N]eo-tree",
  e = { "<cmd>:Neotree<cr>", "[E]xplorer" },
  b = { "<cmd>:Neotree buffers<cr>", "[B]uffer" }
}

mappings.g = {
  name = "[G]o To",
  b = { builtin.buffers, "[B]uffer" },
  f = { builtin.find_files, "[F]iles" },
  g = { builtin.live_grep, "[G]rep" },
  o = { builtin.oldfiles, "[O]ld Files" }
}

wk.register(mappings, opts)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    opts.buffer = args.buf
    mappings.g = {
      d = { builtin.lsp_definitions, "[_D]efinition" },
      D = { builtin.diagnostics, "[^D]iagnostics" },
      h = { vim.lsp.buf.hover, "[H]over" },
      i = { builtin.lsp_implementations, "[I]mplementation" },
      r = { builtin.lsp_references, "[R]eferences" },
      s = { vim.lsp.buf.signature_help, "[S]ignature Help" },
      t = { builtin.lsp_type_definitions, "[T]ype Definition" }
    }
    mappings.l = {
      f = { vim.lsp.buf.format, "[F]ormat" },
      R = { vim.lsp.buf.rename, "[^R]ename All References" }
    }
    wk.register(mappings, opts)
  end
})
