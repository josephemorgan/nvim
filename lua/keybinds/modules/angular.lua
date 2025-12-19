return {
	"<leader>a",
	group = "[a]ngular",
	{
		"<leader>at",
		function()
			local file = vim.api.nvim_buf_get_name(0)
			local fname = vim.fn.fnamemodify(file, ":t")
			local base = fname:match("^(.*%.component)%..*$")
			if base then
				vim.notify("Opening template: " .. base .. ".html")
				local dir = vim.fn.fnamemodify(file, ":h")
				local template_path = dir .. "/" .. base .. ".html"
				vim.cmd("edit " .. vim.fn.fnameescape(template_path))
			end
		end,
		desc = "Angular Component [t]emplate File",
	},
	{
		"<leader>ac",
		function()
			local file = vim.api.nvim_buf_get_name(0)
			local fname = vim.fn.fnamemodify(file, ":t")
			local base = fname:match("^(.*%.component)%..*$")
			if base then
				vim.notify("Opening component file: " .. base .. ".ts", vim.log.levels.INFO)
				local dir = vim.fn.fnamemodify(file, ":h")
				local template_path = dir .. "/" .. base .. ".ts"
				vim.cmd("edit " .. vim.fn.fnameescape(template_path))
			end
		end,
		desc = "Angular Component [c]omponent File",
	},
	{
		"<leader>as",
		function()
			local file = vim.api.nvim_buf_get_name(0)
			local fname = vim.fn.fnamemodify(file, ":t")
			local base = fname:match("^(.*%.component)%..*$")
			if base then
				vim.notify("Opening style file: " .. base .. ".scss", vim.log.levels.INFO)
				local dir = vim.fn.fnamemodify(file, ":h")
				local template_path = dir .. "/" .. base .. ".scss"
				vim.cmd("edit " .. vim.fn.fnameescape(template_path))
			end
		end,
		desc = "Angular Component [s]tyle File",
	},
}
