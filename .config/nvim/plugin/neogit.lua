local neogit = require("neogit")
local gitsigns = require("gitsigns")

neogit.setup({})

vim.keymap.set("n", "<leader>gg", "<CMD>Neogit<CR>")

vim.keymap.set("n", "<leader>gj", function()
	gitsigns.nav_hunk("next")
end)
vim.keymap.set("n", "<leader>gk", function()
	gitsigns.nav_hunk("prev")
end)

vim.keymap.set("n", "<leader>gp", "<CMD>Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<leader>gr", "<CMD>Gitsigns reset_hunk<CR>")
vim.keymap.set("n", "<leader>gb", "<CMD>Gitsigns toggle_current_line_blame<CR>")
