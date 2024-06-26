return {
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		-- Git decorations inside of Buffer.
		"lewis6991/gitsigns.nvim",
	},
	{
		-- Git conflict helper.
		"akinsho/git-conflict.nvim",
		config = true,
	},
	{
		-- Git improve diffs.
		-- Mainly used for Git history.
		"sindrets/diffview.nvim",
	},
}
