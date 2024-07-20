return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-dap.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
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
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
		})

        require("telescope").load_extension('fzf');
		-- require("telescope").load_extension("dap")
	end,
	keys = {},
}
