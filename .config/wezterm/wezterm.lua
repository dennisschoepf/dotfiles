local wezterm = require('wezterm')
local act = wezterm.action
local hn = wezterm.hostname()
local config = {}

if wezterm.config_builder then
  ---@diagnostic disable-next-line: lowercase-global
  config = wezterm.config_builder()
end

-- Helper
local function get_padding(padding)
  return {
    left = padding,
    right = padding,
    top = padding,
    bottom = padding - 10,
  }
end

-- General Options

-- Appearance
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0
config.color_scheme = 'catppuccin-mocha'
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_padding = get_padding(25)
config.colors = { foreground = "white" }

-- Overrides
-- Overrides for Mac
if hn == "contraption.digital-h.de" then
  config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
  config.font_size = 17.5
  config.window_padding = get_padding(30)
end

-- Keybindings
config.keys = {
  { key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
  { key = "c", mods = "SUPER", action = act.CopyTo("ClipboardAndPrimarySelection") }
}

return config
