if not pcall(require, "Comment") then
	print("Plugin: Comment not found")
	return
end

local comment = require("Comment")

comment.setup({
	-- JSX/TSX support.
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})
