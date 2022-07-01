local home = os.getenv("HOME")
local db = require("dashboard")

db.custom_header = {
	"",
	"",
	"     ▄▄▄▄▄███████████████████▄▄▄▄▄     ",
	"   ▄██████████▀▀▀▀▀▀▀▀▀▀██████▀████▄   ",
	"  █▀████████▄             ▀▀████ ▀██▄  ",
	" █▄▄██████████████████▄▄▄         ▄██▀ ",
	"  ▀█████████████████████████▄    ▄██▀  ",
	"    ▀████▀▀▀▀▀▀▀▀▀▀▀▀█████████▄▄██▀    ",
	"      ▀███▄              ▀██████▀      ",
	"        ▀██████▄        ▄████▀         ",
	"           ▀█████▄▄▄▄▄▄▄███▀           ",
	"             ▀████▀▀▀████▀             ",
	"               ▀███▄███▀               ",
	"                  ▀█▀                  ",
	"",
	" [ dnsc ] ",
	"",
	"",
	"",
}

-- db.custom_header = custom_header
db.custom_center = {
	{
		icon = "  ",
		desc = "Open project                  ",
		shortcut = "SPC p p",
		action = "Telescope projects",
	},
	{
		icon = "  ",
		desc = "Recently opened files         ",
		action = "DashboardFindHistory",
		shortcut = "SPC f r",
	},
	{
		icon = "  ",
		desc = "Find File                     ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC SPC",
	},
	{
		icon = "  ",
		desc = "File Browser               ",
		action = "Telescope file_browser",
		shortcut = "   SPC n  ",
	},
	{
		icon = "  ",
		desc = "Find word                  ",
		action = "Telescope live_grep",
		shortcut = "   SPC s  ",
	},
	-- {
	-- 	icon = "  ",
	-- 	desc = "Open Neovim configuration       ",
	-- 	action = "cd " .. home .. "/.config/nvim <CR>Telescope file_browser",
	-- 	shortcut = "SPC x o",
	-- },
}
