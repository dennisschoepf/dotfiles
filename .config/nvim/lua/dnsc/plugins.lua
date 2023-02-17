local plugins = {
  -- Utils
  "nvim-lua/plenary.nvim",
  -- Appearance
  "kyazdani42/nvim-web-devicons",
  { "catppuccin/nvim", name = "catppuccin" },
  "lukas-reineke/indent-blankline.nvim",
  -- Keybindings
  "folke/which-key.nvim",
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
    }
  },
  -- File Management
  "stevearc/oil.nvim",
  -- Treesitter (and TS-based plugins)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "windwp/nvim-ts-autotag",
  -- Git
  "kdheepak/lazygit.nvim",
  "lewis6991/gitsigns.nvim",
}

local opts = {}

require("lazy").setup(plugins, opts)
