local snacks = require("snacks")

return {
	"<leader>b",
	group = "[b]uffer",
	{
		"<leader>bf",
		function()
			require("conform").format()
		end,
		desc = "Format [f]ile",
	},
	{
		"<leader>bF",
		function()
			vim.g.disable_autoformat = not vim.g.disable_autoformat
		end,
		desc = "Toggle auto[F]ormat on save",
	},
	{
		"<leader>bs",
		function()
			snacks.scratch()
		end,
		desc = "Toggle [s]cratch buffer",
	},
	{
		"<leader>bS",
		function()
			snacks.scratch.select()
		end,
		desc = "[S]elect scratch buffer",
	},
	{
		"<leader>bd",
		function()
			snacks.bufdelete.delete()
		end,
		desc = "[d]elete buffer",
	},
	{
		"<leader>bn",
		function()
			vim.cmd("Navbuddy")
		end,
		desc = "buffer [n]av",
	},
	{
		"<leader>be",
		function()
			-- Exit visual mode first to set '< and '> marks
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)

			vim.schedule(function()
				-- Get the visual selection marks
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")

				-- Get selected lines
				local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)

				if #lines == 0 then
					vim.notify("No selection found", vim.log.levels.WARN)
					return
				end

				-- Trim first and last line to selection bounds
				if #lines == 1 then
					lines[1] = lines[1]:sub(start_pos[3], end_pos[3])
				else
					lines[1] = lines[1]:sub(start_pos[3])
					lines[#lines] = lines[#lines]:sub(1, end_pos[3])
				end

				local code = table.concat(lines, "\n")

				-- Execute the code
				local func, err = loadstring(code)
				if not func then
					vim.notify("Lua syntax error: " .. err, vim.log.levels.ERROR)
					return
				end

				local ok, result = pcall(func)
				if ok then
					if result ~= nil then
						vim.notify(vim.inspect(result), vim.log.levels.INFO)
					else
						vim.notify("Executed successfully (no return value)", vim.log.levels.INFO)
					end
				else
					vim.notify("Lua runtime error: " .. tostring(result), vim.log.levels.ERROR)
				end
			end)
		end,
		desc = "[e]valuate lua",
	},
}
