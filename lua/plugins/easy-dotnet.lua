return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	cond = function()
		return vim.fn.executable("dotnet") == 1
	end,
	opts = {
		debugger = {
			mappings = {
				open_variable_viewer = { lhs = "T", desc = "open variable viewer" },
			},
		},
	},
}
