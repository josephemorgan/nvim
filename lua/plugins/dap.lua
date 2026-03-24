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
		dap.defaults.fallback.switchbuf = "useopen,uselast"

		local adapters = {
			dart = {
				type = "executable",
				command = "flutter",
				args = { "debug_adapter" },
			},
			["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter.cmd",
					args = { "${port}" },
				},
			},
			["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "js-debug-adapter.cmd",
					args = { "${port}" },
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
		vscode.type_to_filetypes["pwa-chrome"] = js_filetypes
		vscode.type_to_filetypes["chrome"] = js_filetypes

		for _, language in ipairs(js_filetypes) do
			if not dap.configurations[language] then
				dap.configurations[language] = {
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Launch Chrome (Angular)",
						url = "https://localhost:4200",
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						skipFiles = {
							"<node_internals>/**",
							"**/node_modules/**",
						},
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdata",
					},
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach to Chrome",
						port = 9222,
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
						resolveSourceMapLocations = {
							"${workspaceFolder}/**",
							"!**/node_modules/**",
						},
						skipFiles = {
							"<node_internals>/**",
							"**/node_modules/**",
						},
					},
				}
			end
		end

		-- Load per-project .vscode/launch.json if present
		vscode.load_launchjs(nil, {
			["pwa-chrome"] = js_filetypes,
			["pwa-node"] = js_filetypes,
			["chrome"] = js_filetypes,
			["node"] = js_filetypes,
		})

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
			-- cs = {
			-- 	{
			-- 		type = "coreclr",
			-- 		name = "launch - netcoredbg",
			-- 		request = "launch",
			-- 		program = function()
			-- 			return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			-- 		end,
			-- 	},
			-- 	{
			-- 		type = "coreclr",
			-- 		name = "attach - netcoredbg",
			-- 		request = "attach",
			-- 		processId = require("dap.utils").pick_process,
			-- 	},
			-- },
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
