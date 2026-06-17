-- Placeholder: flesh out with build/run/test once dotnet tooling is chosen.
---@type LangModule
return {
	filetypes = { "cs" },
	spec = {
		"<leader>f",
		group = "Framework - dotnet",
		{
			"<leader>fh",
			function()
				vim.notify("dotnet <leader>f keymaps: TODO", vim.log.levels.INFO)
			end,
			desc = "[h]ello (placeholder)",
		},
	},
}
