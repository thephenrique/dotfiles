--[[

Mappings for ¯\_(ツ)_/¯ .

--]]

-- Good to know...
--
-- :so ::: To source the current updated Neovim settings.
-- :LspRestart ::: To restart the LSP, when it breaks.
-- :checkhealth ::: To check if all Neovim features is working well.
-- :Lazy ::: To manage the Neovim plugins with lazy.nvm.
-- :Mason ::: To manage the Neovim LSP with mason.nvm.
-- <C-f> ::: Use on Command Mode to allow Vim Motions during write/search/edit a command.

-- Think of it as clear/done here ¯\_(ツ)_/¯ .
-- But, any real problem, we have <ESC> and <C-c>.
vim.keymap.set("i", "<C-l>", "<ESC>")

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
vim.keymap.set("n", "<C-w>>", "20<C-w>>")
vim.keymap.set("n", "<C-w><", "20<C-w><")
-- Resize horizontal splits.
vim.keymap.set("n", "<C-w>.", "10<C-w>+")
vim.keymap.set("n", "<C-w>,", "10<C-w>-")

-- General open file in vertical split.
-- Inside of nvim-tree, Telescope, ...
-- <C-v> ::: to open a file in vertical split.

--[[

Mappings for current Buffer write.
And documentation for builtin mappings of some plugins.

--]]

-- Multiple Cursors.
--   `vim-visual-multi` Leader Key ::: \\
--   `vim-visual-multi` switch between Cursor and Extend Modes ::: <Tab>
--   `vim-visual-multi` Cursor Mode is similar to Neovim Normal Mode.
--   `vim-visual-multi` Extend Mode is similar to Neovim Visual Mode.
--
--   <C-n> ::: in Visual Mode to init Extend Mode.
--   <leader>a ::: in Cursor Mode to align regions.
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
vim.keymap.set("n", "<leader>;t", ":NvimTreeFindFile<CR>")
-- nvim-tree
--
-- q ::: Close NvimTree.
-- W ::: Collapse all.
-- - ::: Up. Go back to parent directory.
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
-- <Tab> ::: Preview file without close NvimTreee.
-- o ::: Open to Buffer.
-- s ::: Run system.

-- <leader>;d ::: Go to Definition.
-- <leader>;r ::: Go to References.
-- <leader>;f ::: Find Files.
-- <leader>;i ::: Find Directories and focus with nvim-tree.
-- <leader>;g ::: Live Grep.
-- <leader>;s ::: Grep String.
-- <leader>;b ::: Show Buffers.
-- Resume (show last query/search).
vim.keymap.set("n", "<leader>;;", "<Cmd>Telescope resume<CR>")

--[[

Mappings for Git integration.

--]]

-- Neogit.
-- Split with git status (neogit).
vim.keymap.set("n", "<leader>gs", "<Cmd>Neogit<CR>")

-- Git on Buffer.
-- On changed line, Git Preview Hunk.
vim.keymap.set("n", "<leader>gp", "<Cmd>Gitsigns preview_hunk<CR>")
-- On changed line, Git Reset Hunk.
vim.keymap.set("n", "<leader>gr", "<Cmd>Gitsigns reset_hunk<CR>")
-- Toggle Git blame. Display on current line.
vim.keymap.set("n", "<leader>gb", "<Cmd>Gitsigns toggle_current_line_blame<CR>")
-- Diffview. Displays the entire Git history of current Buffer.
vim.keymap.set("n", "<leader>gho", "<Cmd>:DiffviewFileHistory %<CR>")
-- Diffview. Close Diffview.
vim.keymap.set("n", "<leader>ghc", "<Cmd>:DiffviewClose<CR>")

-- Git conflicts. High contrast!
-- co ::: With Git conflicts, choose Current/Ours change.
-- ct ::: With Git conflicts, choose Incoming/Theirs change.
-- cb ::: With Git conflicts, choose both.

--[[

Mappings for Markdown integration.

--]]

-- Markdown Preview.
-- :MarkdownPreview ::: Open Markdown preview.
