if not pcall(require, "nvim-tree") then
	print("Plugin: nvim-tree not found")
	return
end

require("nvim-tree").setup({
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		adaptive_size = true,
	},
	renderer = {
		group_empty = true,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	filters = {
		dotfiles = true,
	},
})
