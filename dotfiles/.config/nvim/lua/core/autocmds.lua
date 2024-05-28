-- delete all trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    local status, _ = pcall(function()
      vim.cmd([[%s/\s\+$//g]])
    end)
    if status then
      vim.notify("removed trailing whitespace[s]")
    end
    vim.fn.winrestview(save)
  end
})

-- lsp specific things
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    require("core.mappings").lsp_mappings(args)
    vim.notify("attached lsp with keymaps")
  end
})
