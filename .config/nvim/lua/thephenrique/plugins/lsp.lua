return {
	-- LSP (Language Server Protocol).
	-- Native LSP provide (data/content) to the text editor: completion, diagnostics, hover, formatting, definition, ...
	-- Each language have your own LSP server.
	-- So the text editors can support multiples programming languages.
	"neovim/nvim-lspconfig",
	dependencies = {
		-- -- Helps to install and manage the LSP servers.
		{
			"mason-org/mason.nvim",
			opts = {},
		},
		-- -- Auto install LSP servers with Mason.
		"mason-org/mason-lspconfig.nvim",
		-- -- Provides formatter helper.
		"stevearc/conform.nvim",
	},
}
