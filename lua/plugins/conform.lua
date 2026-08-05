return {
	"stevearc/conform.nvim",
	---@module "conform",
	---@type conform.setupOpts
	opts = {
		format_on_save = function(buf)
			if vim.g.disable_autoformat == true then
				return
			end
			return {
				timeout_ms = 5000,
			}
		end,
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettier" },
			htmlangular = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			-- `dart format` CLI, not LSP formatting: the analysis server can be mid-relink
			-- on a large project and block the save for the full timeout.
			dart = { "dart_format" },
			cs = { "csharpier" },
			json = { "fixjson" },
			nginx = { "nginxfmt" },
			["*"] = { "trim_whitespace" },
		},
		formatters = {
			csharpier = {
				command = "csharpier",
				args = { "format", "--write-stdout" },
				stdin = true,
			},
		},
	},
}
