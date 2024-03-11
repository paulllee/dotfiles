-- aliases
local ts = require("telescope.builtin")
local ls = require("luasnip")
local lb = vim.lsp.buf

local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    desc = desc,
    buffer = buffer
  })
end

map("n", "<Space>n", "<cmd>:Neotree<cr>", "Neotree")
map("n", "<Space>r", "<cmd>:LspRestart<cr>", "Restart lsp")

map("n", "<Space>b", ts.buffers, "Telescope buffers")
map("n", "<Space>f", ts.find_files, "Telescope find files")
map("n", "<Space>g", ts.live_grep, "Telescope live grep")
map("n", "<Space>o", ts.oldfiles, "Telescope old files")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lmap(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, desc, args.buf)
    end

    lmap("n", "gd", ts.lsp_definitions, "Definitions")
    lmap("n", "gD", ts.diagnostics, "Diagnostics")
    lmap("n", "gi", ts.lsp_implementations, "Implementations")
    lmap("n", "gr", ts.lsp_references, "References")

    lmap("n", "gh", lb.hover, "Hover")
    lmap("n", "gH", lb.signature_help, "Signature help")

    lmap("n", "<Space>F", lb.format, "Format file")
    lmap("n", "<Space>R", lb.rename, "Rename all references")
  end
})

map({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, "LS jump left")
map({ "i", "s" }, "<C-k>", function() ls.jump(1) end, "LS jump right")
