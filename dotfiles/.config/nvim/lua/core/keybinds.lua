local function map(mode, lhs, rhs, desc, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    desc = desc,
    buffer = buffer
  })
end

local builtin = require("telescope.builtin")

map("n", "<Space>n", "<cmd>:Neotree<cr>", "Neotree")
map("n", "<Space>r", "<cmd>:LspRestart<cr>", "Restart server")

map("n", "<Space>b", builtin.buffers, "Telescope buffers")
map("n", "<Space>f", builtin.find_files, "Telescope find files")
map("n", "<Space>g", builtin.live_grep, "Telescope live grep")
map("n", "<Space>o", builtin.oldfiles, "Telescope old files")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local function lsp_map(mode, lhs, rhs, desc)
      map(mode, lhs, rhs, desc, args.buf)
    end

    local lsp_buf = vim.lsp.buf

    lsp_map("n", "gd", builtin.lsp_definitions, "Definitions")
    lsp_map("n", "gD", builtin.diagnostics, "Diagnostics")
    lsp_map("n", "gi", builtin.lsp_implementations, "Implementations")
    lsp_map("n", "gr", builtin.lsp_references, "References")

    lsp_map("n", "gh", lsp_buf.hover, "Hover")
    lsp_map("n", "gH", lsp_buf.signature_help, "Signature help")

    lsp_map("n", "<Space>F", lsp_buf.format, "Format file")
    lsp_map("n", "<Space>R", lsp_buf.rename, "Rename all references")
  end
})

local ls = require("luasnip")

map({ "i", "s" }, "<C-j>", function() ls.jump(-1) end, "LS Jump left")
map({ "i", "s" }, "<C-k>", function() ls.jump(1) end, "LS Jump right")
