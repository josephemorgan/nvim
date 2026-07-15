local picker_config = require("keybinds.modules.picker_config")

return {
	"<leader>g",
	group = "[g]it",
	{
		"<leader>gg",
		function()
			require("neogit").open({ kind = "split_above_all" })
		end,
		desc = "Open neo[g]it",
	},
	{ "<leader>gd", ":DiffviewOpen<cr>", desc = "Open [d]iffview" },
	{
		"<leader>gh",
		function()
			picker_config.git_history()
		end,
		desc = "Preview File [h]istory",
	},
	{
		"<leader>gH",
		function()
			local filename = vim.api.nvim_buf_get_name(0)
			if filename ~= "" then
				vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(filename))
			else
				vim.cmd("DiffviewFileHistory")
			end
		end,
		desc = "Open File [H]istory",
	},
	{
		"<leader>gl",
		function()
			picker_config.git_line_history()
		end,
		desc = "[b]lame file",
	},
	{ "<leader>gb", ":Blame<cr>", desc = "[b]lame file" },
}
