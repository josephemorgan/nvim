return {
	{
		"stevearc/overseer.nvim",
		-- branch = "stevearc-rewrite",
		dev = true,
		opts = {
			task_list = {
				max_height = 40,
				0.25,
			},
			templates = { "builtin", "user.ps_shell" },
		},
	},
}
