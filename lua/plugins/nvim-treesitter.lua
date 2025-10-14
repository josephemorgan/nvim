return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			vim.list_extend(opts.ensure_installed, {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"elixir",
				"heex",
				"javascript",
				"typescript",
				"html",
				"python",
				"diff",
				"markdown",
				"markdown_inline",
				"angular",
				"scss",
				"csharp",
			})
		end

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
			pattern = { "*.component.html" },
			callback = function()
				vim.treesitter.start(nil, "angular")
			end,
		})
	end,
}
