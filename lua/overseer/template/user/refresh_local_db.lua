---@module 'overseer'
---@type overseer.TemplateFileDefinition
return {
	name = "Refresh Local DB From New Backup",
	params = {
		mode = {
			desc = "Choose refresh mode",
			type = "enum",
			choices = { "Full", "Fetch" },
		},
	},
	builder = function(params)
		return {
			cwd = "X:/dev/cafdexgo-web/",
			cmd = { "powershell.exe" },

			args = {
				"-ExecutionPolicy",
				"Bypass",
				"-File",
				"./RefreshLocalDb.ps1",
				params.mode,
			},
			components = {
				-- { "restart_on_save", paths = { workspaceRoot } },
				-- { "on_output_quickfix", set_diagnostics = true },
				-- "on_result_diagnostics",
			},
		}
	end,
}
