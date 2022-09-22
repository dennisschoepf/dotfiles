local wk = require("which-key")
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file)
-- vim.cmd("inoremap <leader>zt <cmd>:lua require('telekasten').toggle_todo({ i=true })<CR>")

wk.register({
	["."] = { "<cmd>Telescope find_files<cr>", "Find file in repository" },
	["<leader>"] = { "<cmd>Telescope git_files<cr>", "Find file in repository" },
	f = {
		name = "+file",
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		s = { "<cmd>w<cr>", "Save currently opened file" },
		n = { "<cmd>enew<cr>", "Create a new file" },
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
		d = { "<cmd>BDelete! this<cr>", "Delete current buffer" },
		D = { "<cmd>BWipeout! all<cr>", "Delete all buffers" },
		x = { "<cmd>BWipeout other<cr>", "Delete all buffers but current" },
		p = { "<Plug>(cokeline-pick-focus)", "Pick a buffer" },
		[","] = { "<Plug>(cokeline-switch-prev)<cr>", "Move buffer back" },
		["."] = { "<Plug>(cokeline-switch-next)<cr>", "Move buffer forward" },
		h = { "<Plug>(cokeline-focus-prev)<cr>", "Go to previous buffer" },
		l = { "<Plug>(cokeline-focus-prev)<cr>", "Go to next buffer" },
	},
	x = {
		name = "+config",
		r = { "<cmd>source $MYVIMRC<cr>", "Reload config" },
		n = { "<cmd>set number relativenumber<cr>", "Show relative numbers" },
		i = { "<cmd>PackerInstall<cr>", "Install plugins" },
	},
	t = {
		name = "+diagnostics",
		d = { "<cmd>Telescope diagnostics<CR>", "Show document diagnostics" },
	},
	p = {
		name = "+projects",
		p = { "<cmd>Telescope projects<cr>", "Switch to project" },
	},
	n = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Open file browser" },
	s = { "<cmd>Telescope live_grep<cr>", "Search within project" },
	z = {
		name = "+notes",
		z = { "<cmd>Neorg workspace main<CR>", "Opens main workspace" },
	},
	g = {
		name = "+git",
		g = { "<cmd>LazyGit<CR>", "Opens lazygit" },
	},
	q = {
		q = { "<cmd>qa!<cr>", "Leave neovim" },
	},
}, { prefix = "<leader>", mode = "n" })
