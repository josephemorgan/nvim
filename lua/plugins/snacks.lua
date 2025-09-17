return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		input = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		toggle = { enabled = true },
		picker = {
			projects = {
				finder = "recent_projects",
				format = "file",
				dev = { "C:\\Users\\morganj\\dev\\" },
			},
		},
	},
}
