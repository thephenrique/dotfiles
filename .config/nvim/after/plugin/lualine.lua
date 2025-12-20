if not pcall(require, "lualine") then
	print("Plugin: lualine not found")
	return
end

-- A custom filename component that shows Oil paths nicely.
local function smart_filename()
	local bufname = vim.api.nvim_buf_get_name(0)

	if not bufname:match("^oil://") then
		return require("lualine.components.filename")
			:new({
				file_status = true,
				path = 1,
			})
			:update_status()
	end

	local cwd = vim.loop.cwd():gsub("/$", "")
	local oil_path = bufname:gsub("^oil://", "")

	local relative = oil_path:gsub("^" .. vim.pesc(cwd), "")
	relative = relative:gsub("^/", "")

	return "oil:///" .. relative
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = "zenburn", -- Good for Gruvbox theme.
		theme = "horizon", -- Good for Zenburn theme.
		-- theme = "Tomorrow", -- Only for DoomOne (light)
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = {},
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { smart_filename },
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
