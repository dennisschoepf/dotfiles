require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
          personal = "~/notes/personal",
          memex = "~/notes/memex",
        },
      },
    },
    ["core.journal"] = {
      config = {
        journal_folder = "dailies",
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
        hook = function(keybinds)
          keybinds.map("norg", "n", "<Leader>oec", "core.looking-glass.magnify-code-block")
        end,
      },
    },
  },
})
