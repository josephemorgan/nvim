return {
	"olimorris/codecompanion.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"ravitemer/mcphub.nvim",
			opts = {},
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
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
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
		prompt_library = {
			["Test Commit Message"] = {
				strategy = "chat",
				description = "Generate a commit message",
				opts = {
					index = 10,
					is_default = true,
					is_slash_cmd = true,
					short_name = "commit",
					auto_submit = true,
				},
				prompts = {
					{
						role = "user",
						content = function()
							local diff = vim.system({ "git", "diff", "--no-ext-diff", "--staged" }, { text = true })
								:wait()
							return string.format(
								[[You are an expert at following the Conventional Commit specification. Given the git diff listed below, please generate a commit message for me:

```diff
%s
```
]],
								diff.stdout
							)
						end,
						opts = {
							contains_code = true,
						},
					},
				},
			},
		},
	},
}
