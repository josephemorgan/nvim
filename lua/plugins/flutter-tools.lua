return {
	"nvim-flutter/flutter-tools.nvim",
	ft = "dart",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	opts = {
		decorations = {
			statusline = {
				device = true,
			},
		},
		debugger = {
			enabled = true,
			register_configurations = function()
				require("dap").configurations.dart = {}
				require("dap.ext.vscode").load_launchjs()
			end,
		},
		closing_tags = {
			enabled = false,
		},
		dev_log = {
			enabled = false,
		},
		dev_tools = {
			autostart = true,
			auto_open_browser = true,
		},
		lsp = {
			settings = {
				lineLength = 120,
			},
			capabilities = {
				textDocument = {
					formatting = {
						dynamicRegistration = false,
					},
				}
			}
		}
	},
}
