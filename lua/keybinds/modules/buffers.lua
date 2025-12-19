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
}
