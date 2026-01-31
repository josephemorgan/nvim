return {
	"codethread/qmk.nvim",
	lazy = false,
	config = function()
		vim.api.nvim_create_user_command("KyriaFormat", function()
			require("qmk").setup({
				name = "LAYOUT",
				layout = {
					"_ x x x x x x _ _ _ _ _ x x x x x x",
					"_ x x x x x x _ _ _ _ _ x x x x x x",
					"_ x x x x x x x x _ x x x x x x x x",
					"_ _ _ _ x x x x x _ x x x x x _ _ _",
				},
			})
		end, { desc = "Format Kyria keymap" })

		vim.api.nvim_create_user_command("PlanckFormat", function()
			require("qmk").setup({
				name = "LAYOUT_planck_grid",
				layout = {
					"x x x x x x x x x x x x",
					"x x x x x x x x x x x x",
					"x x x x x x x x x x x x",
					"x x x x x x x x x x x x",
				},
			})
		end, { desc = "Format Planck keymap" })
	end,
}
