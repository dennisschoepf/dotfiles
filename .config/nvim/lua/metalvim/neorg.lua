require("neorg").setup({
	load = {
		["core.defaults"] = {},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/notes/work",
					memex = "~/notes/memex",
				},
			},
		},
		["core.norg.concealer"] = {},
		["core.norg.journal"] = {
			config = {
				workspace = "work",
				journal_folder = "dailies",
				strategy = "flat",
			},
		},
		["core.integrations.telescope"] = {},
	},
})
