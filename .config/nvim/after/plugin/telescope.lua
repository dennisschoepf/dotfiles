require("telescope").setup({
	file_sorter = "",
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
		fzf = {
			case_mode = "ignore_case",
		},
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
				},
				["n"] = {
					-- your custom normal mode mappings
				},
			},
		},
	},
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")
