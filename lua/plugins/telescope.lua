local dev_dir = os.getenv("DEV_DIR")
local novim_config_dir = vim.fn.stdpath("config")

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			defaults = {
				path_display = function(opts, path)
					return path,
						{
							{
								{
									0, -- highlight start position
									#path - #require("telescope.utils").path_tail(path) - 1, -- highlight end position
								},
								"TelescopeResultsComment", -- highlight group name
							},
						}
				end,
			},
			pickers = {
				find_files = {
					follow = false,
					hidden = false,
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
					hijack_netrw = true,
				},
				project = {
					base_dirs = {
						dev_dir,
						novim_config_dir,
					},
				},
			},
			colorscheme = {
				enable_preview = true,
			},
		},
	},
}
