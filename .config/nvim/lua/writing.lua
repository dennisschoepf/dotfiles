-- General note taking with mind
require("mind").setup({
	persistence = {
		state_path = "~/notes/mind.json",
		data_dir = "~/notes/data",
	},
	ui = {
		width = 40,
		root_marker = " ",
	},
})

-- ZenMode setup
require("zen-mode").setup({
	window = {
		backdrop = 1,
		width = 100,
		height = 0.9,
		options = {
			signcolumn = "no", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false, -- disable relative numbers
			-- cursorline = false, -- disable cursorline
			-- cursorcolumn = false, -- disable cursor column
			foldcolumn = "0", -- disable fold column
		},
	},
})

-- Markdown Preview
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/assets/markdown.css")
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_theme = "light"
