---@type wk.Spec
return {
	-- Misc
	{
		"K",
		function()
			require("hover").hover()
		end,
		desc = "Show [K]ind",
	},
	{ "<leader>/", ":noh<CR>", desc = "Clear [s]earch" },
	require("keybinds.modules.ai"),
	require("keybinds.modules.ui"),
	require("keybinds.modules.trouble"),
	require("keybinds.modules.git"),
	require("keybinds.modules.buffers"),
	require("keybinds.modules.search"),
	require("keybinds.modules.tasks"),
	require("keybinds.modules.lsp"),
	require("keybinds.modules.dap"),
	require("keybinds.modules.db"),
	require("keybinds.modules.terminal"),
}
