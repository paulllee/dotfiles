-- keymap set wrapper for only <CMD><CR> styled rhs
local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, "<CMD>" .. rhs .. "<CR>", {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

-- clear highlight from pattern after search
map("n", "<Leader>q", "noh")

-- delete all trailing whitespace
map("n", "<Leader>w", [[%s/\s\+$//]])

-- oil in floating window
map("n", "<Leader>e", "Oil --float")

-- telescope
map("n", "<Leader>f", "Telescope find_files")
map("n", "<Leader>g", "Telescope live_grep")

-- grapple
map("n", ",", "Grapple toggle_tags")
map("n", "<C-s>", "Grapple toggle")

-- lsp
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- lsp specific map function
    local function lmap(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, desc, args.buf)
    end

    -- telescope instead of vim builtin funcs
    lmap("n", "gd", "Telescope lsp_definitions")
    lmap("n", "gr", "Telescope lsp_references")

    -- use vim builtin for hover and sig help
    lmap("n", "gh", "lua vim.lsp.buf.hover()")
    lmap("n", "gs", "lua vim.lsp.buf.signature_help()")

    -- renaming and formatting
    lmap("n", "<Leader>R", "lua vim.lsp.buf.rename()")
    lmap("n", "<Leader>F", "lua vim.lsp.buf.format()")
  end
})
