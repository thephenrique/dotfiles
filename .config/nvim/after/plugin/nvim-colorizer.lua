if not pcall(require, "colorizer") then
	print("Plugin: nvim-colorizer not found")
	return
end

require("colorizer").setup({
	"css",
	"html",
})
