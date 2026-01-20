local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "GruvboxDarkHard"
config.enable_tab_bar = false
config.font = wezterm.font("JetBrains Mono")
config.font_size = 14.0

if wezterm.target_triple:find("windows") ~= nil then
  config.default_prog = { "pwsh.exe" }
  config.font_size = 11.0
end

return config
