local dnsc_utils = require("dnsc.utils")

local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
	nmap("gd", vim.lsp.buf.definition(), "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
	nmap("gl", vim.lsp.buf.hover, "Hover")
	nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, { desc = "Format current buffer with LSP" })
end

require("mason").setup()
require("mason-lspconfig").setup()

local servers = {
	-- TSServer not included here -> Configuration with typescript-tools below
	html = {},
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
			telemetry = { enable = false },
			diagnostics = { globals = "vim" },
		},
	},
	efm = {},
}

require("neodev").setup()

-- Broadcast capabilities to nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		})
	end,
})

-- Typescript-specific setup
require("typescript-tools").setup({
	on_attach = on_attach,
	handlers = {
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.tbl_islist(result) and #result > 1 then
				local filtered_result = dnsc_utils.filter(result, dnsc_utils.filterReactDTS)
				return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
			end

			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
	settings = {
		separate_diagnostic_server = true,
		publish_diagnostic_on = "insert_leave",
		tsserver_plugins = {},
		tsserver_max_memory = "auto",
		tsserver_format_options = {},
		tsserver_file_preferences = {},
		tsserver_locale = "en",
		complete_function_calls = false,
		include_completions_with_insert_text = true,
		code_lens = "off",
		disable_member_code_lens = true,
		jsx_close_tag = {
			enable = true,
			filetypes = { "javascriptreact", "typescriptreact" },
		},
	},
})

-- EFM Setup
local eslint = require("efmls-configs.linters.eslint_d")
local prettier = require("efmls-configs.formatters.prettier_d")
local stylua = require("efmls-configs.formatters.stylua")
local luacheck = require("efmls-configs.linters.luacheck")
local ansible_lint = require("efmls-configs.linters.ansible_lint")
local shellcheck = require("efmls-configs.linters.shellcheck")
local shfmt = require("efmls-configs.formatters.shfmt")
local golangci_lint = require("efmls-configs.linters.golangci_lint")
local gofumpt = require("efmls-configs.formatters.gofumpt")

local languages = {
	bash = { shellcheck, shfmt },
	css = { prettier },
	go = { golangci_lint, gofumpt },
	javascript = { eslint, prettier },
	javascriptreact = { eslint, prettier },
	json = { prettier },
	lua = { stylua, luacheck },
	typescript = { eslint, prettier },
	typescriptreact = { eslint, prettier },
	sh = { shellcheck, shfmt },
	yaml = { ansible_lint, prettier },
}

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	settings = {
		rootMarkers = { "package.json", ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
		codeAction = true
	},
}

require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
	on_attach = on_attach,
	capabilities = capabilities,
}))

-- Auto Format with EFM on save (if a linter/formatter is registered)
local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = lsp_fmt_group,
	callback = function(ev)
		local efm = vim.lsp.get_active_clients({ name = "efm", bufnr = ev.buf })

		if vim.tbl_isempty(efm) then
			return
		end

		vim.lsp.buf.format({ name = "efm" })
	end,
})
