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

local string_starts_with = function(str, start)
	return string.sub(str, 1, #start) == start
end

local create_runtime_condition = function(config_names)
	local bufnr_cache = {}
	local config_path_cache = {}

	return function(params)
		if bufnr_cache[params.bufnr] ~= nil then
			return bufnr_cache[params.bufnr]
		else
			for _, cached_config_path in ipairs(config_path_cache) do
				if string_starts_with(params.bufname, cached_config_path) then
					bufnr_cache[params.bufnr] = true
					return true
				end
			end
		end

		local config_path = require("lspconfig").util.root_pattern(config_names)(params.bufname)

		local has_config = config_path ~= nil
		if has_config then
			table.insert(config_path_cache, config_path)
		end
		bufnr_cache[params.bufnr] = has_config

		return has_config
	end
end

local eslint_runtime_condition = create_runtime_condition({
	".eslintrc.cjs",
	".eslintrc.js",
	".eslintrc.json",
	".eslintrc.yaml",
	".eslintrc.yml",
})

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
			runtime_condition = eslint_runtime_condition,
		}),
		null_ls.builtins.formatting.eslint_d.with({
			runtime_condition = eslint_runtime_condition,
		}),
		null_ls.builtins.formatting.stylua,
	},
})

require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})
