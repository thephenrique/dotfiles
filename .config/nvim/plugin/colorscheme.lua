local function colorbuddy()
	local _colorbuddy = require("colorbuddy")

	vim.cmd.colorscheme("gruvbuddy")

	local Group = _colorbuddy.Group
	local Color = _colorbuddy.Color
	local colors = _colorbuddy.colors

	-- Perfection.
	Color.new("darkBlue", "#324c5d")
	Group.new("Visual", nil, colors.darkBlue)
end

local function zenburn()
	vim.cmd.colorscheme("zenburn")
end

local colorschemes = {
	colorbuddy = colorbuddy,
	zenburn = zenburn,
}

colorschemes.zenburn()
