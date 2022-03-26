local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Utilities
  use 'nvim-lua/plenary.nvim'
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Colorscheme
  use 'EdenEast/nightfox.nvim'

  -- UI
  use 'nvim-lualine/lualine.nvim'
  use 'romgrk/barbar.nvim'

  -- Highlighting & Indentation
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  -- Completion
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'David-Kunz/cmp-npm'
  use 'hrsh7th/nvim-cmp'

  -- Keymaps
  use 'folke/which-key.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
