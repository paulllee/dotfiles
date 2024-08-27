# editors

Setup instructions for my editors of choice.

## neovim

1.  Before launching up neovim, run the following commands
    in your **dotfiles** directory:
    ```sh
    pixi init
    pixi add nodejs
    ```
2.  Launch up neovim and wait for `pyright` to install.
3.  After it completes, you can delete the `pixi` related
    directories and files in the cwd.

## vscode

1.  Launch up vscode and install the following extensions:
    ```
    Catppuccin.catppuccin-vsc
    vscodevim.vim
    ```
2.  Use the configuration below for `settings.json`:
    ```json
    {
        "breadcrumbs.enabled": false,
        "editor.cursorSurroundingLines": 10,
        "editor.fontFamily": "JetBrainsMono Nerd Font Mono",
        "editor.fontLigatures": true,
        "editor.fontSize": 14,
        "editor.lightbulb.enabled": "off",
        "editor.minimap.enabled": false,
        "editor.scrollbar.vertical": "hidden",
        "editor.scrollbar.horizontal": "hidden",
        "editor.stickyScroll.enabled": false,
        "editor.lineNumbers": "relative",
        "extensions.ignoreRecommendations": true,
        "terminal.integrated.fontSize": 14,
        "terminal.integrated.tabs.enabled": false,
        "vim.useSystemClipboard": true,
        "vim.leader": "<space>",
        "vim.normalModeKeyBindingsNonRecursive": [
            {
                "before": ["<leader>", "f"],
                "commands": ["workbench.action.quickOpen"],
                "silent": true
            },
            {
                "before": ["<leader>", "s"],
                "commands": ["workbench.action.toggleSidebarVisibility"],
                "silent": true
            }
        ],
        "window.commandCenter": false,
        "workbench.activityBar.location": "bottom",
        "workbench.colorTheme": "Catppuccin Mocha",
        "workbench.editor.showTabs": "none"
    }
    ```
