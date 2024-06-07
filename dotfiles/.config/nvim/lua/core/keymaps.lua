local function map(mode, lhs, rhs, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

local oil = require("oil")
local fzf = require("fzf-lua")

map("n", "-", oil.open)

map("n", "<Leader>f", fzf.files)
map("n", "<Leader>g", fzf.live_grep)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    map("n", "gd", fzf.lsp_definitions, ev.buf)
    map("n", "gf", vim.lsp.buf.format, ev.buf)
    map("n", "grr", fzf.lsp_references, ev.buf)
    map("n", "grn", vim.lsp.buf.rename, ev.buf)
    map("i", "<C-S>", vim.lsp.buf.signature_help, ev.buf)
  end
})
