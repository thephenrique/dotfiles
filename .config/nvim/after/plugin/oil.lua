if not pcall(require, "oil") then
	print("Plugin: oil not found")
	return
end

if not pcall(require, "oil-git-status") then
	print("Plugin: oil-git-status not found")
	return
end

require("oil").setup({
	columns = {
		"icon",
		"permissions",
		"size",
	},
	confirmation = {
		padding = 4,
		border = "bold",
	},
	keymaps = {
		["<M-v>"] = { "actions.select", opts = { vertical = true, close = true } },
		["<C-h>"] = false,
		["<C-s>"] = false,
		["<C-l>"] = false,
		["<leader>l"] = "actions.refresh",
		["gy"] = {
			desc = "Copy filepath to system clipboard",
			callback = function()
				require("oil.actions").copy_entry_path.callback()

				local oil = require("oil")
				local dir = oil.get_current_dir()
				local entry = oil.get_cursor_entry()
				local relative_path = vim.fn.fnamemodify(dir, ":.")

				vim.fn.setreg("+", relative_path .. entry.name)
			end,
		},
	},
	-- Required by oil-git-status.nvim
	win_options = {
		signcolumn = "yes:2",
	},
})

require("oil-git-status").setup({
	show_ignored = false,
})
