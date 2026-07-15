return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			defaults = {
				path_display = function(_, path)
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
							["<c-d>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
						},
						n = {
							["d"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
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
						os.getenv("DEV_DIR"),
						vim.fn.stdpath("config"),
					},
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						previewer = false,
					}),
				},
			},
			colorscheme = {
				enable_preview = true,
			},
		},
	},
	{
		"nvim-telescope/telescope-project.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("project")
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
}
