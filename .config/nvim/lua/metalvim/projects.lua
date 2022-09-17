require("project_nvim").setup({
	detection_methods = { "lsp", "pattern" },
	-- All the patterns used to detect root dir, when **"pattern"** is in
	-- detection_methods
	patterns = { "package.json", ".git" },
	-- When set to false, you will get a message when project.nvim changes your
	-- directory.
	-- silent_chdir = false,
})
