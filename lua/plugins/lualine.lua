local function dap_status()
	local ok, dap = pcall(require, "dap")
	if not ok then
		return ""
	end
	local sessions = dap.sessions()
	if not sessions or vim.tbl_isempty(sessions) then
		return ""
	end
	local current = dap.session()
	local name = (current and current.config and current.config.name) or "?"
	local count = vim.tbl_count(sessions)
	if count > 1 then
		return string.format(" %s [%d]", name, count)
	end
	return string.format(" %s", name)
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				"filename",
				{
					dap_status,
					cond = function()
						local ok, dap = pcall(require, "dap")
						return ok and not vim.tbl_isempty(dap.sessions())
					end,
				},
			},
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		path = 1,
	},
}
