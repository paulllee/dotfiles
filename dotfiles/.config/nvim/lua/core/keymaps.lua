local function map(mode, lhs, rhs, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

local oil = require("oil")
local fzf = require("fzf-lua")

map({ "i", "s" }, "<C-h>", function() vim.snippet.jump(-1) end)
map({ "i", "s" }, "<C-l>", function() vim.snippet.jump(1) end)

map("n", "-", oil.open)

map("n", "<Leader>f", fzf.files)
map("n", "<Leader>g", fzf.live_grep)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    map("n", "gd", fzf.lsp_definitions, ev.buf)
    map("n", "gr", fzf.lsp_references, ev.buf)
    map("n", "<F2>", vim.lsp.buf.rename, ev.buf)
    map("n", "<F3>", vim.lsp.buf.format, ev.buf)
    map("n", "<F4>", fzf.lsp_code_actions, ev.buf)
    map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, ev.buf)
  end
})
