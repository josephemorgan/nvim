return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 5000,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettier" },
			dart = { lsp_format = "prefer", async = true },
			cs = { "csharpier" },
			json = { "fixjson" },
			["*"] = { "trim_whitespace" },
		},
		formatters = {
			csharpier = {
				command = "csharpier",
				args = { "--stdin", "--stdout" },
				stdin = true,
			},
		},
	},
}
