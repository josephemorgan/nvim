return {
	"olimorris/codecompanion.nvim",
	dev = false,
	lazy = false,
	branch = "v18",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"ravitemer/mcphub.nvim",
			build = "bundled_build.lua",
			opts = {
				use_bundled_binary = true,
			},
		},
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			opts = {
				panel = {
					enabled = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					hide_during_completion = true,
					debounce = 75,
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			},
		},
	},
	opts = {
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
		adapters = {
			http = {
				tavily = function()
					local key = os.getenv("TAVILY_API_KEY")

					return require("codecompanion.adapters").extend("tavily", {
						env = {
							api_key = key,
						},
					})
				end,
			},
		},
		rules = {
			opts = {
				chat = {
					enabled = true,
				},
			},
			default = {
				files = {
					"AGENTS.md",
				},
			},
			copilot = {
				files = {
					".github/copilot-instructions.md",
				},
			},
		},
	},
}
