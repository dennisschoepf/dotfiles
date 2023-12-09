require("telescope").setup({
	pickers = {
		find_files = {
			theme = "ivy",
		},
		git_files = {
			theme = "ivy",
		},
		oldfiles = {
			theme = "ivy",
		},
		live_grep = {
			theme = "ivy",
		},
		buffers = {
			theme = "ivy",
		},
		current_buffer_fuzzy_find = {
			theme = "ivy",
		},
		lsp_references = {
			theme = "ivy",
		},
		diagnostics = {
			theme = "ivy",
		},
	},
	extensions = {
		fzf = {},
	},
})

require("telescope").load_extension("fzf")
