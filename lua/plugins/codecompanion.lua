return {
	"olimorris/codecompanion.nvim",
	dev = false,
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"zbirenbaum/copilot.lua",
			cmd = "Copilot",
			event = "InsertEnter",
			opts = {},
		},
	},
	opts = {
		interactions = {
			chat = {
				auto_scroll = false,
			},
			cli = {
				agent = "claude_code",
				agents = {
					claude_code = {
						cmd = "claude",
						args = {},
						description = "Claude Code CLI",
						provider = "terminal",
					},
				},
			},
		},
		prompt_library = {
			markdown = {
				dirs = {
					vim.fn.getcwd() .. "/.prompts",
					vim.fn.stdpath("config") .. "/prompts",
				},
			},
		},
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					make_vars = false,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
		adapters = {
			acp = {
				claude_code = function()
					local token = os.getenv("CLAUDE_CODE_TOKEN")
					return require("codecompanion.adapters").extend("claude_code", {
						env = {
							CLAUDE_CODE_OAUTH_TOKEN = token,
						},
					})
				end,
			},
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
