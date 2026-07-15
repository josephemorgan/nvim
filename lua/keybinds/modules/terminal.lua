return {
	"<leader>e",
	group = "T[e]rminal",
	{
		"<leader>et",
		function()
			require("snacks").terminal()
		end,
		desc = "Toggle [t]erminal",
	},
	{
		"<leader>ef",
		function()
			require("snacks").terminal.focus()
		end,
		desc = "[f]ocus terminal",
	},
	{
		"<leader>el",
		function()
			require("snacks").terminal.list()
		end,
		desc = "[l]ist terminals",
	},
}
