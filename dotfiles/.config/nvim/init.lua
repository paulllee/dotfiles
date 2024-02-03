-- [[ vim settings ]]

-- sets leader key to <space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use 4 spaces instead of a tab
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- sync clipboard between OS and nvim
vim.o.clipboard = "unnamedplus"

-- enable mouse
vim.o.mouse = "a"

-- break indent
vim.o.breakindent = true

-- saves undo history in a file
vim.o.undofile = true

-- case-insensitive searching unless you have a capital
vim.o.ignorecase = true
vim.o.smartcase = true

-- better completion experience
vim.o.completeopt = "menuone,noselect"

-- enable true color
vim.o.termguicolors = true

-- decrease update time for backup swaps
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- relative line numbers are game changer
vim.wo.relativenumber = true

-- keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- [[ lazy plugin manager ]]

-- recommended by documentation
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- all of my necessities
local plugins = {
    -- theme of choice... my favorite ever
    {
        "projekt0n/github-nvim-theme",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme github_dark_default")
        end,
    },

    -- comment visual region using "gc"
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {}, -- tip: `opts = {}` == `require("Comment").setup({})`
    },

    -- indentation guides
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },

    -- cool statusline
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                theme = "iceberg_dark",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
            },
        },
    },

    -- helpful git signs
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },

    -- which-key helper menu
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- file tree explorer in nvim
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            renderer = {
                icons = {
                    show = {
                        file = false,
                        folder = false,
                        folder_arrow = false,
                        git = false,
                        modified = false,
                        diagnostics = false,
                        bookmarks = false,
                    },
                },
            },
        },
    },

    -- telescope, best plugin
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {},
    },

    -- lsp config
    {
        "neovim/nvim-lspconfig",
    },

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {},
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "cpp",
                    "css",
                    "csv",
                    "dockerfile",
                    "git_config",
                    "gitignore",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "toml",
                    "yaml",
                },
                auto_install = true,
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {},
    },

    {
        "williamboman/mason-lspconfig.nvim",
        opts = {},
    },
}

-- removing nerd font dependency for lazy
local opts = {
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
}

require("lazy").setup(plugins, opts)

-- [[ lsp setup ]]

require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup(
            {
                settings = {
                    Lua = {
                        diagnostics = { globals = { 'vim' } }
                    },
                },
            })
    end,
}

local DEFAULT_SETTINGS = {
    ensure_installed = {
        "bash",
        "clangd",
        "dockerls",
        "docker_compose_language_service",
        "lua_ls",
        "pyright",
        "ruff_lsp",
    },
    automatic_installation = true,
}

-- [[ which-key setup ]]

local wk = require("which-key")

-- telescope and diagnostics
wk.register({
    ["<leader>"] = {
        f = {
            name = "[T]elescope",
            f = { "<cmd>Telescope find_files<cr>", "Find [F]iles" },
            g = { "<cmd>Telescope live_grep<cr>", "Live [G]rep" },
            r = { "<cmd>Telescope oldfiles<cr>", "Find [R]ecent Files" },
        },
        d = {
            name = "[D]iagnostic",
            o = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[O]pen Diagnostic" },
            n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[N]ext Diagnostic" },
            p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[P]revious Diagnostic" },
            t = { "<cmd>Telescope diagnostics<cr>", "[T]elescope Diagnostics" },
        },
        n = { "<cmd>Neotree<cr>", "Open [N]eotree" },
    },
})

-- [[ auto commands ]]

-- format on `:w`
vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = vim.fn.bufnr(),
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 3000 })
    end,
})

vim.api.nvim_create_autocmd({ "LspAttach" }, {
    callback = function()
        wk.register({
            ["<leader>"] = {
                g = {
                    name = "[G]oto LSP",
                    d = { vim.lsp.buf.definition, "Go to [D]efinition" },
                    t = { vim.lsp.buf.type_definition, "Go to [T]ype Definition" },
                    r = { require("telescope.builtin").lsp_references, "Open a Telescope Window with [R]eferences" },
                },
            },
        })
    end,
})
