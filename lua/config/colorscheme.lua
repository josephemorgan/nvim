-- Colorscheme and appearance configuration
local M = {}

function M.setup()
	if vim.g.neovide then
		require("neovide").setup()
	else
		-- Set transparent background for terminal
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	end

	vim.cmd.colorscheme("jellybeans-default")
end

return M
