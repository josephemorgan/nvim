return {
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		keys = {
			{ "<leader>t", ":NvimTreeToggle<CR>", desc = "Toggle Tree" },
		},
		config = function()
			require("nvim-tree").setup({
				hijack_cursor = false,
				disable_netrw = true,
				reload_on_bufenter = true,
			})
		end,
}
