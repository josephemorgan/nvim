---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(items, opts, on_choice)
	opts = opts or {}
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local themes = require("telescope.themes")

	-- Use dropdown theme for a cleaner look
	local picker_opts = themes.get_dropdown({})

	pickers
		.new(picker_opts, {
			prompt_title = opts.prompt or "Select one of:",
			finder = finders.new_table({
				results = items,
				entry_maker = function(item)
					local idx = nil
					for i, v in ipairs(items) do
						if v == item then
							idx = i
							break
						end
					end
					local display = opts.format_item and opts.format_item(item) or tostring(item)
					return {
						value = item,
						display = display,
						ordinal = display,
						index = idx,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					if selection then
						on_choice(selection.value, selection.index)
					else
						on_choice(nil, nil)
					end
				end)
				return true
			end,
		})
		:find()
end

---@diagnostic disable-next-line: duplicate-set-field
vim.ui.input = function(opts, on_confirm)
	opts = opts or {}
	local prompt = opts.prompt or "Input: "
	local default = opts.default or ""

	-- Create buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { default })

	-- Calculate window size and position
	local width = math.max(40, #prompt + 10)
	local height = 1
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = prompt,
		title_pos = "left",
	})

	-- Set buffer options
	vim.bo[buf].buftype = "prompt"
	vim.fn.prompt_setprompt(buf, "")

	-- Start in insert mode at end of default text
	vim.cmd("startinsert!")

	-- Confirm on Enter
	vim.keymap.set("i", "<CR>", function()
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		local input = lines[1] or ""
		vim.api.nvim_win_close(win, true)
		on_confirm(input)
	end, { buffer = buf })

	-- Cancel on Escape
	vim.keymap.set({ "i", "n" }, "<Esc>", function()
		vim.api.nvim_win_close(win, true)
		on_confirm(nil)
	end, { buffer = buf })
end
