require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {},
	extensions = {},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("file_browser")
