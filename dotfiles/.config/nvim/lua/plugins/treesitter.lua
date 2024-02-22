return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        -- config formats
        "json",
        "jsonc",
        "requirements",
        "xml",
        "toml",
        "yaml",

        -- docs
        "luadoc",
        "markdown",
        "markdown_inline",
        "vimdoc",

        -- other
        "csv",
        "gitignore",
        "regex",

        -- programming languages
        "python",
        "bash",
        "c",
        "cpp",
        "lua",
        "ocaml",
        "ocaml_interface",
        "rust",
        "sql",

        -- web dev
        "css",
        "html",
        "htmldjango",
        "javascript",
        "tsx",
        "typescript"
      },
      highlight = { enable = true },
      indent = { enable = true }
    }
  }
}
