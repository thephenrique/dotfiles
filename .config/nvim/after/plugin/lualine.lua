if not pcall(require, "lualine") then
	print("Plugin: lualine not found")
	return
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = "horizon",
		theme = "Tomorrow", -- Only for DoomOne (light)
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { {
			"filename",
			file_status = true,
			path = 1,
		} },
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_diagnostic" },
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
			"encoding",
			"filetype",
		},
		lualine_y = { "" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { {
			"filename",
			file_status = true,
			path = 1,
		} },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree" },
})
