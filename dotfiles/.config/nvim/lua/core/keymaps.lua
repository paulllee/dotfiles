local opts = { noremap = true, silent = true }

vim.keymap.set("n", "-", require("oil").open, opts)

local fzf = require("fzf-lua")
vim.keymap.set("n", "<Leader>f", fzf.files, opts)
vim.keymap.set("n", "<Leader>g", fzf.live_grep, opts)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    opts.buffer = ev.buf

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gf", vim.lsp.buf.format, opts)

    -- getting used to new default keymaps arriving in 0.11
    vim.keymap.set("n", "grr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-S>", vim.lsp.buf.signature_help, opts)

    opts.expr = true
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if vim.snippet.active() then vim.snippet.jump(-1)
      else return "<S-Tab>" end
    end, opts)
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if vim.snippet.active() then vim.snippet.jump(1)
      else return "<Tab>" end
    end, opts)
  end
})
