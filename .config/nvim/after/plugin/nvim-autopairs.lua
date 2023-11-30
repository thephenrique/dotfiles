if not pcall(require, "nvim-autopairs") then
	print("Plugin: nvim-autopairs not found")
	return
end

require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})
