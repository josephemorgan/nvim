return {
	name = "Scaffold DBContext",
	builder = function()
		return {
			cwd = "X:/dev/cafdexgo-api/",
			cmd = { "dotnet ef dbcontext scaffold" },
			args = {
				"Server=.;Database=CAFDExGO;Trusted_Connection=True;TrustServerCertificate=True;",
				"Microsoft.EntityFrameworkCore.SqlServer",
				"--no-pluralize",
				"--output-dir Models",
				"--context CAFDExGOContext",
				"--no-onconfiguring",
				"--force",
			},
			components = {},
		}
	end,
}
