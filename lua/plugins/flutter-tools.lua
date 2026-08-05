local pubCacheDir = vim.env.PUB_CACHE or vim.fn.expand("$HOME/AppData/Local/Pub/Cache")

return {
	"nvim-flutter/flutter-tools.nvim",
	ft = "dart",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim", -- optional for vim.ui.select
	},
	dev = true,
	opts = {
		decorations = {
			statusline = {
				device = true,
			},
		},
		debugger = {
			enabled = true,
			-- register_configurations = function()
			-- 	require("dap").configurations.dart = {}
			-- 	require("dap.ext.vscode").load_launchjs()
			-- end,
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
				-- Relative entries resolve against each workspace folder, so build output
				-- stays out of analysis in every Flutter project without hardcoding paths.
				analysisExcludedFolders = { pubCacheDir, "build", ".dart_tool" },
			},
			capabilities = {
				textDocument = {
					formatting = {
						dynamicRegistration = false,
					},
				},
				workspace = {
					-- Declining watcher registration keeps nvim from watching the whole
					-- build tree. Cost: run :LspRestart after changes made outside nvim
					-- (client regeneration, branch switches).
					didChangeWatchedFiles = {
						dynamicRegistration = false,
					},
				},
			},
		},
	},
}
