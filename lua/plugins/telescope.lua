return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			defaults = {
				path_display = function(opts, path)
					-- local tail = require("telescope.utils").path_tail(path)
					-- return string.format("%s (%s)", tail, path)
					-- local utils = require("telescope.utils")
					-- local tail = utils.path_tail(path) -- filename.ext
					-- local dir = path:sub(1, #path - #tail) -- path/to/dirs/
					--
					-- if dir == "" then
					-- 	-- Nothing to dim (just a filename)
					-- 	return tail
					-- end
					--
					-- -- Compose "filename  path/to/dirs/"
					-- -- local display = tail .. "  " .. dir
					-- local display = dir .. tail
					--
					-- -- Highlight only the directory part as dimmed.
					-- -- Indices are 0-based; start right after "tail  ".
					-- local highlights = {
					-- 	{
					-- 		{ #dir + 2, #display },
					-- 		"Comment", -- or "TelescopeResultsComment" if you prefer
					-- 	},
					-- }
					--
					-- return display, highlights
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
