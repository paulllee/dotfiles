require("core.options")
require("core.plugins")
require("core.mappings")

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    local status, _ = pcall(function()
      vim.cmd([[%s/\s\+$//g]])
    end)
    if status then
      vim.notify("Removed trailing whitespace[s]")
    end
    vim.fn.winrestview(save)
  end
})
