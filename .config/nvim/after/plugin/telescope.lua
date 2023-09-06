local lga_actions = require("telescope-live-grep-args.actions")

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
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			mappings = {
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
			theme = "ivy", -- use dropdown theme
		},
	},
})

require("telescope").load_extension("live_grep_args")
require("telescope").load_extension("fzf")
