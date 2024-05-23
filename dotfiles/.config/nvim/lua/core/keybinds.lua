-- vim.keymap.set wrapper for sane defaults
-- `desc` and `buffer` are optional
local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

map("n", "<C-w><C-h>", "<C-w>h")
map("n", "<C-w><C-j>", "<C-w>j")
map("n", "<C-w><C-k>", "<C-w>k")
map("n", "<C-w><C-l>", "<C-w>l")

-- all keybinds in <CMD><CR> format
-- no need to have plugins loaded beforehand
local function cmap(mode, lhs, rhs, desc, buffer)
  map(mode, lhs, "<CMD>" .. rhs .. "<CR>", desc, buffer)
end

cmap("n", "<Leader>e", "Neotree toggle")

cmap("n", "<Leader>f", "FzfLua files")
cmap("n", "<Leader>g", "FzfLua live_grep")

cmap("n", "<C-s>", "Grapple toggle")
cmap("n", ",", "Grapple toggle_tags")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lmap(mode, lhs, rhs, desc)
      cmap(mode, lhs, rhs, desc, args.buf)
    end

    lmap("n", "gh", "lua vim.lsp.buf.hover()")
    lmap("n", "gs", "lua vim.lsp.buf.signature_help()")

    lmap("n", "gd", "FzfLua lsp_definitions")
    lmap("n", "gD", "FzfLua lsp_declarations")
    lmap("n", "gi", "FzfLua lsp_implementations")
    lmap("n", "gr", "FzfLua lsp_references")

    lmap("n", "<F2>", "lua vim.lsp.buf.rename()")
    lmap("n", "<F3>", "lua vim.lsp.buf.format()")
    lmap("n", "<F4>", "FzfLua lsp_code_actions")
  end
})
