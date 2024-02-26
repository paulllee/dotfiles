return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "csv",
          "gitignore",
          "html",
          "javascript",
          "json",
          "jsonc",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "requirements",
          "rust",
          "sql",
          "toml",
          "typescript",
          "tsx",
          "vim",
          "vimdoc",
          "xml",
          "yaml"
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true
        },
        indent = { enable = true }
      })
    end
  }
}
