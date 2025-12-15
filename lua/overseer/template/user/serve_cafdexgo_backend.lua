return {
	name = "Serve CAFDExGo Backend",
	builder = function()
		return {
			cmd = { "dotnet" },
			cwd = "X:/dev/cafdexgo-api/",
			args = {
				"watch",
				"run",
				"--property",
				"GenerateFullPaths=true",
			},
			components = {
				-- { "restart_on_save", paths = { workspaceRoot } },
				-- { "on_output_quickfix", set_diagnostics = true },
				-- "on_result_diagnostics",
			},
		}
	end,
}
