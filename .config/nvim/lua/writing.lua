-- General note taking helpers

-- 1. Create new fleeting note

-- 2. Find note with telescope

-- 3. Follow note link

-- 4. Export note

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

vim.cmd("autocmd VimEnter *.md :ZenMode")

-- Markdown Preview
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/assets/markdown.css")
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_theme = "light"

-- Spellchecking
