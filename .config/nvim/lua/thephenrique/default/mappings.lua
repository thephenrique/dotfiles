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
-- <C-l> ::: To hide the highlight search (aka hlsearch).

-- Easily hit escape in Terminal Mode.
vim.keymap.set("t", "<Esc><Esc>", "<c-\\><c-n>")
-- Clear highlight. The <C-l> has overrited.
vim.keymap.set("n", "<leader>l", function()
	vim.cmd.noh()
	vim.cmd.redraw()
end)

-- Move selected line up/down.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Up and Down in Command Mode with arrows.
vim.keymap.set("c", "<Up>", "<C-p>")
vim.keymap.set("c", "<Down>", "<C-n>")

-- Keep the cursor in the center on some jumpings.
--
-- When join line.
vim.keymap.set("n", "J", "mzJ`z")
-- When scroll up/down.
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- When next/previous ::: * (next) ::: # (previous) :::
-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

-- Paste, but not replace the yanked text.
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- 6 is too far from CTRL. Alternate between two buffers.
vim.keymap.set("n", "<C-p>", "<C-6>")

-- Display up/down Quickfix items on buffer.
-- :copen ::: Open current list.
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz")

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
--
-- Without cool mappings:
-- :tabnew ::: Create a new tab.
-- :tabclose ::: Close the current tab.
vim.keymap.set("n", "<Right>", "gt")
vim.keymap.set("n", "<Left>", "gT")

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

-- Code Actions.
vim.keymap.set("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end)
-- Code Rename.
vim.keymap.set("n", "<leader>cr", function()
	vim.lsp.buf.rename()
end)

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
-- m ::: Toggle Mark for bulk operations.
-- bd ::: Delete marked items (files/directories).
--
-- <Tab> ::: Preview file without close NvimTreee.
-- o ::: Open to Buffer.
-- s ::: Run system.

-- <leader>;d ::: Go to Definition.
-- <leader>;r ::: Go to References.
-- <leader>;f ::: Find Files.
-- <leader>;i ::: Find Directories and focus with nvim-tree.
-- <leader>;m ::: Go to Implementation.
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
--

--[[

Mappings for "Compile Mode" from compile-mode.nvim.

--]]

-- :Compile ::: To accept an compile command. Example: go run
-- :Recompile ::: To... Recompile. :)
-- :NextError ::: To move the cursor to the next error in the source code (at source code Buffer).
-- :PrevError ::: To move the cursor to the previous error in the source code (at source code Buffer).
