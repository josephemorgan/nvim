---@type wk.Spec
return {
	"<leader>c",
	group = "Code [c]ompanion",
	{
		"<S-Tab>",
		mode = { "i" },
		function()
			if require("copilot.suggestion").is_visible() then
				require("copilot.suggestion").accept()
			end
		end,
		desc = "Accept Copilot Suggestion",
	},
	{
		"<S-Right>",
		mode = { "i" },
		function()
			if require("copilot.suggestion").is_visible() then
				require("copilot.suggestion").accept_word()
			end
		end,
		desc = "Accept Copilot Suggestion Word",
	},
	{
		"<leader>ct",
		desc = "Toggle Copilot [t]rigger",
		function()
			require("copilot.suggestion").toggle_auto_trigger()
		end,
	},
	{
		"<leader>cc",
		"<cmd>CodeCompanionChat Toggle<cr>",
		desc = "Toggle [c]hat",
	},
	{
		"<leader>cn",
		"<cmd>CodeCompanionChat<cr>",
		desc = "[n]ew chat",
	},
	{
		"<leader>ca",
		"<cmd>CodeCompanionChat Add<cr>",
		desc = "[a]dd to chat",
		mode = { "v" },
	},
	{
		"<leader>ca",
		function()
			require("codecompanion").actions({})
		end,
		desc = "[a]ctions",
	},
}
