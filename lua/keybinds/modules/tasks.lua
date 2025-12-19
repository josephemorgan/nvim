return {
	"<leader>t",
	group = "[t]asks",
	{
		"<leader>tt",
		function()
			require("overseer").toggle({ direction = "left" })
		end,
		desc = "[t]oggle tasks",
	},
	{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "[r]un task" },
	{
		"<leader>tl",
		function()
			require("overseer").load_template()
		end,
		desc = "[l]oad task template",
	},
}
