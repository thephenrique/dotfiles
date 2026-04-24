local colorbuddy = require("colorbuddy")

vim.cmd.colorscheme("gruvbuddy")

local Group = colorbuddy.Group
local Color = colorbuddy.Color
local colors = colorbuddy.colors

-- Perfection.
Color.new("darkBlue", "#324c5d")
Group.new("Visual", nil, colors.darkBlue)
