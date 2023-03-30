local cmp = require("cmp")

local ensureInstalledServers = {
	"tsserver",
	"lua_ls",
	"jsonls",
	"html",
	"cssls",
	"dockerls",
	"docker_compose_language_service",
	"angularls",
	"tailwindcss",
	"yamlls",
	"bashls",
	"denols",
}

-- UTILS
local function filter(arr, fn)
	if type(arr) ~= "table" then
		return arr
	end

	local filtered = {}
	for k, v in pairs(arr) do
		if fn(v, k, arr) then
			table.insert(filtered, v)
		end
	end

	return filtered
end

local function filterReactDTS(value)
	return string.match(value.targetUri, "%.d.ts") == nil
end

local lspUtils = require("lspconfig.util")
local lsp = require("lsp-zero").preset({
	name = "minimal",
	set_lsp_keymaps = { preserve_mappings = false },
	manage_nvim_cmp = {
		set_basic_mappings = true,
		set_extra_mappings = true,
		set_sources = false,
		use_luasnip = false,
		set_format = true,
		documentation_window = true,
	},
	suggest_lsp_servers = true,
	configure_diagnostics = true,
	float_border = "rounded",
})

lsp.ensure_installed(ensureInstalledServers)

-- SUMNEKO_LUA CUSTOMIZATION
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- TSSERVER CUSTOMIZATION
lsp.configure("tsserver", {
	root_dir = lspUtils.root_pattern("package.json"),
	handlers = {
		["textDocument/definition"] = function(err, result, method, ...)
			if vim.tbl_islist(result) and #result > 1 then
				local filtered_result = filter(result, filterReactDTS)
				return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
			end

			vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
		end,
	},
})

-- DENOLS CUSTOMIZATION
lsp.configure("denols", {
	root_dir = lspUtils.root_pattern("deno.json", "deno.jsonc"),
	single_file_support = false,
})

-- ADDITIONAL CUSTOMIZATION
lsp.set_sign_icons({
	error = "E",
	warn = "W",
	hint = "H",
	info = "I",
})

-- AUTOCOMPLETE
cmp.setup({
	sources = {
		{ name = "nvim_lsp", keyword_length = 1 },
		{ name = "path" },
		{ name = "buffer", keyword_length = 3 },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
})

-- LSP SETUP
lsp.setup()
