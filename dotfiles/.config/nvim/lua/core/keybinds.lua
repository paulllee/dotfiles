-- vim.keymap.set wrapper with sane defaults
local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

-- all rhs default to <CMD>rhs<CR> format
local function cmap(mode, lhs, rhs, desc, buffer)
  map(mode, lhs, "<CMD>" .. rhs .. "<CR>", desc, buffer)
end

-- to go between windows more conveniently
map("n", "<C-w><C-h>", "<C-w>h")
map("n", "<C-w><C-j>", "<C-w>j")
map("n", "<C-w><C-k>", "<C-w>k")
map("n", "<C-w><C-l>", "<C-w>l")

cmap("n", "<Leader>e", "Neotree toggle")

cmap("n", "<Leader>f", "Telescope find_files")
cmap("n", "<Leader>g", "Telescope live_grep")

cmap("n", "<C-s>", "Grapple toggle")
cmap("n", ",", "Grapple toggle_tags")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- wraps cmap for lsp keybinds
    local function lmap(mode, lhs, rhs, desc)
      cmap(mode, lhs, rhs, desc, args.buf)
    end

    lmap("n", "gh", "lua vim.lsp.buf.hover()")
    lmap("n", "gs", "lua vim.lsp.buf.signature_help()")

    lmap("n", "gd", "Telescope lsp_definitions")
    lmap("n", "gr", "Telescope lsp_references")

    lmap("n", "<Leader>R", "lua vim.lsp.buf.rename()")
    lmap("n", "<Leader>F", "lua vim.lsp.buf.format()")
  end
})
