return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mxsdev/nvim-dap-vscode-js",
		{
			"Joakker/lua-json5",
			build = "./install.sh",
		},
	},
	lazy = false,
	config = function()
		local dap = require("dap")

		local adapters = {
			dart = {
				type = "executable",
				command = "flutter",
				args = { "debug_adapter" },
			},
			coreclr = {
				type = "executable",
				command = "C:/Users/morganj/AppData/Local/nvim-data/mason/bin/netcoredbg.cmd",
				args = { "--interpreter=vscode" },
				options = {
					detached = false,
				},
			},
			["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			},
		}

		local configurations = {
			dart = {
				{
					type = "dart",
					request = "launch",
					name = "Launch Flutter",
					-- The nvim-dap plugin populates this variable with the filename of the current buffer
					program = "${workspaceFolder}/lib/main.dart",
					-- The nvim-dap plugin populates this variable with the editor's current working directory
					cwd = "${workspaceFolder}",
					-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
					toolArgs = { "-d", "emulator-5554" },
				},
			},
			cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
					end,
				},
				{
					type = "coreclr",
					name = "attach - netcoredbg",
					request = "attach",
					processId = require("dap.utils").pick_process,
				},
			},
			javascript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			},
			typescript = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
			},
		}

		for k, v in pairs(adapters) do
			dap.adapters[k] = v
		end
		for k, v in pairs(configurations) do
			dap.configurations[k] = v
		end
	end,
}
