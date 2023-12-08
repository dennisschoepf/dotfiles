local wezterm = require('wezterm')
local act = wezterm.action
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
    bottom = padding - 7,
  }
end

-- General Options

-- Appearance
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0

config.color_scheme = 'catppuccin-mocha'
config.window_decorations = "RESIZE"
config.window_padding = get_padding(25)
config.colors = { foreground = "white" }

-- Keybindings
-- Shortcuts
config.keys = {
  { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
  { key = "c", mods = "CMD", action = act.CopyTo("ClipboardAndPrimarySelection") }
}

return config
