require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.dirman"] = {
			config = {
				workspaces = {
					notes = "~/notes",
				},
			},
		},
		["core.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.concealer"] = {},
		["core.journal"] = {
			config = {
				strategy = "flat",
				journal_folder = "daily",
				workspace = "notes",
			},
		},
	},
})
