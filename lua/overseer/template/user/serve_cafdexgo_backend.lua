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
				"--urls",
				"http://0.0.0.0:5000;https://0.0.0.0:5001",
			},
			components = {
				-- { "restart_on_save", paths = { workspaceRoot } },
				-- { "on_output_quickfix", set_diagnostics = true },
				-- "on_result_diagnostics",
			},
		}
	end,
}
