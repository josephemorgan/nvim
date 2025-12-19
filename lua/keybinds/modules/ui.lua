return {
	"<leader>u",
	group = "[u]i",
	-- Set up in snacks.lua
	{
		"<leader>uh",
		function()
			require("snacks").notifier.show_history()
		end,
		desc = "Show Notification [h]istory",
	},
}
