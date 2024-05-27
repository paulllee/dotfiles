-- keymap set wrapper for only <CMD><CR> styled rhs
local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, "<CMD>" .. rhs .. "<CR>", {
    desc = desc,
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

-- oil
map("n", "-", "Oil")

-- telescope
map("n", "<Leader>f", "Telescope find_files")
map("n", "<Leader>g", "Telescope live_grep")

-- grapple
map("n", "m", "Grapple toggle_tags")
map("n", "M", "Grapple toggle")

-- hop
map("n", "gw", "HopWord")

local M = {}

-- lsp
function M.lsp_mappings(args)
  -- wraps map with lsp buffer
  local function lmap(mode, lhs, rhs, desc)
    map(mode, lhs, rhs, desc, args.buf)
  end

  -- telescope instead of vim builtins
  lmap("n", "gd", "Telescope lsp_definitions")
  lmap("n", "gr", "Telescope lsp_references")

  -- use vim builtin for hover and sig help
  lmap("n", "K", "lua vim.lsp.buf.hover()")
  lmap({ "n", "i" }, "<C-k>", "lua vim.lsp.buf.signature_help()")

  -- renaming and formatting
  lmap("n", "<F2>", "lua vim.lsp.buf.rename()")
  lmap("n", "<F3>", "lua vim.lsp.buf.format()")
end

return M
