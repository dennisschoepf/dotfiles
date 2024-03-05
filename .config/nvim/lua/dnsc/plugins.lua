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
    "neovim/nvim-lspconfig",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/schemastore.nvim",
    },
  },
  -- Linting & Formatting
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
      "neovim/nvim-lspconfig",
    },
  },
  -- Go specific setup
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- Note Taking Setup
  "folke/zen-mode.nvim",
}

local opts = {}

require("lazy").setup(plugins, opts)
