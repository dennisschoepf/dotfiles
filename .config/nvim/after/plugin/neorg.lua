require("neorg").setup({
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          work = "~/notes/work",
          personal = "~/notes/personal",
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
        default_keybinds = true,
        neorg_leader = "<Leader>o",
        hook = function(keybinds)
          -- Normal Mode
          keybinds.map("norg", "n", "<Leader>oec", "core.looking-glass.magnify-code-block")
          keybinds.map("norg", "n", "<Leader>ofh", "core.integrations.telescope.search_headings")
          keybinds.map("norg", "n", "<Leader>off", "core.integrations.telescope.find_linkable")

          -- Insert Mode
          keybinds.map("norg", "i", "<C-l>", "core.integrations.telescope.insert_file_link")
        end,
      },
    },
    ["core.integrations.telescope"] = {},
  },
})
