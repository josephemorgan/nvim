return {
	"mhartington/formatter.nvim",
	lazy = false,
	config = function()
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.TRACE,
			filetype = {
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				typescript = {
					require("formatter.filetypes.typescript").prettier,
				},
			},
		})

		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
