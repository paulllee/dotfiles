return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false,
            never_show = { ".git" }
          }
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(_)
              require("neo-tree.command").execute({
                action = "close"
              })
            end
          },
        }
      })
    end
  },
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
