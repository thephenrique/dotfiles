--        __  __               __                    _
--       / /_/ /_  ___  ____  / /_  ___  ____  _____(_)___ ___  _____
--      / __/ __ \/ _ \/ __ \/ __ \/ _ \/ __ \/ ___/ / __ `/ / / / _ \    Pedro
--     / /_/ / / /  __/ /_/ / / / /  __/ / / / /  / / /_/ / /_/ /  __/    https:github.com/thephenrique
--     \__/_/ /_/\___/ .___/_/ /_/\___/_/ /_/_/  /_/\__, /\__,_/\___/
--                  /_/                               /_/

-- [[ Awesome Neovim configuration ]] --

-- Mapping Leader key.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Import default global Neovim settings.
require("thephenrique.default.builtin")
require("thephenrique.default.options")
require("thephenrique.default.mappings")
require("thephenrique.default.commands")

-- Bootstrap the plugin manager (lazy.nvim).
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Load the plugins.
require("lazy").setup("thephenrique.plugins")
