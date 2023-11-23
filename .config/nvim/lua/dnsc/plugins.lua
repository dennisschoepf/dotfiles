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
	"tpope/vim-sleuth",
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
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
	"pmizio/typescript-tools.nvim",
    },
  },
	-- Autocompletion
	{
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'rafamadriz/friendly-snippets',
    },
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
