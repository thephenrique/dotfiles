if not pcall(require, "nvim-treesitter") then
	print("Plugin: nvim-treesitter not found")
	return
end

if not pcall(require, "ufo") then
	print("Plugin: ufo not found")
	return
end

require("ufo").setup({
	provider_selector = function()
		return { "treesitter", "indent" }
	end,
})
