local opts = { noremap = true, silent = true, expr = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("", "<Space>", "<Nop>", opts)
