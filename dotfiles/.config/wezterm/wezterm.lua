local wt = require("wezterm")
local config = wt.config_builder()

config.color_scheme = "Catppuccin Latte"

config.enable_tab_bar = false

config.font = wt.font("JetBrains Mono")
config.font_size = 14.0

if wt.target_triple:find("windows") ~= nil then
  config.default_prog = { "pwsh.exe" }
end

return config
