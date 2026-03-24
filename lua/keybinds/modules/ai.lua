---@type wk.Spec
return {
	"<leader>c",
	group = "Code [c]ompanion",
	{
		"<S-Tab>",
		mode = { "i" },
		vim.lsp.inline_completion.get,
		desc = "Accept Copilot Suggestion",
	},
	{
		"<S-Right>",
		mode = { "i" },
		function()
			vim.lsp.inline_completion.get({
				on_accept = function(item)
					-- Extract string value from insert_text (handles both string and lsp.StringValue)
					local insert_text = type(item.insert_text) == "table" and item.insert_text.value or item.insert_text

					if type(insert_text) ~= "string" then
						return nil
					end

					---@cast insert_text string

					local first_word = insert_text:match("%S+")
					if first_word then
						return first_word
					end

					return nil
				end,
			})
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
		"<leader>cp",
		function()
			return require("codecompanion").cli({ prompt = true })
		end,
		desc = "[p]rompt codecompanion agent",
		mode = { "n", "v" },
	},
	{
		"<leader>ct",
		"<cmd>CodeCompanionCLI<cr>",
		desc = "Open [t]erminal chat",
	},
	{
		"<leader>ca",
		function()
			require("codecompanion").actions({})
		end,
		desc = "[a]ctions",
	},
	{
		"<leader>ca",
		"<cmd>CodeCompanionChat Add<cr>",
		desc = "[a]dd to chat",
		mode = { "v" },
	},
}
