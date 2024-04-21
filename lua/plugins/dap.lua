return {
	"mfussenegger/nvim-dap",
	dependencies = { "rcarriga/cmp-dap", "mxsdev/nvim-dap-vscode-js" },
	lazy = false,
	config = function()
		require("dap-vscode-js").setup({
			debugger_path = "/home/joe/.config/nvim/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
			log_file_path = "/home/joe/.config/nvim/logs.log",
			log_file_level = vim.log.levels.TRACE,
		})

		local dap = require("dap")

		-- local custom_adapter = "pwa-node-custom"
		-- dap.adapters[custom_adapter] = function(cb, config)
		-- 	if config.preLaunchTask then
		-- 		local async = require("plenary.async")
		-- 		local notify = require("notify").async
		--
		-- 		async.run(function()
		-- 			---@diagnostic disable-next-line: missing-parameter
		-- 			notify("Running [" .. config.preLaunchTask .. "]").events.close()
		-- 		end, function()
		-- 			vim.fn.system(config.preLaunchTask)
		-- 			config.type = "pwa-node"
		-- 			dap.run(config)
		-- 		end)
		-- 	end
		-- end

		for _, language in ipairs({ "typescript", "javascript" }) do
			require("dap").configurations[language] = {
				{
					name = "Launch",
					type = "pwa-node",
					request = "launch",
					program = "${file}",
					rootPath = "${workspaceFolder}/src",
					cwd = "${workspaceFolder}/",
					sourceMaps = true,
					skipFiles = { "<node_internals>/**" },
					protocol = "inspector",
					resolveSourceMapLocations = {
						"${workspaceFolder}/build/**",
						"!**/node_modules/**",
					},
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "launch",
					name = "Debug Jest Tests",
					-- trace = true, -- include debugger info
					runtimeExecutable = "node",
					runtimeArgs = {
						"./node_modules/jest/bin/jest.js",
						"--runInBand",
					},
					rootPath = "${workspaceFolder}",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
				},
			}
		end
	end,
}
