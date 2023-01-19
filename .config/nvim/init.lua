--[[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝

Config Author: Dennis Schoepf
Version: 1.0.0
]]
--

--[[
HELPER VARIABLES
--]]
local ensureInstalledServers = {
	"tsserver",
	"sumneko_lua",
	"eslint",
	"jsonls",
	"marksman",
	"html",
}
local opts = { noremap = true, silent = true, expr = true }
local bufWritePreGroup = vim.api.nvim_create_augroup("BufWritePre", { clear = true })

--[[
GENERAL SETTINGS
--]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", opts)

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

--[[
LAZY SETUP
--]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

--[[
PLUGINS
--]]
require("lazy").setup({
	{ "catppuccin/nvim", name = "catppuccin" },
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"lukas-reineke/indent-blankline.nvim",
	"romainl/vim-cool",
	"echasnovski/mini.pairs",
	"folke/which-key.nvim",
	"romgrk/barbar.nvim",
	"nvim-lualine/lualine.nvim",
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	"nvim-telescope/telescope-file-browser.nvim",
	{ "nvim-telescope/telescope.nvim", version = "1.1.0" },
	"windwp/nvim-ts-autotag",
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	"lewis6991/gitsigns.nvim",
	"kdheepak/lazygit.nvim",
	"echasnovski/mini.comment",
	"elihunter173/dirbuf.nvim",
	-- Writing
	{ "iamcco/markdown-preview.nvim", build = "cd app && npm install", ft = { "markdown" } },
	"folke/zen-mode.nvim",
	"dkarter/bullets.vim",
	-- Coding
	{ "Maan2003/lsp_lines.nvim", url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Autocompletion
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Snippets
			"L3MON4D3/LuaSnip",
		},
	},
	"jose-elias-alvarez/null-ls.nvim",
})

--[[
SMALL HELPERS
--]]
local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	return string.match(value.targetUri, "%.d.ts") == nil
end

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
PLUGIN CONFIGURATION
--]]

-- COLORSCHEME
require("catppuccin").setup()
vim.api.nvim_command("colorscheme catppuccin")

-- INDENT BLANKLINE
require("indent_blankline").setup({})

-- MINI PLUGINS
require("mini.pairs").setup({})
require("mini.comment").setup({})

-- WHICH-KEY
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

-- BUFFERLINE
require("bufferline").setup({
	animation = false,
	auto_hide = false,
	maximum_length = 35,
	closable = false,
	icons = false,
})

-- STATUSLINE
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

-- TELESCOPE
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
		fzf = {
			case_mode = "ignore_case",
		},
	},
})

require("telescope").load_extension("file_browser")
require("telescope").load_extension("fzf")

-- TREESITTER
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	auto_install = true,
	ignore_install = { "javascript" },
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

-- GITSIGNS
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

-- MARKDOWN-PREVIEW
vim.g.mkdp_filetypes = { "markdown" }

-- LSP-ZERO & NULL-LS
local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.setup_nvim_cmp({
	sources = {
		{ name = "nvim_lsp", keyword_length = 2 },
		{ name = "path" },
		{ name = "luasnip", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
	},
})
lsp.set_preferences({
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})
lsp.ensure_installed(ensureInstalledServers)

-- SUMNEKO_LUA CUSTOMIZATION
lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- TSSERVER CUSTOMIZATION
lsp.configure("tsserver", {
	handlers = {
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.tbl_islist(result) and #result > 1 then
				local filtered_result = filter(result, filterReactDTS)
				return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
			end

			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
})

-- ESLINT SERVER CUSTOMIZATION
local lspUtils = require("lspconfig.util")
lsp.configure("eslint", {
	root_dir = lspUtils.root_pattern(
		".eslintrc",
		".eslintrc.js",
		".eslintrc.cjs",
		".eslintrc.yaml",
		".eslintrc.yml",
		".eslintrc.json"
		-- Disabled to prevent "No ESLint configuration found" exceptions
		-- 'package.json',
	),
	settings = {
		codeActionOnSave = {
			enable = true,
			mode = "all",
		},
	},
})

-- LSP SETUP
lsp.setup()

-- NULL-LS SETUP & FORMAT ON SAVE
local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = bufWritePreGroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = bufWritePreGroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.stylua,
	},
})

-- LSP-LINES
require("lsp_lines").setup()
vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})
vim.keymap.set("", "<Leader>e", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })

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
		r = { ":TypescriptRenameFile<cr>", "TS: Rename file" },
		i = { ":TypescriptFixAll<cr>", "TS: Fix All" },
		g = { ":TypescriptGoToSourceDefinition<cr>", "TS: Go to source definition" },
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
		d = { "<Cmd>BufferDelete!<CR>", "Delete current buffer" },
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
	o = {
		name = "+open",
		d = { "<cmd>Dirbuf<CR>", "Opens directory" },
		t = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Open telescope file browser" },
	},
	n = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Open telescope file browser" },
	q = { "<cmd>qa!<cr>", "Leave neovim" },
}, { prefix = "<leader>", mode = "n" })

--[[
CUSTOM KEYMAPS (NO PLUGINS)
--]]
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
