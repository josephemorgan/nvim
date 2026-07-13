return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"mason-org/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "js-debug-adapter")
		end,
	},
	lazy = false,
	config = function()
		local dap = require("dap")
		dap.defaults.fallback.switchbuf = "useopen,uselast"

		local is_wsl = vim.fn.has("wsl") == 1
		local chrome_executable = is_wsl and "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" or nil
		-- In WSL, pass --user-data-dir directly as a runtime arg with a Windows path
		-- so js-debug never tries to resolve it as a Linux path (which would make it
		-- relative to the project CWD and create a garbage directory there).
		local chrome_user_data_dir
		local chrome_runtime_args
		if is_wsl then
			local win_user = vim.fn.trim(
				vim.fn.system(
					"/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NonInteractive -Command '$env:USERNAME'"
				)
			)
			chrome_user_data_dir = false
			chrome_runtime_args = {
				"--remote-debugging-port=9222",
				"--user-data-dir=C:\\Users\\" .. win_user .. "\\AppData\\Local\\Temp\\chrome-debug-profile",
			}
		else
			chrome_user_data_dir = "${workspaceFolder}/.chrome"
			chrome_runtime_args = { "--remote-debugging-port=9222" }
		end

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
						sourceMapPathOverrides = {
							["localhost:4200/@fs/*"] = "*",
							["localhost:4200/*"] = "${webRoot}/*",
						},
						skipFiles = {
							"<node_internals>/**",
							"**/node_modules/**",
						},
						runtimeExecutable = chrome_executable,
						userDataDir = chrome_user_data_dir,
						runtimeArgs = chrome_runtime_args,
					},
					{
						type = "pwa-chrome",
						request = "attach",
						name = "Attach to Chrome",
						port = 9222,
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
						sourceMapPathOverrides = {
							["localhost:4200/@fs/*"] = "*",
							["localhost:4200/*"] = "${webRoot}/*",
						},
						skipFiles = {
							"<node_internals>/**",
							"**/node_modules/**",
						},
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
