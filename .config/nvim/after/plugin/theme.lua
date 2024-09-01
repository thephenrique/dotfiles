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

	require("modus-themes").setup({
		style = "modus_vivendi",
		on_colors = function(colors)
			colors.bg_dim = colors.bg_main
		end,
	})

	vim.cmd.colorscheme("modus")
end

local themes = {
	zenburn = themeZenburn,
	gruberDarker = themeGruberDarker,
	doomOne = themeDoomOne,
	modus = themeModus,
}

themes.modus()
