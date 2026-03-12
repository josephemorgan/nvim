return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		{
			"sindrets/diffview.nvim",
			opts = {
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = "diff4_mixed",
					},
				},
				keymaps = {
					view = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					},
					file_panel = {
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					},
				},
			},
		},
	},
	opts = {
		integrations = {
			diffview = true,
		},
	},
}
