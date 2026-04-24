local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"ts_ls",
		"html",
		"cssls",

		"eslint",
		"oxfmt",
		"biome",

		"dockerls",
		"docker_compose_language_service",

		"bashls",

		"jsonls",
		"yamlls",

		"lua_ls",
		"stylua",

		"clangd",

		"gopls",
	},
	automatic_enable = true,
})

mason_tool_installer.setup({
	ensure_installed = {
		"prettier",
		"shfmt",
		"xmlformatter",
	},
})
