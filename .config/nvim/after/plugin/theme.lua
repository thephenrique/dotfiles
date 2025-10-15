-- Credits to Emacs.

local function themeZenburn()
	if not pcall(require, "zenburn") then
		print("Plugin: zenburn not found")
		return
	end

	require("zenburn").setup()
end

local function themeGruberDarker()
	if not pcall(require, "gruber-darker") then
		print("Plugin: gruber-darker not found")
		return
	end

	vim.cmd.colorscheme("gruber-darker")
end

local function themeDoomOne()
	if not pcall(require, "doom-one") then
		print("Plugin: doom-one not found")
		return
	end

	vim.opt.background = "light"
	vim.g.doom_one_plugin_telescope = true
	vim.cmd.colorscheme("doom-one")
end

local function themeModus()
	if not pcall(require, "modus-themes") then
		print("Plugin: modus-themes not found")
		return
	end

	---@diagnostic disable-next-line: missing-fields
	require("modus-themes").setup({
		style = "modus_vivendi",
		on_colors = function(colors)
			colors.bg_diff_context = "#ff00ff"
			colors.bg_dim = colors.bg_main
		end,
	})

	-- Multiple Cursors: `vim-multi-cursor` plugin.
	-- Setup theme.
	vim.g.VM_theme = "codedark"

	vim.cmd.colorscheme("modus")
end

local function themeGruvbox()
	-- Soft contrast.
	vim.cmd.colorscheme("gruvbox-material")
end

local function themeColorbuddy()
	local ok, colorbuddy = pcall(require, "colorbuddy")
	if not ok then
		print("Plugin: colorbuddy not found")
		return
	end

	vim.cmd.colorscheme("gruvbuddy")

	local Group = colorbuddy.Group
	local Color = colorbuddy.Color
	local colors = colorbuddy.colors

	-- Perfection.
	Color.new("darkBlue", "#324c5d")
	Group.new("Visual", nil, colors.darkBlue)
end

local themes = {
	zenburn = themeZenburn,
	gruberDarker = themeGruberDarker,
	doomOne = themeDoomOne,
	modus = themeModus,
	gruvbox = themeGruvbox,
	colorboddy = themeColorbuddy,
}

themes.colorboddy()

return themes
