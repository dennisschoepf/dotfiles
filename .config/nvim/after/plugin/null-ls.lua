local lsp = require("lsp-zero")
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_callback = function(bufnr)
	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end

local has_eslint_config = function(utils)
	return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
end

local null_opts = lsp.build_options("null-ls", {
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					format_callback(bufnr)
				end,
			})
		end
	end,
})

null_ls.setup({
	on_attach = null_opts.on_attach,
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.eslint_d.with({
			condition = function(utils)
				has_eslint_config(utils)
			end,
		}),
		null_ls.builtins.formatting.eslint_d.with({
			condition = function(utils)
				has_eslint_config(utils)
			end,
		}),
		null_ls.builtins.formatting.stylua,
	},
})

require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})
