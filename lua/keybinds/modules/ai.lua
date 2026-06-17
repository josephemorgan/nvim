-- Module-local state for tier-2 quick-edit (regenerate support)
local _last_inline = nil

local function _run_inline(prompt, range_prefix)
	vim.cmd((range_prefix or "") .. "CodeCompanion " .. prompt)
end

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
	{
		"<leader>ci",
		function()
			vim.ui.input({ prompt = "Quick edit: " }, function(input)
				if not input or input == "" then
					return
				end
				_last_inline = { prompt = input }
				_run_inline(input)
			end)
		end,
		desc = "[i]nline edit at cursor",
	},
	{
		"<leader>ci",
		function()
			-- Capture marks now — visual selection exits before ui.input callback fires
			local range = "'<,'>"
			vim.ui.input({ prompt = "Quick edit selection: " }, function(input)
				if not input or input == "" then
					return
				end
				_last_inline = { prompt = input, range = range }
				_run_inline(input, range)
			end)
		end,
		mode = { "v" },
		desc = "[i]nline edit selection",
	},
	{
		"<leader>cr",
		function()
			if not _last_inline then
				vim.notify("No previous inline edit to regenerate", vim.log.levels.WARN)
				return
			end
			_run_inline(_last_inline.prompt, _last_inline.range)
		end,
		mode = { "n", "v" },
		desc = "[r]egenerate last inline edit",
	},
}
