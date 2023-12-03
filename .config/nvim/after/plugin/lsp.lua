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

-- LSP servers management.
require("mason").setup()

-- Lua LSP configuraton helper.
require("neodev").setup({})

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true -- Allow HTML and CSS completions.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }

-- Setup Lua LSP server (:Mason install lua-language-server).
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

-- Setup ESLint LSP server (:Mason install eslint-lsp).
--
-- @TODO This guy is a little slow on Neovim first load.
lspconfig.eslint.setup({
	capabilities = updated_capabilities,
})

-- Setup TypeScript LSP server (:Mason install typescript-language-server).
lspconfig.tsserver.setup({
	capabilities = updated_capabilities,
})

-- Setup CSS LSP server (:Mason install css-lsp).
lspconfig.cssls.setup({
	capabilities = updated_capabilities,
})

-- Setup HTML LSP server (:Mason install html-lsp).
lspconfig.html.setup({
	capabilities = updated_capabilities,
})

-- Setup bash LSP server (:Mason install bash-language-server).
lspconfig.bashls.setup({
	capabilities = updated_capabilities,
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

-- @deprecated null-ls
--
-- Provider formatter to Lua and Web environment.
-- :Mason Install prettier
-- :Mason Install stylua

-- if not pcall(require, "null-ls") then
-- 	print("Plugin: null-ls not found")
-- 	return
-- end
--
-- if not pcall(require, "prettier") then
-- 	print("Plugin: prettier not found")
-- 	return
-- end
--
-- require("null-ls").setup({
-- 	sources = {
-- 		require("null-ls").builtins.formatting.stylua,
-- 	},
-- 	on_attach = function(client)
-- 		if client.server_capabilities.documentFormattingProvider then
-- 			vim.api.nvim_command([[augroup Format]])
-- 			vim.api.nvim_command([[autocmd! * <buffer>]])
-- 			vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
-- 			vim.api.nvim_command([[augroup END]])
-- 		end
-- 	end,
-- })
--
-- require("prettier").setup({
-- 	bin = "prettier",
-- 	filytypes = {
-- 		"css",
-- 		"javascript",
-- 		"javascriptreact",
-- 		"typescript",
-- 		"typescriptreact",
-- 		"json",
-- 		"scss",
-- 		"less",
-- 	},
-- })
