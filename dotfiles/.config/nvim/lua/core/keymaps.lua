local function map(mode, lhs, rhs, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

map({ "i", "s" }, "<C-h>", function() vim.snippet.jump(-1) end)
map({ "i", "s" }, "<C-l>", function() vim.snippet.jump(1) end)

map("n", "-", "<CMD>Oil<CR>")

map("n", "<Leader>f", "<CMD>FzfLua files<CR>")
map("n", "<Leader>g", "<CMD>FzfLua live_grep<CR>")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    map("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", ev.buf)
    map("n", "gr", "<CMD>FzfLua lsp_references<CR>", ev.buf)

    map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, ev.buf)

    map("n", "<Leader>r", vim.lsp.buf.rename, ev.buf)
  end
})
