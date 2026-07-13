return {
	name = "Serve CAFDExGo Backend",
	builder = function()
		local root = vim.uv.os_uname().sysname:match("Windows") and "X:/dev/cafdexgo-api/"
			or vim.fn.expand("~/dev/iti/cafdexgo_api/")

		return {
			cmd = { "dotnet" },
			-- cwd = "X:/dev/cafdexgo-api/",
			cwd = root,
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
