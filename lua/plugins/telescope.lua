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
	keys = {},
}
