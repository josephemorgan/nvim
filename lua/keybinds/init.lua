---@type wk.Spec
return {
	-- Misc
	{
		"K",
		function()
			local bufnr = vim.api.nvim_get_current_buf()
			local win = vim.api.nvim_get_current_win()
			local lnum = vim.fn.line(".") - 1
			local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

			-- Format diagnostics as markdown
			local lines = {}
			if #diagnostics > 0 then
				for _, d in ipairs(diagnostics) do
					local severity = vim.diagnostic.severity[d.severity]
					table.insert(lines, string.format("**[%s]** %s", severity, d.message))
				end
				table.insert(lines, "---")
			end

			-- Make raw hover request, combine with diagnostics, show in one float
			local params = vim.lsp.util.make_position_params(win, "utf-16")
			vim.lsp.buf_request(bufnr, "textDocument/hover", params, function(_, result)
				if result and result.contents then
					local hover_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
					vim.list_extend(lines, hover_lines)
				end
				if #lines > 0 then
					vim.lsp.util.open_floating_preview(lines, "markdown", { focus = false })
				end
			end)
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
