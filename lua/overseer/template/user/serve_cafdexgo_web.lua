return {
	name = "Serve CAFDExGo Web",
	builder = function()
		return {
			cwd = "X:/dev/cafdexgo-web/",
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
