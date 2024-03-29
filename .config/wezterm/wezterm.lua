local wezterm = require("wezterm")
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
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0
config.color_scheme = "catppuccin-mocha"
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_padding = get_padding(25)
config.window_background_opacity = 0.975
config.colors = { foreground = "white" }

-- Overrides
if hn == "contraption.digital-h.de" then
	config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
	config.font_size = 17.5
	config.window_decorations = "RESIZE"
	config.window_padding = get_padding(30)
end

if hn == "dnsc-desktop" then
	config.window_decorations = "RESIZE"
	config.window_padding = get_padding(20)
	config.window_background_opacity = 0.97
end

-- Keybindings
config.keys = {
	{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "SUPER", action = act.CopyTo("ClipboardAndPrimarySelection") },
}

return config
