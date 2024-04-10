-- all keybinds in <cmd><cr> format
-- no need to have plugins loaded beforehand
-- `desc` and `buffer` are optional
local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, "<cmd>" .. rhs .. "<cr>", {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

map("n", "<Leader>e", "NvimTreeToggle", "Toggle explorer")
map("n", "<Leader>r", "LspRestart", "Restart server")

map("n", "<Leader>f", "Telescope find_files", "Search files")
map("n", "<Leader>g", "Telescope live_grep", "Grep files")

map("n", ",", "Grapple toggle_tags", "Grapple menu")
map("n", "<C-s>", "Grapple toggle", "Toggle tag file")
map("n", "H", "Grapple cycle_tags prev", "Go to previous tag")
map("n", "L", "Grapple cycle_tags next", "Go to next tag")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lmap(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, desc, args.buf)
    end

    lmap("n", "gd", "Telescope lsp_definitions", "Definitions")
    lmap("n", "gD", "Telescope diagnostics", "Diagnostics")
    lmap("n", "gi", "Telescope lsp_implementations", "Implementations")
    lmap("n", "gr", "Telescope lsp_references", "References")

    lmap("n", "gh", "lua vim.lsp.buf.hover()", "Hover")
    lmap("n", "gs", "lua vim.lsp.buf.signature_help()", "Signature")

    lmap("n", "<Leader>F", "lua vim.lsp.buf.format()", "Format")
    lmap("n", "<Leader>R", "lua vim.lsp.buf.rename()", "Rename")
  end
})
