vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "json", "ps1", "python" },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end
})

vim.o.clipboard = "unnamedplus"
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.scrolloff = 10
vim.o.smartcase = true
vim.o.undofile = true
vim.o.wrap = false

vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd([[colorscheme catppuccin-mocha]])

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end
})
