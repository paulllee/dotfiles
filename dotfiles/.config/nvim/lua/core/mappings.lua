local function cmd(rhs)
  return "<CMD>" .. rhs .. "<CR>"
end

local function map(mode, lhs, rhs, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

map({ "i", "s" }, "<C-j>", function() vim.snippet.jump(-1) end)
map({ "i", "s" }, "<C-k>", function() vim.snippet.jump(1) end)

map("n", "-", cmd("Oil"))

map("n", "<Leader>f", cmd("Telescope find_files"))
map("n", "<Leader>g", cmd("Telescope live_grep"))

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lmap(mode, lhs, rhs)
      map(mode, lhs, rhs, args.buf)
    end

    lmap("n", "gd", cmd("Telescope lsp_definitions"))
    lmap("n", "gr", cmd("Telescope lsp_references"))

    lmap({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help)
    lmap("n", "<F2>", vim.lsp.buf.rename)
    lmap("n", "<F3>", vim.lsp.buf.format)
  end
})
