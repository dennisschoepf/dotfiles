local plugins = {
	-- Utils
	"nvim-lua/plenary.nvim",
	"folke/which-key.nvim",
	-- Appearance
	"kyazdani42/nvim-web-devicons",
	{ "catppuccin/nvim", name = "catppuccin" },
	-- Helpers
	"romainl/vim-cool",
	"echasnovski/mini.pairs",
	"echasnovski/mini.starter",
	"echasnovski/mini.comment",
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
	},
	-- File/Folder Management
	"stevearc/oil.nvim",
	-- Treesitter (and TS-based plugins)
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
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
}

local opts = {}

require("lazy").setup(plugins, opts)
