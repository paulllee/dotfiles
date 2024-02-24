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
  },
  {
    "echasnovski/mini.comment",
    config = function()
      require("mini.comment").setup()
    end
  },
  {
    "echasnovski/mini.pairs",
    config = function()
      require("mini.pairs").setup()
    end
  },
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end
  }
}
