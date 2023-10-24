local wezterm = require("wezterm")
local act = wezterm.action

if wezterm.config_builder then
	---@diagnostic disable-next-line: lowercase-global
	config = wezterm.config_builder()
end

-- Appearance
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14
config.color_scheme = "catppuccin-mocha"
config.enable_tab_bar = false
config.window_background_opacity = 0.92
config.window_decorations = "NONE"
config.window_padding = {
	left = 25,
	right = 25,
	top = 25,
	bottom = 25,
}

-- Shortcuts
config.keys = {
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{
		key = "c",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local selection_text = window:get_selection_text_for_pane(pane)
			local is_selection_active = string.len(selection_text) ~= 0
			if is_selection_active then
				window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
			else
				window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
			end
		end),
	},
}

return config
