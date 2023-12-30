--[[

Mappings for ¯\_(ツ)_/¯ .

--]]

-- Move selected line up/down.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

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

-- Paste, but not replace the yanked text.
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Display up/down Quickfix items on buffer.
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")

-- Resize vertical splits.
-- I generally only use vertical splits.
vim.keymap.set("n", "<C-w><", "20<C-w><")
vim.keymap.set("n", "<C-w>>", "20<C-w>>")

-- General open file in vertical split.
-- Inside of nvim-tree, Telescope, ...
-- <C-v> ::: to open a file in vertical split.

--[[

Mappings for current Buffer write.
And documentation for builtin mappings of some plugins.

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

Mappings for current Buffer diagnostics.

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

Mappings for Working Directory navigation.

--]]

-- Focus file in File Explorer (nvim-tree).
-- Close on open.
vim.keymap.set("n", ";t", ":NvimTreeFindFile<CR>")
-- nvim-tree
--
-- q ::: Close NvimTree.
-- W ::: Collapse all.
-- P ::: Move cursor to parent directory.
-- K ::: Move cursor to first children file/directory.
-- J ::: Move cursor to last children file/directory.
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
-- Grep String + filter files + RegEx.
vim.keymap.set("n", ";s", ":Telescope grep_string search=")
-- Show Buffers.
vim.keymap.set("n", ";b", "<Cmd>Telescope buffers<CR>")
-- Resume (show last query/search).
vim.keymap.set("n", ";;", "<Cmd>Telescope resume<CR>")

--[[

Mappings for Git integration.

--]]

-- Split with git status (neogit).
vim.keymap.set("n", "<leader>gs", "<Cmd>Neogit<CR>")

-- On changed line, Git Preview Hunk.
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>")
-- On changed line, Git Reset Hunk.
vim.keymap.set("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>")

--[[

Mappings for Markdown integration.

--]]

-- Markdown Preview.
-- :MarkdownPreview ::: Open Markdown preview.
