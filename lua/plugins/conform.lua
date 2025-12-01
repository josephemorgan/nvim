return {
	"stevearc/conform.nvim",
	---@module "conform",
	---@type conform.setupOpts
	opts = {
		format_on_save = function(buf)
			vim.notify("Autoformat on save for buffer " .. buf)
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
			dart = { lsp_format = "prefer", async = true },
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
