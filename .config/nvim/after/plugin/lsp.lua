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

if not pcall(require, "lint") then
	print("Plugin: lint not found")
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
	automatic_enable = {
		exclude = { "oxlint", "eslint" },
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
local util = require("lspconfig.util")

local function has_file(names, bufnr)
	local use_unpack = table.unpack or unpack

	local filename = vim.api.nvim_buf_get_name(bufnr)
	local root = util.root_pattern(use_unpack(names))(filename)
	return root ~= nil
end

local function get_js_formatter(bufnr)
	-- Biome
	if has_file({
		"biome.json",
		"biome.jsonc",
	}, bufnr) then
		return { "biome" }
	end

	-- Oxc / Oxfmt
	if has_file({
		".oxfmtrc.json",
		".oxfmtrc.jsonc",
		"oxfmt.json",
	}, bufnr) then
		return { "oxfmt" }
	end

	-- ESLint + Prettier
	if
		has_file({
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
		}, bufnr)
	then
		return { "prettier" }
	end

	-- fallback
	return { "prettier" }
end

conform.setup({
	formatters_by_ft = {
		-- Provides formatter to Lua (:Mason install stylua).
		lua = { "stylua" },

		-- Provides formatter to Web environment with Prettier (:Mason install prettier).
		-- Biome and Oxfmt are also supported, but Prettier is the fallback.
		javascript = get_js_formatter,
		typescript = get_js_formatter,
		javascriptreact = get_js_formatter,
		typescriptreact = get_js_formatter,
		css = get_js_formatter,
		html = get_js_formatter,
		json = get_js_formatter,
		jsonc = get_js_formatter,
		graphql = get_js_formatter,
		yaml = get_js_formatter,
		markdown = get_js_formatter,

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

local lint = require("lint")

local function get_js_linter(bufnr)
	-- Biome
	if has_file({
		"biome.json",
		"biome.jsonc",
	}, bufnr) then
		return "biomejs"
	end

	-- Oxlint
	if has_file({
		"oxlint.json",
		".oxlintrc.json",
		".oxlintrc.jsonc",
	}, bufnr) then
		return "oxlint"
	end

	-- ESLint
	if
		has_file({
			".eslintrc",
			".eslintrc.js",
			".eslintrc.cjs",
			".eslintrc.json",
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			"eslint.config.mts",
			"eslint.config.cts",
		}, bufnr)
	then
		return "eslint_d"
	end

	-- fallback
	return nil
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.cjs", "*.mts", "*.cts" },
	callback = function(args)
		local linter = get_js_linter(args.buf)

		if linter ~= nil then
			lint.try_lint(linter)
		end
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
