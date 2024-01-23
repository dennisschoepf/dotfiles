require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          default = "~/notes",
        },
      },
    },
    ["core.journal"] = {
      config = {
        workspace = "default",
        journal_folder = "dailies",
        strategy = "flat",
      },
    },
    ["core.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.concealer"] = {},
    ["core.export"] = {},
    ["core.export.markdown"] = {},
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode",
      },
    },
    -- Enable on neovim 0.10.0 ["core.ui.calendar"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>o",
        hook = function(keybinds)
          -- Normal Mode
          keybinds.map("norg", "n", "<Leader>oec", "core.looking-glass.magnify-code-block")
          keybinds.map_event("norg", "n", "<Leader>ofh", "core.integrations.telescope.search_headings")
          keybinds.map_event("norg", "n", "<Leader>off", "core.integrations.telescope.find_linkable")

          -- Insert Mode
          keybinds.map_event("norg", "i", "<C-l>", "core.integrations.telescope.insert_file_link")
        end,
      },
    },
    ["core.integrations.telescope"] = {},
  },
})
