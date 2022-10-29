--[[
███╗   ███╗██╗███╗   ██╗██╗███╗   ███╗ █████╗ ██╗   ██╗██╗███╗   ███╗
████╗ ████║██║████╗  ██║██║████╗ ████║██╔══██╗██║   ██║██║████╗ ████║
██╔████╔██║██║██╔██╗ ██║██║██╔████╔██║███████║██║   ██║██║██╔████╔██║
██║╚██╔╝██║██║██║╚██╗██║██║██║╚██╔╝██║██╔══██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚═╝ ██║██║██║ ╚████║██║██║ ╚═╝ ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

Author: Dennis Schoepf
Version: 0.0.1
]]
--

--[[
GENERAL SETTINGS
--]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opts = { noremap = true, silent = true, expr = true }

vim.keymap.set("", "<Space>", "<Nop>", opts)
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", opts)
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--[[
PLUGINS
--]]

-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
	-- PLUGIN MANAGER
	use({ "wbthomason/packer.nvim" })

	-- MISC HELPERS
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "nvim-lua/plenary.nvim" })
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({})
		end,
	})
	use({
		"cohama/lexima.vim",
		config = function()
			vim.g.lexima_enable_basic_rules = 1
			vim.g.lexima_enable_newline_rules = 1
			vim.g.lexima_enable_endwise_rules = 0
		end,
	})
	use({ "romainl/vim-cool" })

	-- COLORSCHEME
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "frappe"
			require("catppuccin").setup()
			vim.api.nvim_command("colorscheme catppuccin")
		end,
	})

	-- KEYMAP
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				window = {
					border = "single", -- none, single, double, shadow
					position = "bottom",
					margin = { 0, 0, 0, 0 },
					padding = { 2, 1, 2, 1 },
				},
				layout = {
					align = "center",
				},
			})
		end,
	})

	-- Bufferline
	use({
		"romgrk/barbar.nvim",
		config = function()
			require("bufferline").setup({
				animation = false,
				auto_hide = false,
				maximum_length = 35,
				closable = false,
				icons = false,
			})
		end,
	})

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = false,
					-- globalstatus = true
					component_separators = { left = "|", right = "|" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = {},
					lualine_c = { "branch", "diff", "diagnostics" },
					lualine_x = { "filetype", "encoding" },
					lualine_y = {},
					lualine_z = { "location" },
				},
			})
		end,
	})

	-- Telescope
	use({ "natecraddock/telescope-zf-native.nvim" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		config = function()
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
					file_browser = {
						theme = "ivy",
						hidden = false,
					},
				},
			})

			require("telescope").load_extension("file_browser")
			require("telescope").load_extension("zf-native")
		end,
	})

	-- Treesitter
	use({ "windwp/nvim-ts-autotag" })
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				auto_install = true,
				ignore_install = { "javascript" },
				highlight = {
					enable = true,
				},
				autotag = {
					enable = true,
				},
			})

			--[[vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
        group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
        callback = function()
          vim.opt.foldmethod     = 'expr'
          vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
        end
      })]]
			--
		end,
	})

	-- Git signs
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
					change = {
						hl = "GitSignsChange",
						text = "│",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
					delete = {
						hl = "GitSignsDelete",
						text = "_",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					topdelete = {
						hl = "GitSignsDelete",
						text = "‾",
						numhl = "GitSignsDeleteNr",
						linehl = "GitSignsDeleteLn",
					},
					changedelete = {
						hl = "GitSignsChange",
						text = "~",
						numhl = "GitSignsChangeNr",
						linehl = "GitSignsChangeLn",
					},
				},
				signcolumn = true,
				current_line_blame = false,
			})
		end,
	})

	-- Lazygit
	use({ "kdheepak/lazygit.nvim" })

	-- Coding plugins
	use({ "neovim/nvim-lspconfig" })
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" })
	use({ "hrsh7th/nvim-cmp", requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-cmdline" } })
	use({ "L3MON4D3/LuaSnip", requires = { "saadparwaiz1/cmp_luasnip" } })
	use({ "jose-elias-alvarez/null-ls.nvim" })
	use({ "ray-x/go.nvim" })

	-- Writing plugins
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	use({ "folke/zen-mode.nvim" })
	use({ "dkarter/bullets.vim" })

	if is_bootstrap then
		require("packer").sync()
	end
end)

if is_bootstrap then
	print("==================================")
	print("    Plugins are being installed")
	print("    Wait until Packer completes,")
	print("       then restart nvim")
	print("==================================")
	return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

--[[
KEYMAPS
--]]

require("which-key").register({
	["."] = { "<cmd>Telescope find_files<cr>", "Find file in dir" },
	["<leader>"] = { "<cmd>Telescope git_files<cr>", "Find git file" },
	f = {
		name = "+file",
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		s = { "<cmd>w<cr>", "Save currently opened file" },
		n = { "<cmd>enew<cr>", "Create a new file" },
	},
	s = {
		name = "+search",
		s = { "<cmd>Telescope live_grep<cr>", "Find file in cwd" },
		b = { ":lua require'telescope.builtin'.buffers{}<cr>", "Find buffer" },
		f = { ":lua require'telescope.builtin'.builtin.current_buffer_fuzzy_find{}<cr>", "Find in file" },
	},
	c = {
		name = "+code",
		f = { ":lua require'telescope.builtin'.builtin.lsp_references{}<cr>", "Show references" },
		d = { ":lua require'telescope.builtin'.diagnostics{}<cr>", "Show diagnostics" },
		a = { ":lua vim.lsp.buf.code_action()<cr>", "Code actions" },
	},
	w = {
		name = "+window",
		h = { "<C-W>h", "Move to window on left" },
		j = { "<C-W>j", "Move to window on bottom" },
		k = { "<C-W>k", "Move to window on top" },
		l = { "<C-W>l", "Move to window on right" },
		d = { "<C-W>q", "Close active window" },
		s = { "<cmd>sp<cr>", "Split windows horizontally" },
		v = { "<cmd>vsp<cr>", "Split windows vertically" },
		["+"] = { ":vertical resize +4<CR>", "Increase window size" },
		["-"] = { ":vertical resize -4<CR>", "Decrease window size" },
	},
	b = {
		name = "+buffer",
		d = { "<Cmd>BufferClose<CR>", "Delete current buffer" },
		D = { "<cmd>BufferCloseAllButCurrent<cr>", "Delete all buffers but current" },
		x = { "<cmd>BufferCloseAllButPinned<cr>", "Delete all buffers" },
		p = { "<cmd>BufferPick<cr>", "Pick a buffer" },
		[","] = { "<Cmd>BufferMovePrevious<CR>", "Move buffer back" },
		["."] = { "<Cmd>BufferMoveNext<CR>", "Move buffer forward" },
		h = { "<Cmd>BufferPrevious<CR>", "Go to previous buffer" },
		l = { "<Cmd>BufferNext<CR>", "Go to next buffer" },
	},
	B = { "<cmd>Telescope buffers<cr>", "Opens buffers" },
	x = {
		name = "+config",
		r = { "<cmd>source $MYVIMRC<cr>", "Reload config" },
		n = { "<cmd>set number relativenumber<cr>", "Show relative numbers" },
		i = { "<cmd>PackerSync<cr>", "Install plugins" },
	},
	g = {
		name = "+git",
		g = { "<cmd>LazyGit<CR>", "Opens lazygit" },
		b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle git line blame" },
	},
	n = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Open file browser" },
	m = {
		name = "+mind",
		o = { "<cmd>MindOpenMain<cr>", "Open main mind tree" },
		c = { "<cmd>MindClose<cr>", "Close main mind tree" },
	},
	q = { "<cmd>qa!<cr>", "Leave neovim" },
}, { prefix = "<leader>", mode = "n" })

--[[
OPTIONS
--]]

local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	smartindent = true,
	breakindent = true,
	showtabline = 0, -- always show tabs
	smartcase = true, -- smart case
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 200, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 230, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	linebreak = true,
	breakat = " ^I!@*-+;:,./?",
	scrolloff = 6, -- is one of my fav
	sidescrolloff = 4,
	winbar = nil,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- Coding (LSP, Formatting, Linting, Completion) is handled in another file
require("coding")
-- Writing (Journal with mind.nvim, markdown setup)
require("writing")
