local dap = require("dap")

local gdbattach = function()
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",

		args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
	}
end

local launch = {
	name = "Launch",
	type = "gdb",
	request = "launch",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
	stopAtBeginningOfMainSubprogram = false,
}

local attach = {
	name = "Select and attach to process",
	type = "gdb",
	request = "attach",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	pid = function()
		local name = vim.fn.input("Executable name (filter): ")
		return require("dap.utils").pick_process({ filter = name })
	end,
	cwd = "${workspaceFolder}",
}

local attachserver = {
	name = "Attach to gdbserver :1234",
	type = "gdb",
	request = "attach",
	target = "localhost:1234",
	program = function()
		return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	end,
	cwd = "${workspaceFolder}",
}


gdbattach()
dap.configurations.c = { launch, attach, attachserver }
dap.configurations.cpp = { launch, attach, attachserver }

