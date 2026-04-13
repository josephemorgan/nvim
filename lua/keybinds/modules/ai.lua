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
					local insert_text = item.insert_text
					if type(insert_text) == "string" then
						local range = item.range
						if range then
							local lines = vim.split(insert_text, "\n")
							local current_lines = vim.api.nvim_buf_get_text(
								range.start.buf,
								range.start.row,
								range.start.col,
								range.end_.row,
								range.end_.col,
								{}
							)

							local row = 1
							while row <= #lines and row <= #current_lines and lines[row] == current_lines[row] do
								row = row + 1
							end

							local col = 1
							while
								row <= #lines
								and col <= #lines[row]
								and row <= #current_lines
								and col <= #current_lines[row]
								and lines[row][col] == current_lines[row][col]
							do
								col = col + 1
							end

							local word = string.match(lines[row]:sub(col), "%s*[^%s]%w*")
							item.insert_text = table.concat(vim.list_slice(lines, 1, row - 1), "\n")
								.. (row <= #current_lines and "" or "\n")
								.. (row <= #lines and col <= #lines[row] and lines[row]:sub(1, col - 1) or "")
								.. word
						end
					end
					return item
				end,
			})
		end,
		desc = "Accept Copilot Suggestion Word",
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
