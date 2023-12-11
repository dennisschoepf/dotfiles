local lspconfig = require("lspconfig")
local dnscUtils = require("dnsc.utils")
local lspUtils = require("lspconfig.util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "tsserver",
  "lua_ls",
  "jsonls",
  "html",
  "cssls",
  "tailwindcss",
}

require("mason").setup()
-- Automatic Server Installation with Mason
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- LANGUAGE SERVERS
-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Typescript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  root_dir = lspUtils.root_pattern("package.json"),
  handlers = {
    ["textDocument/definition"] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = dnscUtils.filter(result, dnscUtils.filterReactDTS)
        return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
      end

      vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
    end,
  },
})

-- JSON
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
})

-- Tailwind
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
})

-- Sonarlint
require("sonarlint").setup({
  server = {
    cmd = {
      "sonarlint-language-server",
      -- Ensure that sonarlint-language-server uses stdio channel
      "-stdio",
      "-analyzers",
      -- paths to the analyzers you need, using those for python and java in this example
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
    },
  },
  filetypes = { "typescript" },
})

-- LSP Keybindings
-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
