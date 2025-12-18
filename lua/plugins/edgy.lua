return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		-- vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,
	opts = {
		bottom = {
			ft = "snacks_terminal",
			size = { height = 0.2 },
		},
	},
}
