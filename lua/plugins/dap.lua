return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "js-debug-adapter")
		end,
		-- "mxsdev/nvim-dap-vscode-js",
		-- {
		-- 	"Joakker/lua-json5",
		-- 	build = "./install.sh",
		-- },
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
			["pwa-chrome"] = {
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
			nlua = function(callback, config)
				callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
			end,
		}

		for k, v in pairs(adapters) do
			dap.adapters[k] = v
		end

		local vscode = require("dap.ext.vscode")
		local js_filetypes = { "javascript", "typescript" }
		vscode.type_to_filetypes["node"] = js_filetypes
		vscode.type_to_filetypes["pwa-node"] = js_filetypes

		for _, language in ipairs(js_filetypes) do
			if not dap.configurations[language] then
				dap.configurations[language] = {
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
					{
						type = "pwa-chrome",
						name = "Attach to Chrome",
						request = "attach",
						cwd = "${workspaceFolder}",
						sourceMaps = true,
						protocol = "inspector",
						port = 9222,
						webRoot = "${workspaceFolder}",
						-- urlFilter = "http://localhost:4200/*", -- alternative to url
						trace = true,
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Chrome and Attach",
						url = "https://localhost:4200",
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdata",
						webRoot = "${workspaceFolder}",
						trace = true,
					},
				}
			end
		end

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
			lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			},
		}

		for k, v in pairs(configurations) do
			dap.configurations[k] = v
		end

		-- require("easy-dotnet.netcoredbg").register_dap_variables_viewer()
	end,
}
