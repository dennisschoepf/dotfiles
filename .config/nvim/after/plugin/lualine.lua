require("lualine").setup({
	options = {
		icons_enabled = false,
		-- globalstatus = true
		component_separators = { left = "|", right = "|" },
		section_separators = { left = "", right = "" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {},
		lualine_c = { "branch", "diff", "diagnostics" },
		lualine_x = { "filetype", "encoding" },
		lualine_y = {},
		lualine_z = { "location" },
	},
})
