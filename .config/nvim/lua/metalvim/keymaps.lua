local wk = require("which-key")
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

wk.register({
	["."] = { "<cmd>Telescope git_files<cr>", "Find file in repository" },
	f = {
		name = "+file",
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
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
		d = { "<cmd>BufferClose<cr>", "Delete current buffer" },
		D = { "<cmd>BufferWipeout<cr>", "Delete all buffers" },
		x = { "<cmd>BufferCloseAllButCurrent<cr>", "Delete all buffers but current" },
		f = { "<cmd>BufferPin<cr>", "Pin current buffer" },
		p = { "<cmd>BufferPick<cr>", "Pick a buffer" },
		h = { "<cmd>BufferPrevious<cr>", "Go to previous buffer" },
		l = { "<cmd>BufferNext<cr>", "Go to next buffer" },
	},
	x = {
		name = "+config",
		r = { "<cmd>source $MYVIMRC<cr>", "Reload config" },
		n = { "<cmd>set number relativenumber<cr>", "Show relative numbers" },
		i = { "<cmd>PackerInstall<cr>", "Install plugins" },
	},
	t = {
		name = "Diagnostics",
		d = { "<cmd>Trouble document_diagnostics<CR>", "Show document diagnostics" },
		x = { "<cmd>Trouble workspace_diagnostics<CR>", "Show workspace diagnostics" },
	},
	n = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Open file browser" },
	s = { "<cmd>Telescope live_grep<cr>", "Search within project" },
	q = {
		q = { "<cmd>qa!<cr>", "Leave neovim" },
	},
}, { prefix = "<leader>", mode = "n" })
