return {
	name = "dotnet watch",
	desc = "Watch and run a .dotnet application",
	condition = {
		filetype = { "cs" },
	},
	builder = function()
		return {
			cmd = { "dotnet" },
			args = {
				"watch",
				"run",
				"--property",
				"GenerateFullPaths=true",
			},
			components = {
				-- { "on_output_quickfix", set_diagnostics = true },
				-- "on_result_diagnostics",
			},
		}
	end,
}
