-- using which-key for my keybinds
local wk = require("which-key")

-- using telescope for searching through lsp info
local builtin = require("telescope.builtin")

local mappings = {}
local opts = { prefix = "<space>" }

mappings.t = {
  name = "[T]elescope",
  f = { builtin.find_files, "[F]iles" },
  g = { builtin.live_grep, "[G]rep" }
}
wk.register(mappings, opts)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    opts.buffer = args.buf
    mappings.c = {
      name = "[C]ode",
      a = { vim.lsp.buf.code_action, "[A]ction" }
    }
    mappings.d = {
     name = "[D]iagnostic",
      o = { vim.diagnostic.open_float, "[O]pen" },
      p = { vim.diagnostic.goto_prev, "[P]revious" },
      n = { vim.diagnostic.goto_next, "[N]ext" }
    }
    mappings.f = { vim.lsp.buf.format, "[F]ormat" }
    mappings.g = {
      name = "[G]o To",
      D = { vim.lsp.buf.declaration, "[^D]eclaration" },
      d = { vim.lsp.buf.definition, "[_D]efinition" },
      i = { vim.lsp.buf.implementation, "[I]mplementation" },
      t = { vim.lsp.buf.type_definition, "[T]ype Definition" },
      h = { vim.lsp.buf.hover, "[H]over" },
      s = { vim.lsp.buf.signature_help, "[S]ignature Help" }
    }
    mappings.r = { vim.lsp.buf.rename, "[R]ename All References" }
    mappings.t = {
      d = { builtin.diagnostics, "[D]iagnostics" },
      r = { builtin.lsp_references, "[R]eferences" }
    }
    mappings.w = {
      name = "[W]orkspace",
      a = { vim.lsp.buf.add_workspace_folder, "[A]dd" },
      r = { vim.lsp.buf.remove_workspace_folder, "[R]emove" },
      l = {
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, "[L]ist"
      }
    }
    wk.register(mappings, opts)
  end
})
