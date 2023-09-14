local plugins = {
	-- Utils
	"nvim-lua/plenary.nvim",
	-- Appearance
	"kyazdani42/nvim-web-devicons",
	{ "catppuccin/nvim", name = "catppuccin" },
	"lukas-reineke/indent-blankline.nvim",
	-- Helpers
	"romainl/vim-cool",
	"echasnovski/mini.pairs",
	"echasnovski/mini.comment",
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		version = "0.1.1",
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
	},
	-- File/Folder Management
	"stevearc/oil.nvim",
	"ThePrimeagen/harpoon",
	-- Treesitter (and TS-based plugins)
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"windwp/nvim-ts-autotag",
	-- Git
	"kdheepak/lazygit.nvim",
	"lewis6991/gitsigns.nvim",
	-- Bufferline
	"romgrk/barbar.nvim",
	-- Statusline
	"nvim-lualine/lualine.nvim",
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ -- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-nvim-lua" },
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	},
	-- NULL-LS
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
	},
	-- Trouble (LSP Diagnostics)
	"folke/trouble.nvim",
	-- Start Screen
	{ "echasnovski/mini.starter", version = false },
	-- Notes
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers", -- This is the important bit!
	},
	-- Keybindings
	"folke/which-key.nvim",
}

local opts = {}

require("lazy").setup(plugins, opts)
