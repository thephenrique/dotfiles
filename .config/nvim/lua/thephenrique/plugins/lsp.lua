return {
	-- LSP (Language Server Protocol).
	-- Native LSP provide (data/content) to the text editor: completion, diagnostics, hover, formatting, definition, ...
	-- Each language have your own LSP server.
	-- So the text editors can support multiples programming languages.
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Helps to install and manage the LSP servers.
		"williamboman/mason.nvim",
		-- Auto install LSP servers with Mason.
		"williamboman/mason-lspconfig.nvim",

		-- Lua LSP configuraton helper.
		"folke/neodev.nvim",

		-- Provides formatter helper.
		"stevearc/conform.nvim",
	},
}
