local which_key = require("which-key")

which_key.setup({
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

which_key.register({
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
    s = { "<cmd>Telescope live_grep<cr>", "Search in CWD" },
    w = { "<cmd>Telescope grep_string<cr>", "Search current word" },
    b = { ":lua require'telescope.builtin'.buffers{}<cr>", "Find buffer" },
    f = { ":lua require'telescope.builtin'.builtin.current_buffer_fuzzy_find{}<cr>", "Find in file" },
  },
  c = {
    name = "+code",
    f = { ":lua require'telescope.builtin'.builtin.lsp_references{}<cr>", "Show references" },
    d = { ":lua require'telescope.builtin'.diagnostics{}<cr>", "Show diagnostics" },
    a = { ":lua vim.lsp.buf.code_action()<cr>", "Code actions" },
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
  p = { "<cmd>Telescope buffers<cr>", "Opens buffers" },
  x = {
    name = "+config",
    r = { "<cmd>source $MYVIMRC<cr>", "Reload config" },
    n = { "<cmd>set number relativenumber<cr>", "Show relative numbers" },
  },
  g = {
    name = "+git",
    g = { "<cmd>LazyGit<CR>", "Opens lazygit" },
    b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle git line blame" },
  },
  t = {
    name = "+diagnostics (lsp)",
    d = { "<cmd>Telescope diagnostics<cr>", "Show LSP diagnostics" },
  },
  o = {
    name = "+organize (neorg)",
    t = { '<cmd>e + "~/notes/todo.txt"', "Open Tasks" },
    v = { '<cmd>85vsplit | e + "~/notes/todo.txt"<cr>', "Open tasks to the side" },
    n = { "<cmd>e ~/notes/reference/", "Open reference notes" },
    m = { "<cmd>e ~/notes/meetings/", "Open meeting notes" },
    p = { "<cmd>e ~/notes/projects/", "Open project notes" },
  },
  n = { "<cmd>Oil --float<cr>", "Open file browser" },
  d = { "<cmd>wq<cr>", "Close window and buffer" },
  q = { "<cmd>qa!<cr>", "Leave neovim" },
}, { prefix = "<leader>", mode = "n" })
