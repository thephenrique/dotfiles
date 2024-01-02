-- Credits to Emacs.
local function themeZenburn()
	if not pcall(require, "zenburn") then
		print("Plugin: zenburn not found")
		return
	end

	require("zenburn").setup()
end

local themes = {
	zenburn = themeZenburn,
}

themes.zenburn()
