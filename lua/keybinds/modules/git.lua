return {
	"<leader>g",
	group = "[g]it",
	{
		"<leader>gg",
		function()
			require("neogit").open()
		end,
		desc = "Open neo[g]it",
	},
	{ "<leader>gd", ":DiffviewOpen<cr>", desc = "Open [d]iffview" },
	{
		"<leader>gh",
		function()
			local filename = vim.api.nvim_buf_get_name(0)
			if filename ~= "" then
				vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(filename))
			else
				vim.cmd("DiffviewFileHistory")
			end
		end,
		desc = "Open current file [h]istory",
	},

	{
		"<leader>gl",
		function()
			snacks.git.blame_line()
		end,
		desc = "[b]lame file",
	},
	{ "<leader>gb", ":Blame<cr>", desc = "[b]lame file" },
}
