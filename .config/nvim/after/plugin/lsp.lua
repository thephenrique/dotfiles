if not pcall(require, "lspconfig") then
	print("Plugin: lspconfig not found")
	return
end

if not pcall(require, "lspkind") then
	print("Plugin: lspkind not found")
	return
end

if not pcall(require, "mason") then
	print("Plugin: mason not found")
	return
end

if not pcall(require, "cmp") then
	print("Plugin: cmp not found")
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

if not pcall(require, "luasnip") then
	print("Plugin: luasnip not found")
	return
end

vim.diagnostic.config({
	virtual_text = true,
})

local lspconfig = require("lspconfig")
local cmp = require("cmp")

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

-- Setup auto completions.
cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	},
	snippet = {
		expand = function(args)
			-- Lua snippet engine.
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end),
		["<C-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
			else
				cmp.complete()
			end
		end),
		["<C-y>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.config.disable,
	},
	formatting = {
		format = require("lspkind").cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
		}),
	},
})

if not pcall(require, "null-ls") then
	print("Plugin: null-ls not found")
	return
end

if not pcall(require, "prettier") then
	print("Plugin: prettier not found")
	return
end

-- @deprecated null-ls
--
-- :Mason Install prettier
-- :Mason Install stylua
--
-- Provides autofix to: JS environment.
-- With null-ls + prettier.
-- Just tsserver + eslint is not enough. ¯\_(ツ)_/¯
--
-- Provides autofix to: Lua.
require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_command([[augroup Format]])
			vim.api.nvim_command([[autocmd! * <buffer>]])
			vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
			vim.api.nvim_command([[augroup END]])
		end
	end,
})

require("prettier").setup({
	bin = "prettier",
	filytypes = {
		"css",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"scss",
		"less",
	},
})
