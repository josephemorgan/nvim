---@type wk.Spec
return {
	-- Misc
	{
		"K",
		function()
			local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
			if diagnostics and #diagnostics > 0 then
				vim.diagnostic.open_float(nil, { focus = false })
			else
				vim.lsp.buf.hover()
			end
		end,
		desc = "Show [K]ind",
	},
	{ "<leader>/", ":noh<CR>", desc = "Clear [s]earch" },
	require("keybinds.modules.ai"),
	require("keybinds.modules.ui"),
	require("keybinds.modules.trouble"),
	require("keybinds.modules.git"),
	require("keybinds.modules.buffers"),
	require("keybinds.modules.angular"),
	require("keybinds.modules.search"),
	require("keybinds.modules.tasks"),
	require("keybinds.modules.lsp"),
	require("keybinds.modules.dap"),
}
