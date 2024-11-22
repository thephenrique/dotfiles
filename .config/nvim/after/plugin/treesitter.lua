if not pcall(require, "nvim-treesitter") then
	print("Plugin: nvim-treesitter not found")
	return
end

--- @diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"tsx",
		"html",
		"css",
		"json",
		"jsonc",
		"yaml",
		"regex",
		"graphql",
		"markdown",
		"dockerfile",

		"cpp",
		"make",
		"bash",

		"lua",
		"vim",
	},
	ignore_install = {
		"help",
	},
	sync_install = false,
	auto_install = true,
	indent = {
		-- It may cause slowdowns in large files (like 20k lines or 20k columns).
		-- Try disable Treesitter.
		enable = true,
		disable = {},
	},
	highlight = {
		-- It may cause slowdowns in large files (like 20k lines or 20k columns).
		-- Try disable Treesitter.
		enable = true,
		disable = {},
		additional_vim_regex_highlighting = false,
	},
	autotag = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
})

--[[

Troubleshooting

--]]

-- How to fix weird problems... ¯\_(ツ)_/¯
-- :TSUninstall all
--
-- "query error: invalid node type at position"
-- Run, just the Treesitter's parser path must be returned.
-- :echo nvim_get_runtime_file('parser', v:true)
-- If you get `/usr/local/lib/nvim/parser`, try remove all `*.so` from this direcory.
