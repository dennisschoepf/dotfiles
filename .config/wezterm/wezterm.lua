local wezterm = require('wezterm')
local config = {}

-- General Options
config.default_prog = { '/usr/bin/nu' }

-- Appearance
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0

config.color_scheme = 'catppuccin-mocha'

return config
