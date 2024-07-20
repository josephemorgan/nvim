return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "rcarriga/cmp-dap", "mxsdev/nvim-dap-vscode-js" },
		lazy = false,
		config = function()
			local dap = require("dap")

			require("dap-vscode-js").setup({
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
				debugger_path = "/home/joe/.dotfiles/nvim/.config/nvim/vscode-js-debug",
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${workspaceFolder}/out/${fileBasenameNoExtension}.js",
						cwd = "${workspaceFolder}",
					},
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end

			-- dap.configurations["typescript"] = {}
			-- require("dap.ext.vscode").load_launchjs(nil, { ["pwa-node"] = { "typescript" } })
		end,
	},
}
