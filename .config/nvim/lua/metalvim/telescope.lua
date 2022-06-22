require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
				["<C-k>"] = "move_selection_previous",
				["<C-j>"] = "move_selection_next",
			},
			n = {},
		},
	},
	pickers = {},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
