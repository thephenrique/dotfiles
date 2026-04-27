-- Force C filetype.
vim.g.c_syntax_for_h = 1

-- LSP: Diagnostic.
vim.diagnostic.config({
	virtual_text = true,
	severity_sort = true,
	float = { border = "rounded" },
})

-- LSP: Completion.
vim.opt.autocomplete = true
vim.opt.completeopt = { "menuone", "noselect", "popup", "fuzzy" }

-- Disable providers.
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Timers.
vim.opt.updatetime = 1000
vim.opt.timeoutlen = 500

-- OS Integrations.
vim.opt.shell = "zsh"
vim.opt.clipboard:append({ "unnamedplus" })

-- Line numbers.
vim.opt.relativenumber = true
vim.opt.number = true
-- Line whitespaces.
vim.opt.list = true
vim.opt.listchars:append({ tab = "  " })
vim.opt.listchars:append({ trail = "·" })
vim.opt.fillchars = { eob = " " }
-- Line wrap.
vim.opt.wrap = false

-- Viewport.
vim.opt.scrolloff = 2
vim.opt.signcolumn = "yes"
-- Viewport Splits.
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.laststatus = 3
vim.opt.ruler = false

-- Search.
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true

-- Folding.
vim.opt.foldenable = true
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Indentation.
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Paths.
vim.opt.isfname:append("@-@")

-- Persistence.
vim.opt.undofile = true
vim.opt.swapfile = false
