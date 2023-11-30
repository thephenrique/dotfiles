if not pcall(require, "nvim-treesitter") then
	print("Plugin: nvim-treesitter not found")
	return
end

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		-- Web requirements.
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"json",
		"yaml",
		"regex",
		"graphql",

		"lua",
	},
	ignore_install = {
		"help",
	},
	sync_install = false,
	auto_install = true,
	indent = {
		enable = true,
		disable = {},
	},
	highlight = {
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
})
