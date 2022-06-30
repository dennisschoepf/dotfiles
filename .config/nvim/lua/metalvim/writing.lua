require("zen-mode").setup({
	window = {
		backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
		width = 100, -- width of the Zen window
		height = 0.9, -- height of the Zen window
		options = {
			signcolumn = "no", -- disable signcolumn
			number = false, -- disable number column
			relativenumber = false, -- disable relative numbers
		},
	},
})

vim.api.nvim_exec([[ autocmd VimEnter *.md :ZenMode ]], false)

-- Markdown Preview
vim.g.mkdp_theme = "light"
