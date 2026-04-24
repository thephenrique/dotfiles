--        __  __               __                    _
--       / /_/ /_  ___  ____  / /_  ___  ____  _____(_)___ ___  _____
--      / __/ __ \/ _ \/ __ \/ __ \/ _ \/ __ \/ ___/ / __ `/ / / / _ \    Pedro
--     / /_/ / / /  __/ /_/ / / / /  __/ / / / /  / / /_/ / /_/ /  __/    https:github.com/thephenrique
--     \__/_/ /_/\___/ .___/_/ /_/\___/_/ /_/_/  /_/\__, /\__,_/\___/
--                  /_/                               /_/

require("options")
require("keymaps")
require("autocmds")

-- System dependency requirements:
-- tree-sitter-cli (for treesitter)
-- bat (for fzf-lua)
-- wget (for mason)

vim.pack.add({
	-- mini.icons
	{ src = "https://github.com/echasnovski/mini.icons" },

	-- TODO: It has been archived.
	-- Use it until compatibility with Neovim breaks, or until the community presents an alternative.
	-- treesitter.nvim (archived)
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- Language Server Protocol (LSP)
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- mason.nvim
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },

	-- conform.nvim
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- lualine.nvim
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },

	-- colorbuddy.nvim
	{ src = "https://github.com/tjdevries/colorbuddy.nvim" },

	-- fidget.nvim
	{ src = "https://github.com/j-hui/fidget.nvim" },

	-- oil.nvim
	{ src = "https://github.com/refractalize/oil-git-status.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },

	-- fzf-lua
	{ src = "https://github.com/ibhagwan/fzf-lua" },

	-- vim-visual-multi
	{ src = "https://github.com/mg979/vim-visual-multi" },

	-- neogit
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/neogitorg/neogit" },
})
