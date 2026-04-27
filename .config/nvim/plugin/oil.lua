local oil = require("oil")
local oil_git_status = require("oil-git-status")

local mini_icons = require("mini.icons")

mini_icons.setup()
mini_icons.mock_nvim_web_devicons()

oil.setup({
	columns = {
		"icon",
		"permissions",
		"size",
	},
	view_options = {
		show_hidden = true,
	},
	confirmation = {
		padding = 4,
		border = "bold",
	},
	constrain_cursor = "name",
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

oil_git_status.setup({
	show_ignored = false,
})

-- Open oil.nvim in current Buffer.
vim.keymap.set("n", "-", "<CMD>Oil<CR>")

-- Open oil.nvim in parent directory of current Buffer.
-- Useful when you have 2 splits of Oil and want to bring files from other directories to the current one.
vim.keymap.set("n", "<leader>-", [[:Oil <C-r>=substitute(expand('%:p:h'), 'oil://', '', '')<CR>]])
