return {
	-- LSP (Language Server Protocol).
	-- Native LSP provide (data/content) to the text editor: completion, diagnostics, hover, formatting, definition, ...
	-- Each language have your own LSP server.
	-- So the text editors can support multiples programming languages.
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Mason. Helps to install and manage the LSP servers.
		"williamboman/mason.nvim",

		-- nvim-cmp. Provides auto completion to editor.
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",

		-- lspkind. Provides icons to auto completion.
		"onsails/lspkind.nvim",

		-- Lua LSP configuraton helper.
		"folke/neodev.nvim",
		-- Lua snippet engine.
		"L3MON4D3/LuaSnip",

		-- @deprecated null-ls
		--
		-- Provides autofix.
		"jose-elias-alvarez/null-ls.nvim",
		"MunifTanjim/prettier.nvim",
	},
}
