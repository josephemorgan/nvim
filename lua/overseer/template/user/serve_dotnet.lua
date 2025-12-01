return {
	name = "Serve API",
	desc = "Run the CAFDExGO API server with dotnet watch",
	condition = {
		filetype = { "cs" },
	},
	builder = function()
		local workspaceRoot = vim.fn.getcwd()

		return {
			cmd = { "dotnet" },
			args = {
				"run",
				"--property",
				"GenerateFullPaths=true",
			},
			components = {
				{ "restart_on_save", paths = { workspaceRoot } },
				-- { "on_output_quickfix", set_diagnostics = true },
				-- "on_result_diagnostics",
			},
		}
	end,
}
