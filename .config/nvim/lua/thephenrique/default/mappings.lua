--[[

Mappings for: ¯\_(ツ)_/¯

--]]

-- Move selected line up/down.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep the cursor in the center on some jumpings.
--
-- When join line.
vim.keymap.set("n", "J", "mzJ`z")
-- When scroll up/down.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- When next/previous ::: * (next) ::: # (previous) :::
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste, but not replace the yanked text in Visual Mode.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Move between Quickfix and show the Buffer.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Resize horizontal splits.
vim.keymap.set("n", "<C-w><", "20<C-w><")
vim.keymap.set("n", "<C-w>>", "20<C-w>>")

-- General open file in vertical split.
-- Inside of nvim-tree, Telescope, ...
-- <C-v> ::: to open a file in vertical split.

--[[

Mappings for: Current file/buffer.

--]]

-- Multiple Cursors.
-- <C-n> ::: in Visual Mode to init.
--
-- Auto completions.
-- Inside of nvim-cmp floating windows:
-- <C-p> <C-n> <C-y> <Tab> ::: in Insert Mode to move around and confirm auto completions.
--
-- Comment.
-- gc ::: in Visual Mode for line comment.
-- gb ::: in Visual Mode for block comment.
--
-- Fold.
-- za ::: Fold current.
-- zM ::: Fold all.
-- zR ::: Unfold all.

--[[

Mappings for: Search/Replace and Move inside of file/buffer.

--]]

-- Hover.
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover()
end)
-- Open Diagnostic.
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float()
end)
-- Next Diagnostic.
vim.keymap.set("n", "<leader>j", function()
	vim.diagnostic.goto_next()
end)
-- Prev Diagnostic.
vim.keymap.set("n", "<leader>k", function()
	vim.diagnostic.goto_prev()
end)

--[[

Mappings for: Search/Replace and Move inside of file/buffer.

--]]

-- Toggle File Explorer (nvim-tree).
vim.keymap.set("n", ";t", ":NvimTreeToggle<CR>")
-- Focus file in File Explorer (nvim-tree).
vim.keymap.set("n", ";tt", ":NvimTreeFindFile<CR>")
-- nvim-tree
--
-- q ::: Close NvimTree.
-- P ::: Move cursor to parent directory.
-- W ::: Collapse all.
-- I ::: Toggle Git ignored files/directories.
-- H ::: Toggle hidden files/directories.
--
-- y ::: Copy file/directory name.
-- Y ::: Copy relative path.
-- a ::: Create file or directory/.
-- r ::: Rename file or directory/.
-- c ::: Copy file/directory.
-- p ::: Paste file/directory.
-- x ::: Cut file/directory.
-- d ::: Delete file/directory.
--
-- o ::: Open to Buffer.
-- s ::: Run system.

-- Go to Definition.
vim.keymap.set("n", ";d", "<Cmd>Telescope lsp_definitions<CR>")
-- Go to References.
vim.keymap.set("n", ";r", "<Cmd>Telescope lsp_references<CR>")

-- Find Files.
vim.keymap.set("n", ";f", "<Cmd>Telescope find_files no_ignore=false hidden=true<CR>")
-- Live Grep.
vim.keymap.set("n", ";g", "<Cmd>Telescope live_grep<CR>")
-- Show Buffers.
vim.keymap.set("n", ";b", "<Cmd>Telescope buffers<CR>")
-- Resume (show last query/search).
vim.keymap.set("n", ";;", "<Cmd>Telescope resume<CR>")

--[[

Mappings for: Search/Replace and Move inside of file/buffer.

--]]

-- Split with git status (vim-fugitive).
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
