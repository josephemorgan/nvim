return {
	name = "Serve CAFDExGo Web",
	builder = function()
		return {
			cwd = vim.uv.os_uname().sysname:match("Windows") and "X:/dev/cafdexgo-workspace/cafdexgo-web/"
				or vim.fn.expand("~/dev/cafdexgo-workspace/cafdexgo_web/"),
			cmd = { "yarn" },
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
