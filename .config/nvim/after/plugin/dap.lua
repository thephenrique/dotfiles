--[[

DAP settings.

--]]

if not pcall(require, "dap") then
	print("Plugin: dap not found")
	return
end

if not pcall(require, "dap-go") then
	print("Plugin: dap-go not found")
	return
end

if not pcall(require, "dapui") then
	print("Plugin: dapui not found")
	return
end

local dap = require("dap")
local dapui = require("dapui")

require("dap-go").setup()

dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.40 },
				{ id = "breakpoints", size = 0.30 },
				{ id = "stacks", size = 0.30 },
				-- { id = "watches", size = 0.25 },
			},
			size = 60,
			position = "left",
		},
		{
			elements = {
				"repl",
				-- "console",
			},
			size = 15,
			position = "bottom",
		},
	},
})

--[[

Mappings for DAP.

--]]

-- How To Debug Go Application.
--
-- Allow ptrace temporarily.
-- 1. echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
-- 2. Build Go application with the Debugging Information flags enabled.
-- 3. Run application.
-- 4. Set a breakpoint.
-- 5. <F2> - Attach to running application.
--
-- How To Debug Go Tests (from the cursor).
--
-- 1. Set a breakpoint.
-- 2. <F2> - "7. Debug test (go.mod)"

vim.keymap.set("n", "<F1>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F2>", dap.continue)
vim.keymap.set("n", "<F3>", dap.step_into)
vim.keymap.set("n", "<F4>", dap.step_over)
vim.keymap.set("n", "<F5>", dap.step_out)
vim.keymap.set("n", "<F11>", dap.run_last)
vim.keymap.set("n", "<F12>", dap.restart)
-- vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

vim.keymap.set("n", "<space>?", function()
	dapui.eval(nil, { enter = true })
end)

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end
