local fzf_lua = require("fzf-lua")

fzf_lua.setup({
	"max-perf",
	winopts = {
		fullscreen = true,
		preview = {
			default = "builtin",
		},
	},
	actions = {
		files = {
			["default"] = fzf_lua.actions.file_edit_or_qf,
			["alt-v"] = fzf_lua.actions.file_vsplit,
			["alt-s"] = fzf_lua.actions.file_split,
		},
	},
})

vim.keymap.set("n", "<leader>;f", fzf_lua.files)
vim.keymap.set("n", "<leader>;b", fzf_lua.buffers)

vim.keymap.set("n", "<leader>;g", fzf_lua.live_grep_native)
vim.keymap.set("n", "<leader>;s", function()
	fzf_lua.grep({
		search = vim.fn.input("Grep String: "),
	})
end)

vim.keymap.set("n", "<leader>;d", fzf_lua.lsp_definitions)
vim.keymap.set("n", "<leader>;r", fzf_lua.lsp_references)
vim.keymap.set("n", "<leader>;i", fzf_lua.lsp_implementations)

vim.keymap.set("n", "<leader>;;", fzf_lua.resume)
