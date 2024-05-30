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

local themes = {
	zenburn = themeZenburn,
	gruberDarker = themeGruberDarker,
}

themes.gruberDarker()
