---@type LangModule
return {
	filetypes = { "dart" },
	spec = {
		"<leader>f",
		group = "Framework - flutter",
		{
			"<leader>fc",
			function()
				require("telescope").extensions.flutter.commands()
			end,
			desc = "[c]ommands",
		},
	},
}
