--[[

LSP settings.

--]]

if not pcall(require, "lspconfig") then
	print("Plugin: lspconfig not found")
	return
end

if not pcall(require, "mason") then
	print("Plugin: mason not found")
	return
end

if not pcall(require, "mason-lspconfig") then
	print("Plugin: mason-lspconfig not found")
	return
end

if not pcall(require, "cmp_nvim_lsp") then
	print("Plugin: cmp_nvim_lsp not found")
	return
end

if not pcall(require, "neodev") then
	print("Plugin: neodev not found")
	return
end

vim.diagnostic.config({
	virtual_text = true,
})

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- LSP servers management.
require("mason").setup()

-- Auto install LSP servers with Mason.
mason_lspconfig.setup({
	ensure_installed = {
		"tsserver",
		"eslint",
		-- prettierd
		"html",
		"cssls",
		"jsonls",
		"yamlls",
		"dockerls",
		"docker_compose_language_service",

		"clangd",
		"cmake",
		"bashls",
		-- "shfmt",

		"lua_ls",
		-- stylua
	},
})

-- Lua LSP configuraton helper.
require("neodev").setup({})

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true -- Allow HTML and CSS completions.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

-- Auto setup LSP servers from Mason.
local installed_servers = mason_lspconfig.get_installed_servers()
for _, server_name in ipairs(installed_servers) do
	lspconfig[server_name].setup({
		capabilities = updated_capabilities,
	})
end

-- Setup Lua LSP server.
lspconfig.lua_ls.setup({
	capabilities = updated_capabilities,
	settings = {
		Lua = {
			workspace = {
				checkThirdParty = false,
			},
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

--[[

Formatter/Autoformat settings.

--]]

if not pcall(require, "conform") then
	print("Plugin: conform not found")
	return
end

local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		-- Provides formatter to Lua (:Mason install stylua).
		lua = { "stylua" },

		-- Provides formatter to Web environment with Prettier (:Mason install prettierd).
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		graphql = { "prettierd" },
		markdown = { "prettierd" },

		-- Provides formatter to shell (:Mason install shfmt).
		sh = { "shfmt" },
	},
	formatters = {
		shfmt = {
			prepend_args = { "-i", "2", "-ci", "-bn" },
		},
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf, lsp_fallback = true })
	end,
})
