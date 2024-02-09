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

local plugins = { -- sorted alphabetically by plugin NAME
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end,
    },

    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "L3MON4D3/LuaSnip" },
        },
        config = function()
            local lsp = require("lsp-zero").preset({})

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
                lsp.buffer_autoformat()
            end)

            lsp.ensure_installed({
                "clangd",
                "lua_ls",
                "ruff_lsp",
            })

            lsp.setup()

            require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        config = function()
            require("lualine").setup()
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-tree/nvim-web-devicons" },
            { "MunifTanjim/nui.nvim" },
        },
        config = function()
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        never_show = { ".DS_Store", ".git" },
                    },
                },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                sync_installed = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")

            local mappings = {
                t = {
                    name = "[T]elescope",
                    f = { "<cmd>Telescope find_files<cr>", "Find [F]iles" },
                    g = { "<cmd>Telescope live_grep<cr>", "Live [G]rep" },
                    r = { "<cmd>Telescope oldfiles<cr>", "Find [R]ecent Files" },
                },
                n = { "<cmd>Neotree<cr>", "Open [N]eotree" },
            }

            local opts = { prefix = "<leader>" }

            wk.register(mappings, opts)

            vim.api.nvim_create_autocmd({ "LspAttach" }, {
                callback = function()
                    wk.register({
                        ["<leader>"] = {
                            d = {
                                name = "[D]iagnostic",
                                o = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[O]pen Diagnostic" },
                                n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[N]ext Diagnostic" },
                                p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[P]revious Diagnostic" },
                                t = { "<cmd>Telescope diagnostics<cr>", "[T]elescope Diagnostics" },
                            },
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
        end,
    },
}

require("lazy").setup(plugins)
