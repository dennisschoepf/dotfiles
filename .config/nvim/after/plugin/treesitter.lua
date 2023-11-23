require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	auto_install = true,
	sync_install = false,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
})
