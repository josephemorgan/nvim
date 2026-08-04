return {
	name = "Serve CAFDExGo Web",
	builder = function()
		local root = vim.uv.os_uname().sysname:match("Windows") and "X:/dev/cafdexgo-web/"
			or vim.fn.expand("~/dev/iti/cafdexgo_web/")

		return {
			cmd = { "yarn" },
			cwd = root,
			args = {
				"start",
			},
			components = {
				-- { "restart_on_save", paths = { workspaceRoot } },
				-- { "on_output_quickfix", set_diagnostics = true },
				-- "on_result_diagnostics",
			},
		}
	end,
}
