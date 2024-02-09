-- format on `:w`
vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = vim.fn.bufnr(),
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 3000 })
    end,
})
