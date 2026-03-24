return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load which-key types when the `wk` word is found
				{ path = "which-key.nvim", words = { "wk" } },
			},
		},
	},
}
