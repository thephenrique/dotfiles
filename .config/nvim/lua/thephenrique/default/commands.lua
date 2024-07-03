-- Highlight the yanked text for 200ms.
vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  augroup END
]])

-- Set local settings for Terminal buffers.
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 10

		vim.bo.filetype = "terminal"
	end,
})
