return {
	name = "Serve CAFDExGo Backend",
	builder = function()
		return {
			cmd = { "dotnet" },
			cwd = vim.uv.os_uname().sysname:match("Windows") and "X:/dev/cafdexgo-workspace/cafdexgo-api/"
				or vim.fn.expand("~/dev/cafdexgo-workspace/cafdexgo_api/"),
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
