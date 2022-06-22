require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
				["<C-k>"] = "move_selection_previous",
				["<C-j>"] = "move_selection_next",
				["<M-CR>"] = "select_vertical",
			},
			n = {
				["<M-CR>"] = "select_vertical",
			},
		},
	},
	pickers = {},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
