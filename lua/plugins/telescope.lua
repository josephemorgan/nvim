return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			pickers = {
				find_files = {
					follow = false,
					hidden = true,
				},
				buffers = {
					mappings = {
						i = {
							["<c-d>"] = require("telescope.actions").delete_buffer
								+ require("telescope.actions").move_to_top,
						},
						n = {
							["d"] = require("telescope.actions").delete_buffer
								+ require("telescope.actions").move_to_top,
						},
					},
				},
			},
			extensions = {
				file_browser = {
					theme = "ivy",
					respect_gitignore = false,
				},
				project = {
					base_dirs = {
						"~/dev",
					},
				},
			},
			colorscheme = {
				enable_preview = true,
			},
		},
	},
}
