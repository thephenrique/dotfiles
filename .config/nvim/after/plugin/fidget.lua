if not pcall(require, "fidget") then
	print("Plugin: fidget not found")
	return
end

require("fidget").setup()
