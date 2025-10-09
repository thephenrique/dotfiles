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

-- How To Debug Go HTTP Application.
--
-- Allow ptrace temporarily.
-- 1. echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
-- Setup environment.
-- 1. Build Go application with the Debugging Information flags: `-gcflags="all=-N -l"`.
-- 2. Run the binary application.
-- 3. Set a breakpoint in the first function that will be called, for example, the handler/controller (not the route/router) of an endpoint.
-- 4. <F2> - "5. Attach" - Attach to the running application. Search by name, for example, "bin/app".
-- 5. Done! Call the endpoint.
--
-- How To Debug Go Tests (from the cursor position).
--
-- 1. Position the cursor on the test function that will be called.
-- 2. Set a breakpoint.
-- 3. <F2> - "7. Debug test (go.mod)"

dap.set_log_level("TRACE")
vim.keymap.set("n", "<F1>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F2>", dap.continue)
vim.keymap.set("n", "<F3>", dap.step_into)
vim.keymap.set("n", "<F4>", dap.step_over)
vim.keymap.set("n", "<F5>", dap.step_out)
vim.keymap.set("n", "<F6>", dap.run_to_cursor)
vim.keymap.set("n", "<F11>", dap.run_last)
vim.keymap.set("n", "<F12>", dap.restart)

vim.keymap.set("n", "<leader>?", function()
	---@diagnostic disable-next-line: missing-fields
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
