-- UI overrides configuration (vim.ui.select, vim.ui.input, vim.fn.confirm)
local M = {}

function M.setup()
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

	---Override vim.fn.confirm with a floating window picker (synchronous)
	---@param msg string The confirmation message
	---@param choices? string The choices string (e.g., "&Yes\n&No\n&Cancel")
	---@param default? integer The default choice (1-indexed)
	---@param type? string The dialog type (unused, kept for API compatibility)
	---@return integer The selected choice (1-indexed), or 0 if cancelled
	vim.fn.confirm = function(msg, choices, default, type)
		choices = choices or "&Ok"
		default = default or 1

		-- Parse choices string into a table
		local choice_list = {}
		local accelerators = {}
		for choice in choices:gmatch("[^\n]+") do
			local accel = choice:match("&(.)")
			local display = choice:gsub("&", "")
			table.insert(choice_list, display)
			if accel then
				accelerators[accel:lower()] = #choice_list
			end
		end

		-- Create buffer with choices
		local buf = vim.api.nvim_create_buf(false, true)
		local display_lines = {}
		for i, c in ipairs(choice_list) do
			table.insert(display_lines, string.format(" %d. %s ", i, c))
		end
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, display_lines)

		-- Calculate window size
		local max_width = #msg + 4
		for _, line in ipairs(display_lines) do
			max_width = math.max(max_width, #line + 2)
		end
		local width = math.max(40, max_width)
		local height = #choice_list
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
			title = " " .. msg .. " ",
			title_pos = "center",
		})

		-- Buffer/window settings
		vim.bo[buf].modifiable = false
		vim.bo[buf].bufhidden = "wipe"
		vim.wo[win].cursorline = true

		-- Move to default choice
		vim.api.nvim_win_set_cursor(win, { default, 0 })

		local selected = 0

		-- Input loop
		while vim.api.nvim_win_is_valid(win) do
			vim.cmd("redraw")
			local ok, char = pcall(vim.fn.getcharstr)
			if not ok then
				break
			end

			local key = char:lower()
			local cursor = vim.api.nvim_win_get_cursor(win)[1]

			if char == "\27" or key == "q" then
				-- Escape or q - cancel
				selected = 0
				break
			elseif char == "\r" or char == "\n" then
				-- Enter - confirm current selection
				selected = cursor
				break
			elseif key == "j" or char == "\80" then
				-- j or Down arrow
				local new_pos = math.min(cursor + 1, #choice_list)
				vim.api.nvim_win_set_cursor(win, { new_pos, 0 })
			elseif key == "k" or char == "\72" then
				-- k or Up arrow
				local new_pos = math.max(cursor - 1, 1)
				vim.api.nvim_win_set_cursor(win, { new_pos, 0 })
			elseif accelerators[key] then
				-- Accelerator key (e.g., 'y' for "&Yes")
				selected = accelerators[key]
				break
			elseif tonumber(key) and tonumber(key) >= 1 and tonumber(key) <= #choice_list then
				-- Number key
				selected = tonumber(key)
				break
			end
		end

		-- Close window if still open
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end

		return selected
	end
end

return M
