if not pcall(require, "fidget") then
	print("Plugin: fidget not found")
	return
end

require("fidget").setup({
	progress = {
		ignore_empty_message = false, -- Allow LSP messages from `tsserver`.
	},
})
