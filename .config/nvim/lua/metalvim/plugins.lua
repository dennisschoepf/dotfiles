local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

return require("packer").startup(function(use)
	-- Utilities
	use("nvim-lua/plenary.nvim")
	use("wbthomason/packer.nvim")
	use("kyazdani42/nvim-web-devicons")

	-- Colorscheme
	use("EdenEast/nightfox.nvim")
	use("projekt0n/github-nvim-theme")
	use("marko-cerovac/material.nvim")

	-- UI
	use("nvim-lualine/lualine.nvim")
	use("kazhala/close-buffers.nvim")
	-- use({ "akinsho/bufferline.nvim", tag = "*" })
  use({"noib3/nvim-cokeline"})
	use("lukas-reineke/indent-blankline.nvim")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use({
		"vuki656/package-info.nvim",
		requires = "MunifTanjim/nui.nvim",
	})
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use({ "glepnir/dashboard-nvim" })
  use({ "romainl/vim-cool" })

	-- Projects
	use("ahmedkhalf/project.nvim")

	-- Writing
	use("folke/zen-mode.nvim")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	-- Notes
	use({
		"nvim-neorg/neorg",
		requires = "nvim-neorg/neorg-telescope",
	})

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-ts-autotag")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("kdheepak/lazygit.nvim")

	-- LSP
	use("williamboman/nvim-lsp-installer")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")
use({
    'junnplus/lsp-setup.nvim',
    requires = {
        'neovim/nvim-lspconfig',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }
})

	-- Neovim Lua Dev
	use("folke/lua-dev.nvim")

	-- React Dev
	use("napmn/react-extract.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("nvim-telescope/telescope-file-browser.nvim")

	-- Completion
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lua")
	use("David-Kunz/cmp-npm")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/nvim-cmp")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- Keymaps
	use("folke/which-key.nvim")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
