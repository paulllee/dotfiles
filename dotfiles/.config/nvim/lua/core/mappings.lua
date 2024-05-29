-- returns rhs as <CMD>rhs<CR>
local function cmd(rhs)
  return "<CMD>" .. rhs .. "<CR>"
end

-- vim.keymap.set with sane defaults
local function map(mode, lhs, rhs, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

-- oil
map("n", "-", cmd("Oil"))

-- telescope
map("n", "<Leader>f", cmd("Telescope find_files"))
map("n", "<Leader>g", cmd("Telescope live_grep"))

local M = {}

-- lsp
function M.lsp_mappings(args)
  -- adds lsp buffer to mappings
  local function lmap(mode, lhs, rhs)
    map(mode, lhs, rhs, args.buf)
  end

  -- telescope instead of vim lsp builtins
  lmap("n", "gd", cmd("Telescope lsp_definitions"))
  lmap("n", "gr", cmd("Telescope lsp_references"))

  -- vim lsp builtins
  local lsp = vim.lsp.buf
  lmap({ "n", "i" }, "<C-k>", lsp.signature_help)
  lmap("n", "<F2>", lsp.rename)
  lmap("n", "<F3>", lsp.format)
end

return M
