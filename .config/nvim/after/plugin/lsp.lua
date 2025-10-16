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

vim.diagnostic.config({
	virtual_text = true,
})

require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

-- Auto install LSP servers with Mason.
mason_lspconfig.setup({
	ensure_installed = {
		"ts_ls",
		"eslint",
		"html",
		"cssls",
		"jsonls",
		"yamlls",
		"dockerls",
		"docker_compose_language_service",
		"cmake",
		"bashls",
		"gopls",
		"lua_ls",

		-- For some reason it doesn't install itself.
		--
		-- prettier - Enabled.
		-- clangd
		-- kotlin_language_server
		-- shfmt
		-- xmlformatter
		-- stylua
		--
		-- ltex-ls (Grammar)
		-- texlab (LSP)
		-- latexindent (Formatter)
	},
})

-- Custom config to Lua LSP.
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

-- Custom config to the offline grammar checking LTeX.
-- https://valentjn.github.io/ltex/index.html
-- vim.lsp.config("ltex", {
-- 	on_attach = function()
-- 		-- Add support to extra features like "Add to dictionary".
-- 		require("ltex_extra").setup({
-- 			load_langs = { "pt-BR" },
-- 			path = vim.fn.expand("~") .. "/.config/nvim/spell",
-- 		})
-- 	end,
-- 	settings = {
-- 		ltex = {
-- 			enabled = { "latex", "tex", "markdown" },
-- 			language = "pt-BR",
-- 			additionalRules = {
-- 				enablePickyRules = true,
-- 				motherTongue = "pt-BR",
-- 			},
-- 		},
-- 	},
-- })

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

		-- Provides formatter to Web environment with Prettier (:Mason install prettier).
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		jsonc = { "prettier" },
		yaml = { "prettier" },
		graphql = { "prettier" },
		markdown = { "prettier" },

		-- Provides formatter to shell (:Mason install shfmt).
		sh = { "shfmt" },

		-- Provides formatter to XML (:Mason install xmlformatter).
		xml = { "xmlformatter" },
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

-- Enable native Inlay Hint on Neovim:
-- vim.lsp.inlay_hint.enable(true)
--
-- Must setup settings of each LSP (tsserver, gopls , ...).
--
-- Setup settings examples:
-- https://github.com/MysticalDevil/inlay-hints.nvim#languages

--[[

Troubleshooting

--]]

-- Check if conform are running the expected formatter or the LSP provided formatter.
-- If all fail. Try change the formatter. ¯\_(ツ)_/¯
-- :ConformInfo
