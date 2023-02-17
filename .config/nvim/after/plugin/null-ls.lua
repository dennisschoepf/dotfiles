local bufWritePreGroup = vim.api.nvim_create_augroup("BufWritePre", { clear = true })

local lsp = require("lsp-zero")
local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
        on_attach = function(client, bufnr)
                null_opts.on_attach(client, bufnr)

                if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = bufWritePreGroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                                group = bufWritePreGroup,
                                buffer = bufnr,
                                callback = function()
                                        vim.lsp.buf.format({ bufnr = bufnr })
                                end,
                        })
                end
        end,
        sources = {
                null_ls.builtins.formatting.prettierd,
                null_ls.builtins.formatting.stylua,
        },
})
