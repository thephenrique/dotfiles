--[[

Git settings.

--]]

if not pcall(require, "neogit") then
	print("Plugin: neogit not found")
	return
end

if not pcall(require, "gitsigns") then
	print("Plugin: gitsigns not found")
	return
end

-- User interface to Git.
require("neogit").setup({})

-- Git decorations inside of Buffer.
require("gitsigns").setup({})
