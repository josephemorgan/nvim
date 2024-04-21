return {
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-dap.nvim" },
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						follow = true,
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
			})

			-- require("telescope").load_extension("dap")
		end,
		keys = {
			{ "<c-p>", ":lua require('telescope.builtin').find_files()<CR>", desc = "Search Files" },
			{ "<f34>", ":lua require('telescope.builtin').buffers()<CR>", desc = "Search Buffers" },
			{ "<leader>fg", ":lua require('telescope.builtin').live_grep()<CR>", desc = "Search File Contents" },
			{ "<leader>fh", ":lua require('telescope.builtin').help_files()<CR>", desc = "Search Help" },
			{ "<leader>fm", ":lua require('telescope.builtin').man_pages()<CR>", desc = "Search Help" },
		},
}
