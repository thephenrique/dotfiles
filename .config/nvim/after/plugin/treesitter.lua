if not pcall(require, "nvim-treesitter") then
	print("Plugin: nvim-treesitter not found")
	return
end

--[[

Troubleshooting

--]]

-- Fix weird problems... ¯\_(ツ)_/¯
-- :TSUninstall all
--
-- "query error: invalid node type at position"
-- Run, just the Treesitter's parser path must be returned.
-- :echo nvim_get_runtime_file('parser', v:true)
-- If you get `/usr/local/lib/nvim/parser`, try remove all `*.so` from this direcory.

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
		"markdown",

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
