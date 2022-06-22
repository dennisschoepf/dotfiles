require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					main = "~/notes",
				},
				default_workspace = "main",
			},
		},
		["core.norg.journal"] = {
			config = {
				journal_folder = "daily",
				strategy = "flat",
			},
		},
	},
})
