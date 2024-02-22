return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- config formats
          "json",
          "jsonc",
          "requirements",
          "xml",
          "toml",
          "yaml",

          -- languages
          "bash",
          "c",
          "cpp",
          "css",
          "html",
          "javascript",
          "lua",
          "ocaml",
          "ocaml_interface",
          "python",
          "rust",
          "sql",

          -- other
          "csv",
          "gitignore",
          "markdown",
          "markdown_inline",
          "regex"
        },
        highlight = { enable = true },
        indent = { enable = true }
      })
    end
  }
}
