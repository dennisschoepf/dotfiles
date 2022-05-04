local disable_formatting = require("nvim-lsp-setup.utils").disable_formatting
local filter = require("metalvim.utils").filter
local filterReactDTS = require("metalvim.utils").filterReactDTS

require("nvim-lsp-setup").setup({
	-- nvim-lsp-installer
	-- https://github.com/williamboman/nvim-lsp-installer#configuration
	installer = {
		ensure_installed = { "sumneko_lua", "tsserver", "emmet_ls", "jsonls" },
	},
	-- Default mappings
	-- gD = 'lua vim.lsp.buf.declaration()',
	-- gd = 'lua vim.lsp.buf.definition()',
	-- gt = 'lua vim.lsp.buf.type_definition()',
	-- gi = 'lua vim.lsp.buf.implementation()',
	-- gr = 'lua vim.lsp.buf.references()',
	-- K = 'lua vim.lsp.buf.hover()',
	-- ['<C-k>'] = 'lua vim.lsp.buf.signature_help()',
	-- ['<space>rn'] = 'lua vim.lsp.buf.rename()',
	-- ['<space>ca'] = 'lua vim.lsp.buf.code_action()',
	-- ['<space>f'] = 'lua vim.lsp.buf.formatting()',
	-- ['<space>e'] = 'lua vim.lsp.diagnostic.show_line_diagnostics()',
	-- ['[d'] = 'lua vim.lsp.diagnostic.goto_prev()',
	-- [']d'] = 'lua vim.lsp.diagnostic.goto_next()',
	default_mappings = true,
	mappings = {
		gr = 'lua require"telescope.builtin".lsp_references()',
	},
	-- Global on_attach
	on_attach = function(client, _) -- <- 2nd argument = bufnr
		require("nvim-lsp-setup.utils").format_on_save(client)
	end,
	-- Global capabilities
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	-- Configuration of LSP servers
	servers = {
		-- Install LSP servers automatically
		-- LSP server configuration please see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		["sumneko_lua"] = require("lua-dev").setup({
			lspconfig = {
				on_attach = function(client, _)
					-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
					disable_formatting(client)
				end,
			},
		}),
		["tsserver"] = {
			on_attach = function(client, _)
				disable_formatting(client)
			end,
			handlers = {
				["textDocument/definition"] = function(err, result, method, ...)
					if vim.tbl_islist(result) and #result > 1 then
						local filtered_result = filter(result, filterReactDTS)
						return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
					end

					vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
				end,
			},
		},
		["emmet_ls"] = {
			filetypes = { "html", "css" },
		},
		["jsonls"] = {},
	},
})
