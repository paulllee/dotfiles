local function map(mode, lhs, rhs, buffer)
  vim.keymap.set(mode, lhs, rhs, {
    buffer = buffer,
    noremap = true,
    silent = true
  })
end

local oil = require("oil")
local fzf = require("fzf-lua")

map("n", "-", oil.open)

map("n", "<Leader>f", fzf.files)
map("n", "<Leader>g", fzf.live_grep)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    map("n", "gd", fzf.lsp_definitions, ev.buf)
    map("n", "gf", vim.lsp.buf.format, ev.buf)

    -- TODO: get used to upcoming new defaults in >0.10. remove once it is
    --       in a stable release. maybe keep the fzf mappings as i perfer
    --       fzf over default
    map({ "i", "s" }, "<Tab>", function() vim.snippet.jump(1) end, ev.buf)
    map({ "i", "s" }, "<S-Tab>", function() vim.snippet.jump(-1) end, ev.buf)
    map("n", "grn", vim.lsp.buf.rename, ev.buf)
    map("n", "grr", fzf.lsp_references, ev.buf)
    map("n", "gra", fzf.lsp_code_actions, ev.buf)
    map("i", "<C-S>", vim.lsp.buf.signature_help, ev.buf)
  end
})
