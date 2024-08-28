# vscode

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
