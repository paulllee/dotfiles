local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Latte"

config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0

config.enable_tab_bar = false

local wds = {
  "TITLE",
  "RESIZE",
  "MACOS_FORCE_DISABLE_SHADOW",
}
config.window_decorations = table.concat(wds, "|")

return config
