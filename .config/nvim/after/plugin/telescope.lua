if not pcall(require, "telescope") then
	print("Plugin: telescope not found")
	return
end

require("telescope").setup({
	defaults = {
		wrap_results = true,
		file_ignore_patterns = { ".git/" },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

require("telescope").load_extension("fzf")

--[[

Telescope Pickers settings to quality of life. ¯\_(ツ)_/¯

--]]

local telescopePickers = {}

local telescopeUtilities = require("telescope.utils")
local telescopeMakeEntryModule = require("telescope.make_entry")
local plenaryStrings = require("plenary.strings")
local devIcons = require("nvim-web-devicons")
local telescopeEntryDisplayModule = require("telescope.pickers.entry_display")
local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon("fname", { default = true }))

-- Beautifier Telescope searches.
-- The default way that Telescope displays entries is not cool.
-- [Concatenating icon + relative path + small match preview] leaves the preview very messy.

-- Helper! Gets the File Path and its Tail (the file name) as a Tuple
function telescopePickers.getPathAndTail(fileName)
	local bufferNameTail = telescopeUtilities.path_tail(fileName)

	local pathWithoutTail = require("plenary.strings").truncate(fileName, #fileName - #bufferNameTail, "")

	local pathToDisplay = telescopeUtilities.transform_path({
		path_display = { "truncate = 6" },
	}, pathWithoutTail)

	return bufferNameTail, pathToDisplay
end

-- Generates a beautified Find File picker.
function telescopePickers.prettyFilesPicker(pickerAndOptions)
	if type(pickerAndOptions) ~= "table" or pickerAndOptions.picker == nil then
		print(
			"Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }"
		)

		return
	end

	local options = pickerAndOptions.options or {}

	local originalEntryMaker = telescopeMakeEntryModule.gen_from_file(options)

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)
		local displayer = telescopeEntryDisplayModule.create({
			separator = " ",
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, pathToDisplay = telescopePickers.getPathAndTail(entry.value)
			local tailForDisplay = tail .. " "
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

			return displayer({
				{ icon, iconHighlight },
				tailForDisplay,
				{ pathToDisplay, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end

	if pickerAndOptions.picker == "find_files" then
		require("telescope.builtin").find_files(options)
	elseif pickerAndOptions.picker == "git_files" then
		require("telescope.builtin").git_files(options)
	elseif pickerAndOptions.picker == "oldfiles" then
		require("telescope.builtin").oldfiles(options)
	elseif pickerAndOptions.picker == "" then
		print("Picker was not specified")
	else
		print("Picker is not supported by Pretty Find Files")
	end
end

-- Generates a beautified Grep String picker.
function telescopePickers.prettyGrepPicker(pickerAndOptions)
	if type(pickerAndOptions) ~= "table" or pickerAndOptions.picker == nil then
		print(
			"Incorrect argument format. Correct format is: { picker = 'desiredPicker', (optional) options = { ... } }"
		)

		return
	end

	local options = pickerAndOptions.options or {}

	local originalEntryMaker = telescopeMakeEntryModule.gen_from_vimgrep(options)

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)
		local displayer = telescopeEntryDisplayModule.create({
			separator = " ", -- Telescope will use this separator between each entry item
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ width = nil }, -- Maximum path size, keep it short
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, pathToDisplay = telescopePickers.getPathAndTail(entry.filename)
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)
			local coordinates = ""

			if not options.disable_coordinates then
				if entry.lnum then
					if entry.col then
						coordinates = string.format(" -> %s:%s", entry.lnum, entry.col)
					else
						coordinates = string.format(" -> %s", entry.lnum)
					end
				end
			end

			tail = tail .. coordinates

			local tailForDisplay = tail .. " "
			-- local text = options.file_encoding and vim.iconv(entry.text, options.file_encoding, "utf8") or entry.text

			return displayer({
				{ icon, iconHighlight },
				tailForDisplay,
				{ pathToDisplay, "TelescopeResultsComment" },
				-- text,
			})
		end

		return originalEntryTable
	end

	if pickerAndOptions.picker == "live_grep" then
		require("telescope.builtin").live_grep(options)
	elseif pickerAndOptions.picker == "grep_string" then
		require("telescope.builtin").grep_string(options)
	elseif pickerAndOptions.picker == "" then
		print("Picker was not specified")
	else
		print("Picker is not supported by Pretty Grep Picker")
	end
end

-- Generates a beautified Buffers picker.
function telescopePickers.prettyBuffersPicker(localOptions)
	if localOptions ~= nil and type(localOptions) ~= "table" then
		print("Options must be a table.")
		return
	end

	local options = localOptions or {}

	local originalEntryMaker = telescopeMakeEntryModule.gen_from_buffer(options)

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)

		local displayer = telescopeEntryDisplayModule.create({
			separator = " ",
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ width = nil },
				{ width = nil },
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, path = telescopePickers.getPathAndTail(entry.filename)
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

			return displayer({
				{ icon, iconHighlight },
				{ "(" .. entry.bufnr .. ")", "TelescopeResultsNumber" },
				{ entry.indicator, "TelescopeResultsComment" },
				{ tail },
				{ path, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end

	require("telescope.builtin").buffers(options)
end

-- Generates a beautified LSP References picker.
function telescopePickers.prettyLSPReferences(localOptions)
	if localOptions ~= nil and type(localOptions) ~= "table" then
		print("Options must be a table.")
		return
	end

	local options = localOptions or {}

	local originalEntryMaker = telescopeMakeEntryModule.gen_from_quickfix(options)

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)

		local displayer = telescopeEntryDisplayModule.create({
			separator = " ",
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ width = nil },
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, path = telescopePickers.getPathAndTail(entry.filename)
			local tailForDisplay = tail .. " "
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

			return displayer({
				{ icon, iconHighlight },
				tailForDisplay,
				{ path, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end

	require("telescope.builtin").lsp_references(options)
end

-- Generates a beautified LSP Implementation picker.
function telescopePickers.prettyLSPImplementations(localOptions)
	if localOptions ~= nil and type(localOptions) ~= "table" then
		print("Options must be a table.")
		return
	end

	local options = localOptions or {}

	local originalEntryMaker = telescopeMakeEntryModule.gen_from_quickfix(options)

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)

		local displayer = telescopeEntryDisplayModule.create({
			separator = " ",
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ width = nil },
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, path = telescopePickers.getPathAndTail(entry.filename)
			local tailForDisplay = tail .. " "
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

			return displayer({
				{ icon, iconHighlight },
				tailForDisplay,
				{ path, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end

	require("telescope.builtin").lsp_implementations(options)
end

-- Generates a beautified LSP Definitions picker.
function telescopePickers.prettyLSPDefinitions(localOptions)
	if localOptions ~= nil and type(localOptions) ~= "table" then
		print("Options must be a table.")
		return
	end

	local options = localOptions or {}
	local originalEntryMaker = telescopeMakeEntryModule.gen_from_quickfix(options)

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)

		local displayer = telescopeEntryDisplayModule.create({
			separator = " ",
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ width = nil },
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, path = telescopePickers.getPathAndTail(entry.filename)
			local tailForDisplay = tail .. " "
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

			return displayer({
				{ icon, iconHighlight },
				tailForDisplay,
				{ path, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end

	require("telescope.builtin").lsp_definitions(options)
end

-- Telescope + nvim-tree.
-- Generates a beautified Find directories picker.
-- Find directory and focus nvim-tree.
--
-- Require install `fd-find`.
-- Debian/Ubuntu: `apt install fd-find`.
function telescopePickers.prettyFindDirectoryAndFocus()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local function open_nvim_tree(prompt_bufnr, _)
		actions.select_default:replace(function()
			local api = require("nvim-tree.api")

			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			api.tree.open()
			api.tree.find_file(selection.cwd .. "/" .. selection.value)
		end)

		return true
	end

	local options = {
		find_command = { "fdfind", "--type", "directory", "--hidden", "--exclude", ".git/*" },
		attach_mappings = open_nvim_tree,
	}
	local originalEntryMaker = telescopeMakeEntryModule.gen_from_file({})

	options.entry_maker = function(line)
		local originalEntryTable = originalEntryMaker(line)
		local displayer = telescopeEntryDisplayModule.create({
			separator = " ",
			items = {
				{ width = fileTypeIconWidth },
				{ width = nil },
				{ remaining = true },
			},
		})

		originalEntryTable.display = function(entry)
			local tail, pathToDisplay = telescopePickers.getPathAndTail(entry.value)
			local icon, iconHighlight = telescopeUtilities.get_devicons(tail)

			return displayer({
				{ icon, iconHighlight },
				{ pathToDisplay .. "/" .. tail, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end

	require("telescope.builtin").find_files(options)
end

--[[

Awesome Telescope Mappings.

--]]

-- Go to Definition.
vim.keymap.set("n", "<leader>;d", function()
	telescopePickers.prettyLSPDefinitions()
end)

-- Go to References.
vim.keymap.set("n", "<leader>;r", function()
	telescopePickers.prettyLSPReferences()
end)

-- Go to Implementations (useful for Dependency Inversion).
vim.keymap.set("n", "<leader>;m", function()
	telescopePickers.prettyLSPImplementations()
end)

-- Find Files.
vim.keymap.set("n", "<leader>;f", function()
	telescopePickers.prettyFilesPicker({
		picker = "find_files",
		options = {
			no_ignore = false,
			hidden = true,
		},
	})
end)

-- Find Directories and focus with nvim-tree.
vim.keymap.set("n", "<leader>;i", function()
	telescopePickers.prettyFindDirectoryAndFocus()
end)

-- Live Grep.
vim.keymap.set("n", "<leader>;g", function()
	telescopePickers.prettyGrepPicker({ picker = "live_grep" })
end)

-- Grep String.
vim.keymap.set("n", "<leader>;s", function()
	telescopePickers.prettyGrepPicker({
		picker = "grep_string",
		options = {
			search = vim.fn.input("Grep String: "),
		},
	})
end)

-- Show Buffers.
vim.keymap.set("n", "<leader>;b", function()
	telescopePickers.prettyBuffersPicker()
end)
