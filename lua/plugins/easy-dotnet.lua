return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	cond = function()
		return vim.fn.executable("dotnet") == 1
	end,
	opts = {
		---@diagnostic disable-next-line: missing-fields
		lsp = {
			-- Suppresses the "N references" code lens above declarations.
			-- easy-dotnet opts C# buffers into vim.lsp.codelens on attach; this
			-- gate is checked before it registers its re-enable autocmds, so it
			-- is the only durable off switch. The tests lens is already off in
			-- easy-dotnet's default Roslyn settings.
			auto_refresh_codelens = false,
		},
	},
}
