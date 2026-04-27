-- Leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal Mode in Terminal Mode.
vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>")

-- Clear highlight.
vim.keymap.set("n", "<leader>l", function()
	vim.cmd.noh()
	vim.cmd.redraw()
	vim.cmd.edit()
end)

-- Move selected line up/down.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Alternate between current and previous buffer (6 is too far from CTRL).
vim.keymap.set("n", "<leader><leader>", "<C-6>")

-- Up/Down in the Quickfix.
-- :copen ::: Open Quickfix.
vim.keymap.set("n", "<M-k>", "<CMD>cprev<CR>zz")
vim.keymap.set("n", "<M-j>", "<CMD>cnext<CR>zz")

-- Move between splits.
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Resize vertical splits.
vim.keymap.set("n", "<M-Right>", "5<C-w>>")
vim.keymap.set("n", "<M-Left>", "5<C-w><")
-- Resize horizontal splits.
vim.keymap.set("n", "<M-Up>", "5<C-w>+")
vim.keymap.set("n", "<M-Down>", "5<C-w>-")

-- Move between tabs.
-- :tabnew ::: Create a new tab.
-- :tabclose ::: Close the current tab.
vim.keymap.set("n", "<Right>", "gt")
vim.keymap.set("n", "<Left>", "gT")

-- Code Actions.
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
-- Code Rename.
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename)

-- Diagnostic Hover.
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({
		border = "bold",
	})
end)
-- Open Diagnostic.
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
-- Next Diagnostic.
vim.keymap.set("n", "<leader>j", function()
	vim.diagnostic.jump({ count = 1 })
end)
-- Prev Diagnostic.
vim.keymap.set("n", "<leader>k", function()
	vim.diagnostic.jump({ count = -1 })
end)
