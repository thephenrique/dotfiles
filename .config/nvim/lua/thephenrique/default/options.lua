-- Ignore files when expand wildcards for completions.
vim.opt.wildignore = "__pycache__"
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.wildignore:append({ "*.o", "*~", "*.pyc", "*pycache*" })
vim.opt.wildignore:append({ "Cargo.lock", "Cargo.Bazel.lock" })
vim.opt.wildoptions = "pum"

-- Timers.
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 300

-- Spell check.
vim.opt.spell = false
vim.opt.spelllang = "en_us"

-- OS integration.
vim.opt.shell = "zsh"
vim.opt.clipboard:append({ "unnamedplus" })

-- Colors and transparency.
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 0

-- Cursor.
vim.opt.guicursor = "a:blinkon0"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Line.
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
-- Minimalist listchars. #Option 1.
vim.opt.listchars:append({ tab = "  " })
vim.opt.listchars:append({ trail = "·" })
-- Heavy listchars. #Option 2.
-- vim.opt.listchars:append({ lead = "·" })
-- vim.opt.listchars:append({ space = "·" })
-- Minimalist fillchars. #Option 1.
vim.opt.fillchars = { eob = " " }
-- Heavy fillchars. Option #2.
-- vim.opt.fillchars = {
-- 	eob = " ",
-- 	fold = " ",
-- 	horiz = "━",
-- 	horizup = "┻",
-- 	horizdown = "┳",
-- 	vert = "┃",
-- 	vertleft = "┫",
-- 	vertright = "┣",
-- 	verthoriz = "╋",
-- }

-- Buffer.
vim.opt.path:append({ "**" })
vim.opt.isfname:append("@-@")

-- Splits.
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"

-- Keys.
vim.opt.joinspaces = true
vim.opt.showmatch = true

-- Search and replace.
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Statusline and Command Bar.
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.ruler = false

-- Vertical columns.
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""

-- Fold.
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Identation, tabs and spaces.
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Diff Mode.
-- $ nvim -d file1 file2
vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- Save Undo History. ಠ_ಠ
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
-- Backup and ShaDa File (Shared Data).
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.shada = { "!", "'1000", "<50", "s10", "h" }

-- Encoding.
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
