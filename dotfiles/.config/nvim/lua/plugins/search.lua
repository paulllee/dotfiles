return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            find_command = { "fd", "--hidden", "--type", "f" }
          },
          live_grep = {
            additional_args = { "--hidden", "--glob=!.git" }
          }
        }
      })
    end
  }
}
