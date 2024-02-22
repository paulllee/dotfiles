return {
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
