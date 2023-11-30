if not pcall(require, "zenburn") then
	print("Plugin: zenburn not found")
	return
end

require("zenburn").setup()
