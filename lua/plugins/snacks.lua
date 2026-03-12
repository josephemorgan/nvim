return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		terminal = { enabled = false },
		---@class snacks.zen.Config
		zen = {
			toggles = {
				dim = false,
				git_signs = false,
				mini_diff_signs = false,
				diagnostics = true,
			},
		},
		input = { enabled = false },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		---@class snacks.statuscolumn.Config
		statuscolumn = { enabled = false },
		toggle = { enabled = true },
		-- notifier = {
		-- 	enabled = true,
		-- },
		explorer = {
			replace_netrw = true,
		},
		-- picker = {
		-- 	sources = {
		-- 		explorer = {},
		-- 	},
		-- 	projects = {
		-- 		finder = "recent_projects",
		-- 		format = "file",
		-- 		-- dev = { "X:/dev/" },
		-- 	},
		-- },
		words = {
			enabled = true,
		},
		-- {
		-- 	"folke/edgy.nvim",
		-- 	---@module 'edgy'
		-- 	---@param opts Edgy.Config
		-- 	opts = function(_, opts)
		-- 		for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
		-- 			opts[pos] = opts[pos] or {}
		-- 			table.insert(opts[pos], {
		-- 				ft = "snacks_terminal",
		-- 				size = { height = 0.4 },
		-- 				title = "%{b:snacks_terminal.id}: %{b:term_title}",
		-- 				filter = function(_buf, win)
		-- 					return vim.w[win].snacks_win
		-- 						and vim.w[win].snacks_win.position == pos
		-- 						and vim.w[win].snacks_win.relative == "editor"
		-- 						and not vim.w[win].trouble_preview
		-- 				end,
		-- 			})
		-- 		end
		-- 	end,
		-- },
	},
	init = function()
		require("snacks").toggle.indent():map("<leader>ui")
		require("snacks").toggle.zen():map("<leader>ue")
		require("snacks").toggle.zoom():map("<leader>uz")
		require("snacks").toggle.dim():map("<leader>ud")
	end,
}
